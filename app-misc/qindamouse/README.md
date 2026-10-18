# QindaMouse integration and illustration candidate

`qindamouse-0.1.0_p20261017-r2` pins QindaMouse runtime commit
`a2d6f3e29f1283bd3725cf5a5e9f260f8fe7313b` from
`qinda:~/git/QindaMouse.git`, branch `finish/integration-20261017`.
It adds 127 model-specific SVGs to the combined family, emulation-lab and
optional input-service candidate. The r1 and original recipes remain available.

Source validation passed 543 offline tests and 23 current QML GUI tests,
including every model definition, outline clicks and alternate-shell
selection. The final artwork suite passed all 14 tests again after keypad
adjustments. All 163 reference files match their archived hashes on qinda;
protocol indices, capabilities and defaults are unchanged by the artwork.

Portage phases through `install` passed with `gui input-service -test`,
producing a 25.9 MiB private image. All 348 runtime source files match that
image, including every selected model SVG and all 127 device definitions.
Required launchers, udev rules and optional service files are present. CLI
imports/model-art checks and a demo GUI render run from the staged image,
outside the source checkout. The optional ebuild test phase was disabled;
test totals above come from explicit source-suite runs.

The artwork catalogue, review gallery and verification records are in
QindaMouse's `docs/ART_MODELS.md`,
`docs/verification/illustrations-20261017.md` and
`artifacts/illustrations-20261017/`. Prior protocol/integration results remain
in `docs/verification/completion-20261017.md` and
`artifacts/verification-20261017/`.

This package is optional and does not alter `metadata/qinda-delivery` or the
desktop profile. The service is installed only with `input-service` USE and
is enabled separately by the user.

On 2026-10-18, qinda-top installed r2 through Portage with `gui input-service
-test` and Python 3.14. All 348 installed runtime source files match the
pinned commit. The installed CLI, desktop entry and user-unit validation
passed, and the installed launcher rendered the Venus Pro demo outside the
source checkout. No supported mouse was connected; the optional input service
remains disabled and inactive.

Model protocol coverage remains 127 audited, one at full Windows parity and
126 with named gaps. Implemented vendor-derived operations do not require
hardware opt-in; individual unknown/incorrect encodings remain refused.
Firmware updates are excluded by design.
