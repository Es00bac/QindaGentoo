<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# QindaTK r18 coordinated delivery

The candidate pins QindaTK e6837dc5a501739bd35730f4f567cea4158426cb,
with the Office controls and mail batch, a D-Bus build dependency, and
subslot 0/18. The exact shared delivery remains r17 until the Office
integration and the installed consumer closure are qualified together.

The source qualification records 1123 passing QML cases and a successful
standalone CMake consumer configure, compile, link and run. The complete
toolkit CTest audit passes 379 of 384 targets: four offscreen RHI cases
require an unavailable graphics context, and one example requires the
separately packaged QindaTK.Raster module. Office qualification uses the
same frozen headers, library and QML via the source's build-tree package.

The release must rebuild C++ consumers against r18 before replacing the
installed toolkit. A dependency slot operator alone cannot rebuild a
binary-only package or a recipe that reuses an older desktop image.
Inspect those recipes explicitly; preserve their installed source choices
and runtime services. Build package artifacts through Portage on qinda's
archive drive with configured MAKEOPTS unchanged. Deliver the matching
binary package set to both machines, without restarting the live desktop.

Consumer inventory and exact package qualification will be appended here
before metadata/qinda-delivery advances. Candidate source and package
artifacts are immutable once their Manifest has been published.

## Installed consumer inventory (2026-10-10)

Portage NEEDED.ELF.2 on both hosts identifies Office, QQTerm and QindaWeb
as direct shared-library consumers. QindaHane is also a direct consumer on
the laptop. The desktop, system monitor, Android applications, Portage UI,
LlamaWatch, Studio, PhotoCraft, QQmpv and Venus Pro declare a runtime QML
dependency but do not link libqindatk in their installed ELF images.

The directly imported non-Office C++ classes are TerminalSession (QQTerm),
CommandContext/CommandRegistry/ShortcutMap (QindaWeb), and the stylus
signals/sample (QindaHane). Their public headers are byte-identical between
installed r17 source 30ac60604a97a09006459f15e642c4342103fd3b and this
candidate. Final dynamic-symbol and runtime-QML checks remain required;
this inventory avoids treating an unchanged QML-only desktop image as an
ABI-sensitive source build. Office uses changed layouts and is rebuilt.

QQTerm 0.3.0-r1 and QindaWeb alpha1-r1 retain their installed source pins,
raise the toolkit floor and add the slot operator for future rebuilds.
QindaHane r25 is an explicit ABI metadata checkpoint over the unchanged r24
archive: all six imported toolkit symbols resolve and StylusSample's layout
is unchanged. Its binary dependency locks subslot 0/18, because rebuilding
a binary-only recipe cannot repair a future incompatible interface. No
QindaHane source or proprietary payload is republished by this change.
