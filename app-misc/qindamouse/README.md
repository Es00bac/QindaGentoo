# QindaMouse combined integration candidate

`qindamouse-0.1.0_p20261017-r1` pins QindaMouse runtime commit
`fad8004bded5dc5eb9d4000b89887abe599d3b21` from
`qinda:~/git/QindaMouse.git`, branch `finish/integration-20261017`.
It combines the family continuations, emulation lab and optional input
service. The older candidate recipe remains available.

Source validation passed 533 offline tests and 22 current QML GUI tests,
including all 127 model definitions. Portage phases through `install` passed
with `gui input-service -test`, producing a 7.2 MiB private image. Every
runtime source file and required launcher/configuration was checked against
that image. CLI imports/parity and a demo GUI render passed from the image,
outside the source checkout. The optional ebuild test phase was disabled;
the reported test totals come from explicit source-suite runs.

The full results, commands, screenshots and model-specific gaps are in
QindaMouse's `docs/verification/completion-20261017.md` and
`artifacts/verification-20261017/`. Vendor source exports remain outside git
at `qinda:/mnt/storage/qindamouse-re/evidence/`.

This package is optional and does not alter `metadata/qinda-delivery` or the
desktop profile. This continuation stages an image only: no host merge or
input-service activation occurred. The service is installed only with
`input-service` USE and is enabled separately by the user.

Model coverage is 127 audited, one at full Windows parity and 126 with named
gaps. Implemented vendor-derived operations do not require hardware opt-in;
individual unknown/incorrect encodings remain refused. Firmware updates are
excluded by design.
