# Install-only downstream patch and retained Portage continuation ready

Root explicitly authorizes fixing unpublished/unbuilt desktop-r2 recipe before its first binary, retaining immutable29f archive. Exact upstream source repair `8a622b4b76d25d509ca50e8ca7fbf62d62753a4e` changes only Keyring installmetadata basename. Independent Inputsource review and exact recipe acceptance pending; no source patch/phase execution yet.

Product: one new patch `gui-wm/qindaqt-desktop/files/qindaqt-desktop-29f7174a-keyring-qmltypes-install.patch` exact rootgitdiff29f→8a; existingr2 recipe adds PATCHES only. Source byte correspondence computed before execution: replaced original basename equals exact8a file, repaired SHA256 `c20e2b9600465edc6e68cd9d4f747564105494f2af685b49c2bfbf43c76e193b`. Patch parse1+/1-/oneCMakefile, bash-n and diff-check0. Source/archive/Manifest and compiled source remain unchanged. Documentation identifies downstream patch and qualification.

- Upstream archive SHA256 `db840111c4116360611b6b0d231ea11ef4748cc6576ed645d472cc0733d0b533`.
- Patch SHA256 `464a89f5521a0db0dce0a1612053dca740020ac509076628fc20e3c6bc153ac1`.
- Patched recipe SHA256 `fca63b2a37af6aa2e4e6a4d9d02e22ac5e4a06c5eb1d947f74011e1e94566ebf`.

## Supported continuation (prepared, not executed)

Actual installedPortage `phase-functions.sh` prepare/configure/compile skip when .prepared/.configured/.compiled exist. Remove only those task-local markerfiles (preserve copies/absence of.installed), retain.unpacked/source/work/cache/objects. `ebuild --force` applies only digest/Manifest, so do not use it. Actual `ebuild.sh:617` reloads edited ebuild on every phase under FEATURES=noauto; doebuild.py suppresses automatic dependencies undernoauto. Appendnoauto to existing FEATURES (retain binpkg-signing), no configuration edits. cmake.eclass configure reuses existing BUILD_DIR/CMakeCache and does not remove compiled objects.

Reuse exact prior private PORTAGE_REPOSITORIES/PORTAGE_CONFIGROOT/DISTDIR/PKGDIR/PORTAGE_TMPDIR/MAKEOPTS=-j8 -l24/PORTAGE_NICENESS=10, then after source/recipe acceptance:

```sh
# Copy/remove only task-local .prepared .configured .compiled markers.
# Append noauto to existing FEATURES; retain signing features.
ebuild <exact-patched-r2-ebuild> prepare
ebuild <exact-patched-r2-ebuild> configure
ninja -C <retained-build-directory> -n
# Inspect actual actions; no fresh 5040 rebuild. Stop/report unexpected broad recompilation.
ebuild <exact-patched-r2-ebuild> compile install package
```

These are Portage prepare/patch/configure/compile/stage/GPkg phases, no manual binary install/construction. Existing Portage GPG API unlocks configured signing immediately before package (does not reveal keys); signing remains Portage-owned. Same8job/load24/6GiBguard; exactargv/log/process/status preserved. `install` replaces only task-local image and runs standard Portage QA.

Read-only prelineage qinda `.qa/pf-desktop-portage-final-20261002/desktop-r2-continuation-before.json` hashes5396source files/3152compiledoutputs, CMakeCache, qmldir and actual_qml.qmltypes. Collection1.838s. After replay compare sourcefiles (only oneCMakefilename), compiledoutputs and modulemetadata; preserve expectedcache/buildsystem regeneration proof, report any actual unexpected delta. No fakegraph/runtime/install claim. Upstream archive unchanged, source29+exactacceptedpatch+recipe binding mandatory. Final signedGPkg/image/release/portalboundary inventory gates follow success.

Next action root/Input source acceptance and independent exact recipe review, then immediate bounded warm phase continuation. No freshfullbuild/sourcearchive recut, no installedhost files/profile/world/restart/icons.
