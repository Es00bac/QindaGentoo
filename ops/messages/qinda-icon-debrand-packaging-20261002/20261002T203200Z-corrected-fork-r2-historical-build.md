# Corrected fork revision 2 candidate and historical build receipt

- Base overlay candidate: `805c08bb0efe1aa27bfa1475b45c8a3e927716b3`.
- New fork version: `gui-wm/qindaqt-kwin-6.6.6_p1-r2`; exact source `e9bcb4a834a3a817d2bc194f3c4cf488e9111679`, unchanged serial1/exact ABI6.6.6.1. Root authorized revision2 to preserve r1.
- Product delta: new r2 recipe copied r1 with only exact source pin changed; one new real DIST row; desktop dependency/delivery fork atom r2; qualification docs. Gabbee0a232/Media27b/libei/KIO/profile unchanged. Existing r1 recipe/archive/Manifest row retained. No final desktop revision/archive until root supplies final pin.
- Archive qinda private path: `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/candidate-distfiles/qindaqt-kwin-6.6.6_p1-r2.tar.gz`, prefix `qindaqt-kwin-6.6.6_p1-r2/`,15,858,433bytes/4017members/0links. SHA256 `7584a13cd6ba6e73af402903dd6dc01a47e6986a3ce4ce62b1c017ec87159fc2`. Actual BLAKE2B/SHA512 in appended Manifest. Deterministic git archive + gzip -n -1 both exit0; six original/changed source files exact Git bytes. Initial validator rejected the archive root-directory member lacking a slash; corrected exact-root acceptance validated same immutable bytes, exit0.
- Verification: `bash -n` new fork r2 + current desktop recipe exit0; `git diff --check` exit0. Native/runtime qualification and root recipe acknowledgment pending. No r2 compiler/solver/native/host operations.

## Prior actual two-host closure (805/a696, not corrected e9)

`tools/check-plasma-dependencies --resolve --root '=gui-wm/qindaqt-desktop-0.1.0_pre20261002' --root '=gui-wm/qindaqt-kwin-6.6.6_p1-r1'` used task-local repo/profile process settings only. Actual qinda589/laptop576 runtime packages, zero forbidden, exits0 in22.041s/24.876s; laptop lock absent before/after. Evidence each host `/home/cabewse/.cache/pf-desktop-final-closure-20261002/{resolve.log,result.json,command.json,repositories.conf}`. These passes remain bound to805 roots; final r2/final-desktop replay pending root pins.

## Historical revision1 signed build only

Actual qinda Portage build-only used source805/a696, four jobs/load24 and own6GiB memory stop. Initial missing private temp directory failure exit1/5.001s retained; created only task-local Portage-owned temp, retried unchanged command. PID/PGID1709406 exited0 in995.058s, minimum MemAvailable7,445,741,568bytes; guard inactive; installed fork VDB/world unchanged. Compiler lease released. Root discovered production bare-modifier parser defect while this build ran; **artifact is historical evidence only, not final delivery; do not publish/install**.

- Artifact `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/fork-binpkgs/gui-wm/qindaqt-kwin/qindaqt-kwin-6.6.6_p1-r1-1.gpkg.tar`,4,874,240bytes.
- SHA256 `962729bb007b8f1a5a75165dd6b92c8234ee587fdf36fdf70a5a1f20ed4227a5`.
- SHA512 `b96b97a50234dce722a41e576ce3a452be1b1e2fb9410191f8c2dff4279a60d082e5b25212706cedfa82f6b17984c98701991bee131b1163933217ebc6076ff6`.
- Existing Portage `gpkg(...,verify_signature=True).decompress(...)` required signatures and verified all payload/checksums, PASS0.17s. Image456 files/links; native executable, exact6.6.6.1 CMake package version and two capture-authority headers present. No uninstalled executable run.
- Evidence qinda `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/`: `fork-build-{command,process,result}.json`, `fork-build.log`, Portage detailed temp/build.log, `fork-vdb-{before,after}.json`, `fork-r1-signed-receipt.json`, `fork-r1-image-inventory.txt`, `fork-r2-archive-receipt.json`; initial failure retained separately.

Requested next action: independent exact recipe review, final desktop pin/version and coherent native-gate acknowledgment before any final read-only closure or corrected build. No archive publication, installation, config/profile/world change, session restart or icon work.
