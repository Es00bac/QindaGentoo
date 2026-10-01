#!/usr/bin/env python3
# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
"""Reject incomplete artwork checkpoints and unusable XDG release metadata."""
import configparser
import csv
import json
from pathlib import Path
import sys


def main(root):
    inventory = json.loads((root / "provenance/inventory-check.json").read_text())
    # AGENT-GUARD: the source verifier intentionally permits incomplete authoring
    # checkpoints. A successful verify exit alone must never permit installation.
    required = {"expected_named": 7172, "actual_named": 7172,
                "expected_canonical": 3261, "authored_canonical": 3261,
                "distinct_canonical_output_hashes": 3261, "missing_named": 0}
    if inventory.get("complete") is not True or inventory.get("errors") != []:
        raise ValueError("Artwork release is incomplete or has verification errors")
    if any(type(inventory.get(k)) is not int or inventory[k] != v
           for k, v in required.items()):
        raise ValueError("Artwork release coverage differs from 7172 names/3261 drawings")
    rows = list(csv.DictReader((root / "sources/full-manifest.csv").open()))
    expected = {row["output_path"] for row in rows}
    if len(rows) != 7172 or len(expected) != 7172:
        raise ValueError("Immutable source inventory has duplicate or missing names")
    theme = root / "data/icons/QindaQt-Handdrawn"
    actual = {p.relative_to(theme).as_posix()
              for p in (theme / "128x128").rglob("*") if p.is_file()}
    if actual != expected or any(p.is_symlink() for p in theme.rglob("*")):
        raise ValueError("Runtime files must be exactly the original named PNG inventory")
    directories = {str(Path(p).parent) for p in expected}
    index = configparser.ConfigParser(interpolation=None, strict=True)
    index.read_string((theme / "index.theme").read_text())
    header = index["Icon Theme"]
    advertised = header.get("Directories", "").split(",")
    if (not header.get("Name", "").strip() or len(advertised) != len(directories)
            or set(advertised) != directories):
        raise ValueError("XDG index must advertise every actual icon directory exactly once")
    for directory in directories:
        section = index[directory]
        if (section.get("Type") != "Fixed" or section.getint("Size") != 128
                or section.getint("Scale", fallback=1) != 1):
            raise ValueError("XDG directory metadata must describe fixed 128px raster icons")
    print("Complete hand-rendered release: 7172 names, 3261 drawings, 12 XDG directories")


if __name__ == "__main__":
    try:
        main(Path(sys.argv[1]))
    except (OSError, ValueError, KeyError, IndexError, configparser.Error) as error:
        sys.exit(str(error))
