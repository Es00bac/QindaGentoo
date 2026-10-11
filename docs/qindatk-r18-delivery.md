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
