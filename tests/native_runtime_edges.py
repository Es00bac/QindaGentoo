#!/usr/bin/env python3
"""Check real Portage metadata and upstream preparation without compiling/installing.

Run after task-local metadata extraction; --evidence contains the unmodified
upstream archive and Portage metadata JSON. This does not qualify runtime apps.
"""
import argparse
import json
from pathlib import Path
import subprocess
import tarfile
import tempfile
import unittest

import portage

PARSER = argparse.ArgumentParser()
PARSER.add_argument("--evidence", type=Path, required=True)
PARSER.add_argument("--cmake-eclass", type=Path,
                    default=Path("/var/db/repos/gentoo/eclass/cmake.eclass"))
ARGS = PARSER.parse_args()
REPO = Path(__file__).resolve().parents[1]
METADATA = json.loads((ARGS.evidence / "metadata.json").read_text())


def atoms(text, use=()):
    return {x.cp for x in portage.dep.use_reduce(
        text, uselist=use, flat=True, token_class=portage.dep.Atom)
        if isinstance(x, portage.dep.Atom) and not x.blocker}


class NativeRuntimeEdges(unittest.TestCase):
    def test_policykit_backend_remains_with_native_agent(self):
        data = METADATA["kde-frameworks/kauth-6.27.0-r1"]
        self.assertIn("+policykit", data["IUSE"].split())
        self.assertIn("policykit", data["effective_USE"].split())
        self.assertIn("sys-auth/polkit-qt", atoms(data["RDEPEND"], ("policykit",)))
        self.assertFalse(data["PDEPEND"])

    def test_kirigami_keeps_all_modules_without_plasma_atom(self):
        data = METADATA["dev-libs/kirigami-addons-1.12.1-r1"]
        dependencies = atoms(data["RDEPEND"])
        self.assertNotIn("kde-plasma/libplasma", dependencies)
        self.assertTrue({"kde-frameworks/kirigami", "dev-qt/qtmultimedia",
                         "kde-frameworks/qqc2-desktop-style"} <= dependencies)

    def test_stock_default_keeps_plasmoid_dependency(self):
        data = METADATA["kde-misc/kdeconnect-26.04.3-r4"]
        self.assertIn("+plasmoid", data["IUSE"].split())
        self.assertIn("kde-plasma/libplasma", atoms(data["RDEPEND"], ("plasmoid",)))

    def test_native_profile_removes_only_plasmoid_dependency(self):
        data = METADATA["kde-misc/kdeconnect-26.04.3-r4"]
        self.assertNotIn("plasmoid", data["effective_USE"].split())
        native = atoms(data["RDEPEND"], data["effective_USE"].split())
        with_plasmoid = atoms(data["RDEPEND"], [*data["effective_USE"].split(), "plasmoid"])
        self.assertEqual(with_plasmoid - native, {"kde-plasma/libplasma"})
        self.assertTrue({"dev-libs/kirigami-addons", "net-fs/sshfs"} <= native)

    def prepare(self, enabled):
        with tarfile.open(ARGS.evidence / "kdeconnect-kde-26.04.3.tar.xz") as archive:
            member = next(x for x in archive.getmembers()
                          if x.name.count("/") == 1 and x.name.endswith("/CMakeLists.txt"))
            original = archive.extractfile(member).read()
        eclass = ARGS.cmake_eclass.read_text()
        start = eclass.index("cmake_comment_add_subdirectory() {")
        end = eclass.index("\n}\n", start) + 3
        helper = eclass[start:end]
        recipe = REPO / "kde-misc/kdeconnect/kdeconnect-26.04.3-r4.ebuild"
        # Isolate the new preparation decision. Existing ecm preparation/patches
        # are unchanged; this test deliberately does not claim their execution.
        program = """set -e
inherit() { :; }
ecm_src_prepare() { :; }
die() { echo "$*" >&2; exit 1; }
use() { [[ "$1" == X ]] || { [[ "$1" == plasmoid ]] && [[ "$PLASMOID" == yes ]]; }; }
""" + helper + '\nsource "$RECIPE"\nsrc_prepare\n'
        with tempfile.TemporaryDirectory(dir=ARGS.evidence) as tmp:
            path = Path(tmp) / "CMakeLists.txt"
            path.write_bytes(original)
            subprocess.run(["bash", "-c", program], cwd=tmp, check=True,
                           env={"PATH": "/usr/bin:/bin", "RECIPE": str(recipe),
                                "PLASMOID": "yes" if enabled else "no"})
            return original, path.read_bytes()

    def test_enabled_plasmoid_preserves_upstream_cmake(self):
        original, prepared = self.prepare(True)
        self.assertEqual(prepared, original)

    def test_disabled_plasmoid_preserves_real_app_subdirectories(self):
        original, prepared = self.prepare(False)
        self.assertEqual(prepared, original.replace(
            b"    add_subdirectory(plasmoid)", b"#DONOTBUILD     add_subdirectory(plasmoid)"))
        for name in ("core", "plugins", "daemon", "app", "indicator", "smsapp", "cli"):
            self.assertIn(("add_subdirectory(" + name + ")").encode(), prepared)


if __name__ == "__main__":
    unittest.main(argv=[__file__], verbosity=2)
