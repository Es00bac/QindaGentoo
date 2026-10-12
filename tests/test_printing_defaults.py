"""Exercise first-install printing policy without touching the running host."""

from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest


REPO = Path(__file__).resolve().parents[1]
PACKAGE = REPO / "net-print/qindaqt-printing"
EBUILD = PACKAGE / "qindaqt-printing-1.ebuild"
SYSTEMCTL = shutil.which("systemctl")


class PrintingPresetTests(unittest.TestCase):
    def setUp(self):
        if SYSTEMCTL is None:
            self.skipTest("systemctl is required for offline preset verification")
        self.temp = tempfile.TemporaryDirectory(prefix="printing-preset-")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.units = self.root / "usr/lib/systemd/system"
        self.units.mkdir(parents=True)
        self.etc_units = self.root / "etc/systemd/system"
        self.etc_units.mkdir(parents=True)
        self.presets = self.root / "usr/lib/systemd/system-preset"
        self.presets.mkdir(parents=True)
        shutil.copyfile(PACKAGE / "files/qindaqt-printing.target",
                        self.units / "qindaqt-printing.target")
        (self.units / "multi-user.target").write_text("[Unit]\nDescription=Fixture\n")
        shutil.copyfile(PACKAGE / "files/50-qindaqt-printing.preset",
                        self.presets / "50-qindaqt-printing.preset")
        (self.presets / "99-default.preset").write_text("disable *\n")
        self.enabled = self.etc_units / "multi-user.target.wants/qindaqt-printing.target"
        self.calls = self.root / "calls"

    def install(self, replacing=""):
        # Real systemctl only receives --root for the disposable fixture.
        # The wrapper refuses a host action, including an accidental future one.
        script = r'''
            inherit() { :; }
            elog() { :; }
            ewarn() { printf '%s\n' "$*" >&2; }
            die() { printf '%s\n' "$*" >&2; exit 1; }
            systemd_is_booted() { return 0; }
            systemctl() {
                printf '%s\n' "$*" >> "$CALLS"
                case "$1" in
                    --root=*) "$REAL_SYSTEMCTL" "$@" ;;
                    *) printf 'Host systemctl action refused\n' >&2; exit 90 ;;
                esac
            }
            source "$EBUILD"
            pkg_postinst
        '''
        env = dict(os.environ, ROOT=str(self.root), REPLACING_VERSIONS=replacing,
                   EBUILD=str(EBUILD), CALLS=str(self.calls), REAL_SYSTEMCTL=SYSTEMCTL)
        result = subprocess.run(["bash", "-c", script], env=env, capture_output=True,
                                text=True, timeout=10)
        self.assertEqual(result.returncode, 0, result.stderr)
        return self.calls.read_text().splitlines() if self.calls.exists() else []

    def test_first_install_enables_only_the_printing_target(self):
        calls = self.install()
        self.assertTrue(self.enabled.is_symlink())
        links = list(self.etc_units.rglob("*"))
        self.assertEqual([p for p in links if p.is_symlink()], [self.enabled])
        self.assertEqual(len(calls), 1)
        self.assertIn("--preset-mode=enable-only preset qindaqt-printing.target", calls[0])

    def test_earlier_administrator_preset_disables_default(self):
        local_presets = self.root / "etc/systemd/system-preset"
        local_presets.mkdir()
        (local_presets / "00-local.preset").write_text("disable qindaqt-printing.target\n")
        self.install()
        self.assertFalse(self.enabled.exists())

    def test_masked_target_stays_masked(self):
        mask = self.etc_units / "qindaqt-printing.target"
        mask.symlink_to("/dev/null")
        self.install()
        self.assertEqual(os.readlink(mask), "/dev/null")
        self.assertFalse(self.enabled.exists())

    def test_member_mask_and_existing_printer_configuration_are_preserved(self):
        mask = self.etc_units / "cups.socket"
        mask.symlink_to("/dev/null")
        config = self.root / "etc/cups"
        config.mkdir()
        originals = {
            "cupsd.conf": "Listen localhost:631\n# Owner's server policy\n",
            "printers.conf": "<DefaultPrinter Existing>\nDeviceURI usb://existing\n</DefaultPrinter>\n",
        }
        for name, data in originals.items():
            (config / name).write_text(data)
        self.install()
        self.assertEqual(os.readlink(mask), "/dev/null")
        for name, data in originals.items():
            self.assertEqual((config / name).read_text(), data)

    def test_upgrade_does_not_reenable_disabled_target(self):
        self.install()
        self.enabled.unlink()
        self.calls.unlink()
        self.assertEqual(self.install(replacing="1"), [])
        self.assertFalse(self.enabled.exists())


class PrintingActivationTests(unittest.TestCase):
    def run_policy(self, *, replacing="", booted=True, enabled=True, preset_ok=True):
        # Live-root paths are evaluated only against this fake systemctl. The
        # disposable-root cases above exercise the real preset implementation.
        script = r'''
            inherit() { :; }
            elog() { :; }
            ewarn() { printf '%s\n' "$*" >&2; }
            die() { exit 1; }
            systemd_is_booted() { [[ "$BOOTED" == yes ]]; }
            systemctl() {
                printf '%s\n' "$*"
                case "$1" in
                    --root=*) [[ "$PRESET_OK" == yes ]] ;;
                    --quiet) [[ "$ENABLED" == yes ]] ;;
                    daemon-reload|start) return 0 ;;
                    *) exit 90 ;;
                esac
            }
            source "$EBUILD"
            pkg_postinst
        '''
        env = dict(os.environ, ROOT="/", REPLACING_VERSIONS=replacing,
                   EBUILD=str(EBUILD), BOOTED="yes" if booted else "no",
                   ENABLED="yes" if enabled else "no",
                   PRESET_OK="yes" if preset_ok else "no")
        result = subprocess.run(["bash", "-c", script], env=env, capture_output=True,
                                text=True, timeout=10)
        self.assertEqual(result.returncode, 0, result.stderr)
        return result.stdout.splitlines()

    def test_enabled_first_install_starts_after_reload(self):
        calls = self.run_policy()
        self.assertEqual(calls, [
            "--root=/ --preset-mode=enable-only preset qindaqt-printing.target",
            "--quiet is-enabled qindaqt-printing.target",
            "daemon-reload", "start qindaqt-printing.target",
        ])

    def test_unbooted_system_does_not_start_services(self):
        self.assertEqual(len(self.run_policy(booted=False)), 1)

    def test_administrator_disabled_target_is_not_started(self):
        calls = self.run_policy(enabled=False)
        self.assertEqual(len(calls), 2)
        self.assertFalse(any(call.startswith("start") for call in calls))

    def test_failed_preset_does_not_start_services(self):
        self.assertEqual(len(self.run_policy(preset_ok=False)), 1)

    def test_upgrade_never_restarts_or_reenables_services(self):
        self.assertEqual(self.run_policy(replacing="1"), [])


if __name__ == "__main__":
    unittest.main()
