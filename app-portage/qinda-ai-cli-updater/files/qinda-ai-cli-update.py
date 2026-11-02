#!/usr/bin/env python3
"""Check official Codex/Claude releases and publish verified Portage recipes."""
# SPDX-License-Identifier: GPL-2.0-only
import argparse
from concurrent.futures import ThreadPoolExecutor
from dataclasses import dataclass
import fcntl
import hashlib
import json
import os
from pathlib import Path
import re
import socket
import subprocess
import sys
import tempfile


CODEX_BASE = "https://releases.openai.com/codex"
CLAUDE_BASE = "https://downloads.claude.ai/claude-code-releases"
CODEX_ASSET = "codex-package-x86_64-unknown-linux-musl.tar.gz"
CLAUDE_PLATFORMS = {
    "linux-x64": "amd64-glibc", "linux-x64-musl": "amd64-musl",
    "linux-arm64": "arm64-glibc", "linux-arm64-musl": "arm64-musl",
}


def run(*args, capture=False, **kwargs):
    result = subprocess.run([str(a) for a in args], check=True, text=True,
                            stdout=subprocess.PIPE if capture else None, **kwargs)
    return result.stdout.strip() if capture else None


def version(value):
    if not isinstance(value, str) or not re.fullmatch(r"\d+\.\d+\.\d+", value):
        raise ValueError(f"Expected a stable x.y.z version, got {value!r}")
    return tuple(map(int, value.split(".")))


def digest(value):
    if not isinstance(value, str) or not re.fullmatch(r"[0-9a-f]{64}", value):
        raise ValueError("Missing or invalid upstream SHA256")
    return value


def get(url):
    return run("curl", "--fail", "--location", "--silent", "--show-error",
               "--proto", "=https", "--proto-redir", "=https", "--retry", "2", "--retry-all-errors",
               "--connect-timeout", "20", "--max-time", "120", url, capture=True)


@dataclass(frozen=True)
class Asset:
    url: str
    name: str
    sha256: str
    size: int | None = None


@dataclass(frozen=True)
class Release:
    package: str
    version: str
    assets: tuple[Asset, ...]


def codex_release(channel, metadata):
    tag = channel.get("tag_name", "")
    if not tag.startswith("rust-v"):
        raise ValueError("Codex channel has no release tag")
    ver = tag.removeprefix("rust-v")
    version(ver)
    if metadata.get("tag_name") != tag:
        raise ValueError("Codex channel and pinned release disagree")
    found = [a for a in metadata["assets"] if a.get("name") == CODEX_ASSET]
    if len(found) != 1:
        raise ValueError("Expected exactly one Codex musl bundle")
    asset = found[0]
    url = f"{CODEX_BASE}/releases/{ver}/{CODEX_ASSET}"
    if asset.get("browser_download_url") != url:
        raise ValueError("Codex asset URL does not match the official release")
    sha = digest(asset.get("digest", "").removeprefix("sha256:"))
    return Release("codex-bin", ver, (Asset(url, f"codex-bin-{ver}-linux-musl.tar.gz", sha),))


def claude_release(ver, metadata):
    version(ver)
    if metadata.get("version") != ver:
        raise ValueError("Claude channel and pinned manifest disagree")
    assets = []
    for platform, suffix in CLAUDE_PLATFORMS.items():
        info = metadata["platforms"][platform]
        if info.get("binary") != "claude" or type(info.get("size")) is not int or info["size"] <= 0:
            raise ValueError(f"Invalid Claude manifest entry: {platform}")
        assets.append(Asset(f"{CLAUDE_BASE}/{ver}/{platform}/claude",
                            f"claude-{suffix}-{ver}", digest(info["checksum"]), info["size"]))
    return Release("claude-code", ver, tuple(assets))


def latest_releases():
    channel = json.loads(get(f"{CODEX_BASE}/channels/latest"))
    ver = channel.get("tag_name", "").removeprefix("rust-v")
    version(ver)
    codex = codex_release(channel, json.loads(get(f"{CODEX_BASE}/releases/{ver}/release.json")))
    ver = get(f"{CLAUDE_BASE}/latest").strip()
    version(ver)
    claude = claude_release(ver, json.loads(get(f"{CLAUDE_BASE}/{ver}/manifest.json")))
    return (codex, claude)


def verify_asset(path, asset):
    with path.open("rb") as handle:
        actual = hashlib.file_digest(handle, "sha256").hexdigest()
    if actual != asset.sha256 or (asset.size is not None and path.stat().st_size != asset.size):
        raise ValueError(f"Upstream checksum/size mismatch: {path}")


def fetch_asset(asset, distdir):
    destination = distdir / asset.name
    if destination.exists():
        verify_asset(destination, asset)
        print(f"Verified cached {asset.name}", flush=True)
        return
    print(f"Downloading {asset.name}", flush=True)
    fd, name = tempfile.mkstemp(prefix=f".{asset.name}.", dir=distdir)
    os.close(fd)
    incoming = Path(name)
    try:
        run("curl", "--fail", "--location", "--silent", "--show-error",
            "--proto", "=https", "--proto-redir", "=https", "--retry", "2", "--retry-all-errors",
            "--connect-timeout", "20", "--max-time", "1800", "--output", incoming, asset.url)
        verify_asset(incoming, asset)
        incoming.chmod(0o644)
        try:
            os.link(incoming, destination)
        except FileExistsError:
            verify_asset(destination, asset)
        print(f"Verified {asset.name}", flush=True)
    finally:
        incoming.unlink(missing_ok=True)


def latest_recipe(repository, package):
    candidates = []
    for recipe in (repository / "dev-util" / package).glob(f"{package}-*.ebuild"):
        match = re.fullmatch(re.escape(package) + r"-(\d+\.\d+\.\d+)(?:-r(\d+))?\.ebuild", recipe.name)
        if match:
            candidates.append((version(match[1]), int(match[2] or 0), match[1], recipe))
    if not candidates:
        raise ValueError(f"No existing stable recipe for {package}")
    _, _, ver, recipe = max(candidates)
    return ver, recipe


def pending_releases(repository, releases):
    pending = []
    for release in releases:
        current, recipe = latest_recipe(repository, release.package)
        print(f"{release.package}: overlay {current}, upstream latest {release.version}", flush=True)
        if version(release.version) < version(current):
            raise ValueError(f"Upstream {release.package} channel moved backwards; refusing downgrade")
        if version(release.version) > version(current):
            pending.append((release, recipe))
    return pending


def update_delivery(repository, releases):
    path = repository / "metadata/qinda-delivery"
    original = updated = path.read_text()
    for release in releases:
        updated, count = re.subn(r"^=dev-util/" + re.escape(release.package) + r"-[^\n]+$",
                                 f"=dev-util/{release.package}-{release.version}", updated, flags=re.M)
        if count != 1:
            raise ValueError(f"Expected one delivery entry for {release.package}")
    if updated != original:
        path.write_text(updated)
    return updated != original


def stage_check(recipe, release, env):
    run("ebuild", recipe, "clean", "unpack", "prepare", "compile", "install", env=env)
    image = Path(env["PORTAGE_TMPDIR"]) / "portage/dev-util" / recipe.stem / "image"
    smoke_env = dict(env)
    smoke = Path(env["PORTAGE_TMPDIR"]) / "smoke"
    smoke.mkdir(exist_ok=True)
    smoke_env.update(CODEX_HOME=str(smoke / "codex"), CLAUDE_CONFIG_DIR=str(smoke / "claude"),
                     DISABLE_AUTOUPDATER="1")
    binary = image / ("opt/codex/bin/codex" if release.package == "codex-bin" else "opt/bin/claude")
    reported = run(binary, "--version", capture=True, env=smoke_env, timeout=60)
    if not re.search(r"(?<![\d.])" + re.escape(release.version) + r"(?![\d.])", reported):
        raise ValueError(f"Staged binary reports unexpected version: {reported}")
    run(binary, "--help", capture=True, env=smoke_env, timeout=60)
    print(f"Staged version/help checks passed: {reported}", flush=True)


def prepare(repository, releases, distdir, temporary):
    pending = pending_releases(repository, releases)
    assets = [asset for release, _ in pending for asset in release.assets]
    # Download parallelism is unrelated to build jobs. Never change MAKEOPTS.
    with ThreadPoolExecutor(max_workers=5) as pool:
        list(pool.map(lambda asset: fetch_asset(asset, distdir), assets))
    env = dict(os.environ, DISTDIR=str(distdir), PORTAGE_TMPDIR=str(temporary))
    changed = []
    for release, previous in pending:
        recipe = previous.parent / f"{release.package}-{release.version}.ebuild"
        with recipe.open("x") as handle:
            handle.write(previous.read_text())
        manifest = previous.parent / "Manifest"
        old_rows = set(manifest.read_text().splitlines())
        run("ebuild", recipe, "manifest", env=env)
        if not old_rows <= set(manifest.read_text().splitlines()):
            raise ValueError(f"Manifest generation changed historical checksums: {manifest}")
        stage_check(recipe, release, env)
        changed += [recipe.relative_to(repository), manifest.relative_to(repository)]
    if update_delivery(repository, releases):
        changed.append(Path("metadata/qinda-delivery"))
    if changed:
        run("pkgcheck", "scan", "--exit", "error", "dev-util/codex-bin", "dev-util/claude-code", cwd=repository)
        run("git", "-C", repository, "diff", "--check")
    return changed


def refresh_consumers(hub, checkout, laptop):
    if checkout.is_dir():
        branch = run("git", "-C", checkout, "branch", "--show-current", capture=True)
        dirty = run("git", "-C", checkout, "status", "--porcelain", capture=True)
        if branch == "master" and not dirty:
            try:
                run("git", "-C", checkout, "pull", "--ff-only", hub, "master")
            except subprocess.CalledProcessError:
                print("WARNING: qinda checkout could not fast-forward; its work was preserved.", flush=True)
        else:
            print("qinda checkout has edits or another branch; leaving it untouched.", flush=True)
    if laptop:
        env = dict(os.environ, GIT_SSH_COMMAND="ssh -o BatchMode=yes -o ConnectTimeout=10")
        try:
            run("git", "-C", hub, "push", f"{laptop}:git/QindaGentoo.git", "master:master", env=env, timeout=120)
        except (subprocess.CalledProcessError, subprocess.TimeoutExpired):
            print("WARNING: laptop mirror was not updated; the next daily check will retry.", flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    modes = parser.add_mutually_exclusive_group()
    modes.add_argument("--check", action="store_true", help="only compare releases (the default)")
    modes.add_argument("--prepare", type=Path, metavar="CHECKOUT", help="prepare and verify recipes without publishing")
    modes.add_argument("--publish", action="store_true", help="verify, commit and fast-forward qinda's overlay hub")
    parser.add_argument("--hub", type=Path, default=Path(os.environ.get("QINDA_AI_HUB", str(Path.home() / "git/QindaGentoo.git"))))
    parser.add_argument("--checkout", type=Path, default=Path(os.environ.get("QINDA_AI_CHECKOUT", str(Path.home() / "work_SPaC3/QindaGentoo"))))
    parser.add_argument("--laptop", default=os.environ.get("QINDA_AI_LAPTOP", "qinda-top"), help="mirror SSH alias; empty disables mirroring")
    args = parser.parse_args()
    if os.geteuid() == 0:
        parser.error("Run as the ordinary qinda user, not root; no package installation is performed")
    if args.publish and socket.gethostname().split(".")[0] != "qinda":
        parser.error("Publish on qinda, the source-of-truth machine")
    state = Path(os.environ.get("XDG_CACHE_HOME", str(Path.home() / ".cache"))) / "qinda-ai-cli-updater"
    state.mkdir(parents=True, exist_ok=True)
    with (state / "lock").open("a") as lock:
        try:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            print("Another release check is already running.")
            return
        releases = latest_releases()
        with tempfile.TemporaryDirectory(prefix="run-", dir=state) as name:
            temporary = Path(name)
            repository = args.prepare.resolve() if args.prepare else temporary / "overlay"
            if not args.prepare:
                run("git", "clone", "--quiet", "--single-branch", "--branch", "master", args.hub, repository)
            if not (args.prepare or args.publish):
                pending_releases(repository, releases)
                return
            distdir = Path(run("portageq", "envvar", "DISTDIR", capture=True))
            changes = prepare(repository, releases, distdir, temporary)
            if args.publish:
                if changes:
                    run("git", "-C", repository, "add", "--", *changes)
                    subject = "ai-cli: update " + ", ".join(f"{r.package} {r.version}" for r in releases)
                    run("git", "-C", repository, "commit", "-m", subject,
                        "-m", "Verified official release SHA256, preserved historical Manifests, and passed Portage image/version/help and metadata checks. MAKEOPTS inherited unchanged.")
                    # A simultaneous publisher causes a non-fast-forward rejection, never a force push.
                    run("git", "-C", repository, "push", "origin", "HEAD:refs/heads/master")
                else:
                    print("Overlay already contains the latest releases.", flush=True)
                refresh_consumers(args.hub, args.checkout, args.laptop)
            elif changes:
                print("Prepared verified recipes; commit and publish the checkout to make them available.")


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, KeyError, subprocess.SubprocessError) as exc:
        print(f"qinda-ai-cli-update: {exc}", file=sys.stderr)
        sys.exit(1)
