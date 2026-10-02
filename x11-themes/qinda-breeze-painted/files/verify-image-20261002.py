#!/usr/bin/env python3
# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
"""Verify one staged family against the exact reviewed source release."""
import hashlib
import json
from pathlib import Path
import sys
from PIL import Image

THEME_ID = "QindaQt-Breeze-Painted"
FROZEN_INVENTORY_SHA256 = "6f4b0478895b2d65695b142862b981c628d24de3770f954c804a30543a7b3d41"


def require(condition, message):
    if not condition:
        raise ValueError(message)


def digest(file):
    with file.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def files(root):
    require(root.is_dir() and not root.is_symlink(), "Missing or symlinked runtime root")
    result = {}
    for file in root.rglob("*"):
        require(not file.is_symlink(), "Symlink in runtime image: " + str(file))
        require(file.is_file() or file.is_dir(), "Nonregular runtime entry")
        if file.is_file():
            result[file.relative_to(root).as_posix()] = file
    return result


def main(source, image_root):
    frozen = source / "provenance/qindaqt-20261002/qa/composed-inventory.json"
    require(digest(frozen) == FROZEN_INVENTORY_SHA256, "Frozen source inventory differs")
    composed = source / "build/qindaqt-release/release-inventory.json"
    # AGENT-GUARD: an image inventory may not authorize different artwork.
    # Preparation verifies source provenance; the frozen QA binds exact payload.
    require(composed.read_bytes() == frozen.read_bytes(), "Composition differs from source freeze")
    inventory = json.loads(frozen.read_text())
    require((inventory["original_named"], inventory["canonical_groups"],
             inventory["native_aliases"], inventory["native_artworks"])
            == (7172, 3261, 138, 30), "Incomplete reviewed release counts")
    prefix = THEME_ID + "/"
    expected = {name.removeprefix(prefix): value
                for name, value in inventory["payload"].items() if name.startswith(prefix)}
    require(sum(name.endswith(".png") for name in expected) == 7310,
            "Incomplete frozen runtime PNG inventory")

    base = image_root
    for component in ("usr", "share", "icons", THEME_ID):
        base = base / component
        require(not base.is_symlink(), "Symlinked runtime ancestor")
    actual = files(base)
    require(set(actual) == set(expected), "Missing or extra staged runtime payload")
    hashes = set()
    for name, file in actual.items():
        value = digest(file)
        require(value == expected[name], "Staged hash mismatch: " + name)
        if not name.endswith(".png"):
            continue
        hashes.add(value)
        with Image.open(file) as png:
            require(png.format == "PNG" and png.mode == "RGBA" and png.size == (128, 128),
                    "Runtime icon is not RGBA128 PNG: " + name)
            png.load()
            alpha = png.getchannel("A")
            require(alpha.getextrema()[0] == 0, "Runtime icon has no genuine transparency")
            box = alpha.point(lambda value: 255 if value > 16 else 0).getbbox()
            require(box is not None and min(box[0], box[1], 128-box[2], 128-box[3]) >= 1,
                    "Runtime artwork is empty or lacks transparent margins")
    require(len(hashes) == 3291, "Distinct canonical artwork count differs")
    print(f"PASS: {THEME_ID}: 7310 RGBA PNGs, 3291 drawings, exact reviewed payload/notices")


if __name__ == "__main__":
    try:
        require(len(sys.argv) == 3, "Usage: verify-image-20261002.py SOURCE IMAGE_ROOT")
        main(Path(sys.argv[1]).resolve(), Path(sys.argv[2]).resolve())
    except (OSError, ValueError, KeyError, json.JSONDecodeError) as error:
        sys.exit(str(error))
