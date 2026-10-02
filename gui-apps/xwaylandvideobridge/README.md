# Private upstream video bridge dependency

0.5.0-r1 preserves XwaylandVideoBridge0.5.0 behavior and bundles exact upstream
KPipeWire6.6.6.1 (LGPL-2.1+) below /usr/lib64/xwaylandvideobridge on amd64.
The immutable upstream archives, licenses and original bridge desktop/autostart,
portal flow, pixel renderer and cleanup remain. The private-build patch only
selects staged dependencies, distinct library SONAMEs, owned QML/catalog paths.
No global KPipeWire headers, CMake package or QML modules are exported; internal
development exports are removed from the package image. Existing non-PipeWire
QML imports are preserved after the owned module path.

This is adaptation inside one application package, not a recategorized shared
provider or Plasma allow-list exception. Build-only image/ELF/signature checks
and independent review precede installation; actual sharing remains a separate
runtime gate. No installed service/process is restarted by source preparation.

Immutable source SHA256:
- bridge0.5.0: f07ec942b17c2134b78af33b7aad9fae8d045c91aacae4b297c33106d2561379
- KPipeWire6.6.6.1: c357ffb467301b650ee77ff670da33a97a4e203557d2f8790e40449a2173ecd8
