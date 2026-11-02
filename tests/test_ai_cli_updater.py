"""Offline integrity and publication regressions for the release updater."""
import hashlib
import importlib.util
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch


SOURCE = Path(__file__).resolve().parents[1] / "app-portage/qinda-ai-cli-updater/files/qinda-ai-cli-update.py"
SPEC = importlib.util.spec_from_file_location("qinda_ai_update", SOURCE)
updater = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = updater
PREVIOUS_BYTECODE_SETTING = sys.dont_write_bytecode
sys.dont_write_bytecode = True
SPEC.loader.exec_module(updater)
sys.dont_write_bytecode = PREVIOUS_BYTECODE_SETTING


class ReleaseTests(unittest.TestCase):
    def codex_metadata(self):
        return {"tag_name": "rust-v0.166.0", "assets": [{
            "name": updater.CODEX_ASSET, "digest": "sha256:" + "a" * 64,
            "browser_download_url": f"{updater.CODEX_BASE}/releases/0.166.0/{updater.CODEX_ASSET}",
        }]}

    def test_only_stable_versions_can_enter_urls_and_recipes(self):
        for value in ["../1.2.3", "1.2.3-alpha.1", "1.2", "1.2.3\n", "1.2.3;id", None]:
            with self.subTest(value=value), self.assertRaises(ValueError):
                updater.version(value)
        self.assertEqual(updater.version("0.166.0"), (0, 166, 0))

    def test_codex_requires_matching_tag_digest_and_official_url(self):
        channel = {"tag_name": "rust-v0.166.0"}
        self.assertEqual(updater.codex_release(channel, self.codex_metadata()).version, "0.166.0")
        for field, value in [("digest", ""), ("browser_download_url", "https://example.com/binary")]:
            metadata = self.codex_metadata()
            metadata["assets"][0][field] = value
            with self.subTest(field=field), self.assertRaises(ValueError):
                updater.codex_release(channel, metadata)
        with self.assertRaises(ValueError):
            updater.codex_release({"tag_name": "rust-v0.165.0"}, self.codex_metadata())

    def test_claude_requires_all_supported_platforms_and_matching_version(self):
        metadata = {"version": "2.1.316", "platforms": {
            p: {"binary": "claude", "size": 3, "checksum": "a" * 64}
            for p in updater.CLAUDE_PLATFORMS}}
        self.assertEqual(len(updater.claude_release("2.1.316", metadata).assets), 4)
        with self.assertRaises(ValueError):
            updater.claude_release("2.1.315", metadata)
        del metadata["platforms"]["linux-arm64-musl"]
        with self.assertRaises(KeyError):
            updater.claude_release("2.1.316", metadata)

    def test_corrupt_cached_payload_is_preserved_and_rejected(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            target = root / "binary"
            target.write_bytes(b"corrupt")
            asset = updater.Asset("https://example.com/binary", "binary", hashlib.sha256(b"valid").hexdigest())
            with patch.object(updater, "run") as run, self.assertRaises(ValueError):
                updater.fetch_asset(asset, root)
            run.assert_not_called()
            self.assertEqual(target.read_bytes(), b"corrupt")

    def test_bad_download_never_becomes_a_distfile(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            asset = updater.Asset("https://example.com/binary", "binary", hashlib.sha256(b"valid").hexdigest())
            def download(*args, **kwargs):
                Path(args[args.index("--output") + 1]).write_bytes(b"invalid")
            with patch.object(updater, "run", side_effect=download), self.assertRaises(ValueError):
                updater.fetch_asset(asset, root)
            self.assertEqual(list(root.iterdir()), [])

    def test_size_is_checked_as_well_as_checksum(self):
        with tempfile.TemporaryDirectory() as name:
            target = Path(name) / "binary"
            target.write_bytes(b"valid")
            with self.assertRaises(ValueError):
                updater.verify_asset(target, updater.Asset("unused", "binary", hashlib.sha256(b"valid").hexdigest(), 6))


class RecipeTests(unittest.TestCase):
    def test_no_downgrade_and_highest_revision_is_the_template(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            package = root / "dev-util/codex-bin"
            package.mkdir(parents=True)
            for ver in ["0.163.0", "0.163.0-r1", "0.162.1"]:
                (package / f"codex-bin-{ver}.ebuild").write_text("EAPI=8\n")
            current, recipe = updater.latest_recipe(root, "codex-bin")
            self.assertEqual(current, "0.163.0")
            self.assertEqual(recipe.name, "codex-bin-0.163.0-r1.ebuild")
            self.assertEqual(updater.pending_releases(root, [updater.Release("codex-bin", current, ())]), [])
            with self.assertRaises(ValueError):
                updater.pending_releases(root, [updater.Release("codex-bin", "0.162.1", ())])

    def test_delivery_keeps_unrelated_packages_and_is_idempotent(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            (root / "metadata").mkdir()
            path = root / "metadata/qinda-delivery"
            path.write_text("# delivery\n=dev-util/codex-bin-0.163.0\n=other/package-42\n=dev-util/claude-code-2.1.289\n")
            releases = (updater.Release("codex-bin", "0.166.0", ()), updater.Release("claude-code", "2.1.316", ()))
            self.assertTrue(updater.update_delivery(root, releases))
            self.assertIn("=other/package-42\n", path.read_text())
            self.assertFalse(updater.update_delivery(root, releases))

    def test_manifest_rewrite_is_rejected_before_staging(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            package = root / "dev-util/codex-bin"
            package.mkdir(parents=True)
            (package / "codex-bin-0.163.0.ebuild").write_text("EAPI=8\n")
            (package / "Manifest").write_text("DIST historical 1 SHA512 original\n")
            def corrupt_manifest(*args, **kwargs):
                (package / "Manifest").write_text("DIST historical 1 SHA512 changed\n")
            release = updater.Release("codex-bin", "0.166.0", ())
            with patch.object(updater, "run", side_effect=corrupt_manifest), patch.object(updater, "stage_check") as stage:
                with self.assertRaisesRegex(ValueError, "historical checksums"):
                    updater.prepare(root, [release], root, root)
                stage.assert_not_called()


class PublicationTests(unittest.TestCase):
    def test_concurrent_hub_commit_is_never_overwritten(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            hub, seed, competing = root / "hub.git", root / "seed", root / "competing"
            env = dict(os.environ, GIT_AUTHOR_NAME="Fixture", GIT_AUTHOR_EMAIL="fixture@example.invalid",
                       GIT_COMMITTER_NAME="Fixture", GIT_COMMITTER_EMAIL="fixture@example.invalid",
                       XDG_CACHE_HOME=str(root / "cache"))
            def git(*args):
                return subprocess.run(["git", *map(str, args)], check=True, env=env, capture_output=True, text=True).stdout.strip()
            git("init", "--bare", "--initial-branch=master", hub)
            git("clone", hub, seed)
            (seed / "initial").write_text("initial\n")
            git("-C", seed, "add", "initial")
            git("-C", seed, "commit", "-m", "Initial")
            git("-C", seed, "push", "origin", "master")
            git("clone", hub, competing)
            def prepare(repository, releases, distdir, temporary):
                (repository / "candidate").write_text("candidate\n")
                (competing / "other-work").write_text("preserve\n")
                git("-C", competing, "add", "other-work")
                git("-C", competing, "commit", "-m", "Concurrent work")
                git("-C", competing, "push", "origin", "master")
                return [Path("candidate")]
            argv = ["updater", "--publish", "--hub", str(hub), "--checkout", str(root / "absent"), "--laptop", ""]
            with patch.dict(os.environ, env), patch.object(sys, "argv", argv), patch.object(updater.socket, "gethostname", return_value="qinda"), patch.object(updater.os, "geteuid", return_value=1000), patch.object(updater, "latest_releases", return_value=()), patch.object(updater, "prepare", side_effect=prepare), patch.object(updater, "refresh_consumers") as refresh:
                with self.assertRaises(subprocess.CalledProcessError):
                    updater.main()
                refresh.assert_not_called()
            self.assertEqual(git("-C", hub, "rev-parse", "master"), git("-C", competing, "rev-parse", "HEAD"))
            self.assertEqual(git("-C", hub, "show", "master:other-work"), "preserve")


if __name__ == "__main__":
    unittest.main()
