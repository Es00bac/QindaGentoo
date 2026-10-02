# BLOCKED exact private bridge source candidate

- Timestamp: 2026-10-02T23:12:31.097493+00:00
- Exact candidate: `7b81e7e2fd089be1fdc73d9f9a1333eec8db92c3`, base `9590192971572b6b51b127b939a36c40148ab5e9`.
- Separate sparse review worktree: qinda `~/.cache/pf-xwayland-private-pipewire-packaging-review-20261002`, branch `review/pf-xwayland-private-pipewire-packaging-20261002`; clean exact candidate.
- Source reads use nice19/idle IO. No compiler/GPU/install/payload sweep or production edit.

Two blocking recipe defects were sent directly to original implementer Power, root cc:

1. `src_configure`/private compile change local S only. Actual EAPI8 cmake.eclass `_cmake_check_build_dir`:278 initializes CMAKE_USE_DIR from PWD; prepare pins bridge source, and configure:739/740 always passes CMAKE_USE_DIR. Thus intended private KPipeWire build configures bridge prematurely without staged dependency. Bind CMAKE_USE_DIR explicitly to each intended source during private and bridge phases, preserving proper phase cwd/restoration. Source/eclass reproduction; no build run.
2. Actual KDECMakeSettings.cmake:128–168 handles RPATH unless KDE_SKIP_RPATH_SETTINGS and unconditionally sets INSTALL_RPATH_USE_LINK_PATH TRUE. Bridge imports staged libraries outside source, so installed RPATH also receives WORKDIR/private-stage. Set KDE_SKIP_RPATH_SETTINGS=ON and CMAKE_INSTALL_RPATH_USE_LINK_PATH=OFF with existing explicit private runtime RPATH in both configurations. Built image must prove final ELF paths; source-only verdict cannot substitute.

Both archives independently match Manifest SIZE/BLAKE2B/SHA512 and documented SHA256: bridge37,536bytes/f07ec942..., KPipeWire153,848bytes/c357ffb4.... Full upstream LICENSES trees remain source/installed docs. Source patch changes only bridge find_package/private QML+locale setup and three private library OUTPUT_NAMEs; pixel/portal/callback/cleanup implementation unchanged. Upstream monitor finalization defaults to explicit KDE_INSTALL_QMLDIR per ECMQmlModule6:184–185, so private destination covers it. Private include/CMake exports are removed under the owned subtree; no shared Plasma RDEP or allow-list broadening.

Requested next action: original implementer repairs these two contract defects in same branch, sends one exact commit; reviewer rechecks that commit before SOURCE ACCEPT. Independent immutable built image inspection follows separately; no signed image/build/runtime acceptance yet.
