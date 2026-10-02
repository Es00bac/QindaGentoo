# Signed Desktop-r2 image handoff

- Timestamp: 2026-10-02T21:57:16.168080+00:00
- Exact product recipe/patch candidate: `93cdb18e054b3b72fe879fb2251d5a953321a72c` (different-worker source acceptance `1c85a08a6e21ab779d7f8c1a7b2b27cd770f344e`). This receipt changes only my board/thread.
- Source archive: immutable `29f7174a62175475f6ba54fa7627dc2fd4c8a21f`; SHA256 `db840111c4116360611b6b0d231ea11ef4748cc6576ed645d472cc0733d0b533`.
- Downstream install-only patch: byte-equivalent to accepted source `8a622b4b76d25d509ca50e8ca7fbf62d62753a4e`, SHA256 `464a89f5521a0db0dce0a1612053dca740020ac509076628fc20e3c6bc153ac1`.
- Recipe SHA256: `fca63b2a37af6aa2e4e6a4d9d02e22ac5e4a06c5eb1d947f74011e1e94566ebf`; original archive/Manifest unchanged.

Portage retained-work continuation used normal `ebuild` prepare/configure/compile/install/package under the accepted private process repository/config/DISTDIR/PKGDIR/tmp, FEATURES plus noauto, eight-job/load24 ceiling and six-GiB memory floor. Only task-owned prepared/configured/compiled/installed marker states were preserved then removed; unpacked source/cache/objects retained. No manual binary install or package construction.

Prepare/configure exited0 in24.004s. Ninja dryrun showed only two regeneration checks, zero compilation/linking. Actual continuation PID/PGID1961237 started21:48:25Z and exited0 in28.008s: compile0/3.357s, install0/14.434s, package0/3.679s. Guard inactive; minimum MemAvailable10,057,854,976bytes. Compiler lease released. All3,152 compiled output hashes unchanged; of5,396 source files only accepted Keyring CMake differed; qmldir/typeinfo unchanged. Cache regenerated normally. Original failed install log and markers are retained.

Actual signed artifact on qinda:
`/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/desktop-binpkgs/gui-wm/qindaqt-desktop/qindaqt-desktop-0.1.0_pre20261002-r2-1.gpkg.tar`

- Size:60,661,760bytes.
- SHA256:`b2a82255dbdc02457a5eb4cb1732e584db8f8e6111dac8979572dcd88b642354`.
- SHA512:`78ab1ceed3e93690628642947125ccbb2312838e5a370bf856d4da4c47469fc3b149854e5e3abce0ba32a487add86106e9277c229402e6aa71487cc8ac0611d4`.
- Portage GPkg `verify_signature=True`, required-signature flag asserted, full payload decompressed/checksums verified: PASS1.742s;2,288 file/link inventory entries.
- PF:`qindaqt-desktop-0.1.0_pre20261002-r2`, repository:`qindaqt`; package filename sequence1, BUILD_ID metadata absent. No invented BUILD_ID.

Verified readable diagnostic image prefix:
`/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/desktop-r2-verified-image/usr`

Existing `tools/check-release-contract` on exact recipe/build/complete signed image: exit0, fork ABI6.6.6.1/pin55d1. Existing portal `check_boundary.cmake`: exit0. Existing switcher authenticator: five files PASS. Required image inspection:26 files including native portal resident/allhelpers/protected metadata, native Keyring/Secret/PAM helpers+module+units;13 ordinary and5 protected interfaces, default-deny selection. Power CMakeCache exclusiveON, actual supervisor compile default exclusive, all four native-exclusive policy args in both user/D-Bus activation units. Fixed864-byte Keyring typeinfo matches installed qmldir. No changed source/tests or new harness.

Input independently reports granted existing relocated native discovery exit0/5.645s using this complete image, default plugin discovery/no override; eight artifact hashes unchanged, cleanup arrays empty. Different-worker immutable runtime receipt: `2ba2eb5a8aba51f97c8a774ed0a283d1ebe76336`, audit path `ops/audits/complete-portage-image-native-discovery-20261002.json`. This diagnostic image is not an installed desktop.

QA evidence root on qinda is `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/`:
`desktop-r2-continuation-configure-*.json/log`, `desktop-r2-continuation-dryrun.log`, `desktop-r2-continuation-package-*.json/log`, `desktop-r2-continuation-lineage.json`, `desktop-r2-signed-image-receipt.json`, `desktop-r2-verified-image-inventory.json`, `desktop-r2-image-gates.json` and two gate logs, `desktop-r2-required-image-contract.json`, `desktop-r2-continuation-vdb-after.json`. Full command/config lineage retained. World and installed Desktop VDB exactly unchanged from before build.

Final two-root dependency closure remains the already completed exact393 gate: qinda589 packages/zero forbidden/exit0/22.543s; laptop576/zero/exit0/27.092s, lock absent/world/profile unchanged. Accepted install-only patch changes no dependency; no redundant solver rerun.

Requested next action: manager verify/publish/install this mandatory-signed candidate using the existing rollback/install lane. Worker performed no host merge, world/config change or active-session restart. No remaining packaging blocker.
