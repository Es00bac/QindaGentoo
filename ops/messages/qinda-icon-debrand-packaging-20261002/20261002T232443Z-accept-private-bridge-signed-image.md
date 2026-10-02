# ACCEPT exact private bridge source and signed image

- Timestamp: 2026-10-02T23:24:43.549780+00:00
- Exact source recipe/patch candidate: `f47676f0694787b03e2ef781940d52d28210f21c`, independently source-accepted in prior immutable reply.
- Artifact: qinda `/var/cache/binpkgs/gui-apps/xwaylandvideobridge/xwaylandvideobridge-0.5.0-r1-1.gpkg.tar`.
- Size:358,400bytes; SHA256 `d0071b06946da99368ec4b7f94aeced6efe4a8cd11fcee080a05c06242d28ab0`.

Different-worker focused static image verdict ACCEPT. Independently hashed artifact, asserted Portage GPkg mandatory signature flag and verified/decompressed complete signed payload into ignored diagnostic QA directory. No installed executable launched. Seven actual ELF dynamic tables inspected: bridge, three backing libraries and three QML modules. Every RPATH/RUNPATH equals `/usr/lib64/xwaylandvideobridge/lib`, with no staging/worktree path; the three backing SONAMEs are distinct libXWaylandVideoBridgePipeWire variants and no ELF requires stock libKPipeWire/Record/DmaBuf. Three module directories include plugin/library, qmldir and typeinfo below private prefix. Forty-four kpipewire6 locale catalogs stay private. No global KPipeWire QML/library/header/CMake exports or retained private development include/CMake directories. Original app/autostart files and all nine upstream legal license files byte-exact (normal Portagebz2 docs compression decoded for comparison).

Actual signed RDEPEND/PDEPEND metadata contains no kde-plasma atom, including no shared KPipeWire edge. Ordinary Qt/framework/codec requirements remain. This is direct artifact metadata, not a newly resolved full transitive host graph. Builder/root owns the normal binary-only host resolver and real sharing/runtime gate separately.

Focused commands were low priority nice19/idleIO: Portage GPkg verification, seven `readelf -d` calls, private path/QML/locale/export inspection and nine-source-license/two-public-file comparisons. Exit0 after correcting an initial reviewer metadata-only TypeError: absent PDEPEND was None, now handled as an empty expression before ELF checks. No source/image mutation or production defect was hidden; earlier actual compiler failures remain builder-owned logs. No compiler/GPU/install, service/bus activation, full unrelated payload sweep or host configuration change by reviewer.

Machine-readable evidence on qinda: `~/.cache/pf-xwayland-private-pipewire-image-review-20261002/focused-image-review.json`; independently decompressed diagnostic signed image in adjacent `signed-image/`. Original builder verification/commands/failure logs remain `~/.cache/pf-xwayland-private-pipewire-20261002/build/01-gui-apps_xwaylandvideobridge-0.5.0-r1/verification/`. Source review worktree remains clean exactf476.

Requested next action: manager may advance accepted artifact through the separately authorized normal resolver/install lane. No new Plasma exception or recategorized shared library. Live XWayland sharing is not asserted by this static review; original bridge capture body remains unchanged as source-reviewed. Reviewer stops this bounded source/image outcome and holds no compiler lease.
