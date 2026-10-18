# QindaMouse package

## USB connection update, 2026-10-18

`qindamouse-0.1.0_p20261017-r4` pins source commit
`a183188157d8325ca465e4b452e89780a80c8782`, branch
`fix/hotplug-basilisk-20261018`, in qinda's QindaMouse hub. It adds the wired
Razer Basilisk V3 (1532:0099), its own three-view SVG, source-derived current
profile bindings/Hypershift, X/Y DPI, polling and wheel controls. All six
Razer definitions now select the vendor-established feature capability and
prefer the documented configuration interface. Shared discovery recovers
pairing, access races and reconnects, and serializes configuration traffic.

The package refreshes udev access for already attached supported USB devices.
r4 fixes the live-root guard for EAPI 7+ (empty EROOT); r3 remains available
for historical reproduction. It loads uinput with the optional service USE
flag but does not enable the user service.

The final source passed 530 offline checks. The staged and installed payloads
match all 353 runtime source files, with 128 distinct model definitions/SVGs.
The r4 image is 26.5 MiB. Installed verification on qinda-top reads the actual
Basilisk as the normal desktop user, on the same USB/HID generation, without
replugging or configuration writes. Firmware 1.2, 1600 DPI, 1000 Hz, both
binding layers and wheel settings read successfully; the installed GUI render
shows the connected mouse. Portage merged r4 with `gui input-service -test`;
explicit source checks supply the test results. The optional input service
remains disabled. Full profile/RGB serialization and advanced codecs remain
named gaps rather than hardware-confirmation gates.

Source evidence and validation are recorded in QindaMouse's
`docs/verification/device-connections-20261018.md`,
`docs/protocols/razer-basilisk-v3.md`, and `artifacts/detection-20261018/`.
This remains an optional package; desktop profiles and delivery metadata are
unchanged.

## Earlier r2 illustration update

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
