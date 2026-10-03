# Retained Desktop-r2 repackage preparation — read-only

- Canonical overlay43bcc05648686c3d119a5a7428bff22cb3cda30a and Desktop5917da5c054ccd8ed9fd0be5a2ac9db549a4bb1c still match after fetch/read. Own isolated branch retained; no product edits.
- Exact retained source is29f7174a62175475f6ba54fa7627dc2fd4c8a21f plus reviewed8a622b4b76d25d509ca50e8ca7fbf62d62753a4e downstream QML-typeinfo install patch. The current signed-r2 artifact remains immutable, SHA256b2a82255dbdc02457a5eb4cb1732e584db8f8e6111dac8979572dcd88b642354.

## Actual paths and warm state

Qinda QA root: `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002`.

Portage build root: `desktop-portage-tmp/portage/gui-wm/qindaqt-desktop-0.1.0_pre20261002-r2/` below QA root.

- Source: `work/QindaQt-29f7174a62175475f6ba54fa7627dc2fd4c8a21f`.
- Ninja build/cache: `work/QindaQt-29f7174a62175475f6ba54fa7627dc2fd4c8a21f_build`.
- Full staged image: `image/`; present, root/Portage-owned (normal-user traversal is denied; no chmod/copy performed).
- Markers: `.unpacked`, `.prepared`, `.configured`, `.compiled`, `.installed`, `.packaged` all present.
- CMakeCache actual home directory equals the absolute retained r2 source above, generatorNinja/buildtypeRelWithDebInfo/installprefix/usr.
- Existing configuration: PORTAGE_CONFIGROOT=`/home/cabewse/.cache/pf-desktop-final-closure-20261002/configroot/`; process repository override uses own qinda overlay WT; DISTDIR=`candidate-distfiles`, PKGDIR=`desktop-binpkgs`, PORTAGE_TMPDIR=`desktop-portage-tmp`, all under QA root.

No repeated output/source payload sweep. Existing lineage receipt proves3152compiled outputs unchanged over the install-only8a fix;5396source files differed only in Keyring CMake. Prior actual noauto continuation: prepare/configure24.004s, Ninja dryrun2regenerationchecks/0CXX/0link, compile3.357s/install14.434s/package3.679s, all exit0. This establishes actual retained-cache reuse, not a guarantee for a future source fix.

## Supported minimal phases and revision boundary

Installed Portage `ebuild.sh:613-617` reloads the recipe each phase under FEATURES=noauto; `phase-functions.sh` skips phases whose markers remain. Existing accepted supported sequence is:

```text
preserve task-local markers; remove only affected phase markers
FEATURES=<existing signing/signature features plus noauto>
ebuild <exact independently reviewed recipe> prepare     # only if new PATCHES require it
ebuild <exact independently reviewed recipe> configure   # when source/CMake changes need regeneration
ninja -C <correctly bound retained BUILD_DIR> -n           # diagnostic only; no compilation
# STOP before broad rebuild or mismatched source/cache
# after root compiler grant, standard Portage-owned phases:
ebuild <exact independently reviewed recipe> compile
ebuild <exact independently reviewed recipe> install
ebuild <exact independently reviewed recipe> package
```

Use the already-recorded process-local config/repository/DISTDIR/PKGDIR/tmp and retain signing; no emerge clean/unpack of retainedr2, manual image/binary construction, --force-as-marker-reset or host install. `install` is staging only. A C++ change requires removal of compiled/installed markers and incremental compile, not installation from a stale image. A diagnostic stage-token fix still changes bytes and must be bound to reviewed source/patch and clearly qualified; it is not silently the accepted original binary.

**New release identity is required:** r2 already produced/published a signed binary. A new production/diagnostic release must use a new recipe/revision (normallypre20261002-r3) and separately preserved binary, never rewrite r2/its archive/Manifest or falsely reuse its identity. Prefer same immutable29f base archive plus exact reviewed downstream patch for a tiny fix; r3 DIST filename/real hashes and metadata delivery atom need a narrowly reviewed recipe change, while existing8a patch/dependencies/options remain. If choosing a new upstream source archive instead, new prefix/source binding must be reviewed and cache lineage rechecked.

**Warm reuse across that revision is not automatic:** installed `doebuild.py:509-526` unconditionally derives PORTAGE_BUILDDIR/WORKDIR from CATEGORY/PF. Same PORTAGE_TMPDIR with r3 creates a different workroot; passing PORTAGE_BUILDDIR does not override this. cmake.eclass publicly supports BUILD_DIR override, but the existing cache pins the r2 absolute source. Copying/moving cache to r3 without a reviewed source/cache binding can fail or recompile the whole tree. This read-only task has not performed or certified a cross-revision transfer/symlink/bind. Exact future execution must first establish source/cache identity through normal Portage/eclass settings and inspect Ninja dryrun; otherwise report that concrete warm-cache constraint instead of launching5040actions. Existing same-PF phase continuation remains proven.

## Gates and stopping point

Await exact tiny source/diagnostic candidate, different-worker source/recipe review, explicit revision/archive/patch hashes and a single bounded root compiler lease. Preserve baseline source/cache/object/image/marker receipts; apply only accepted patch via Portage and dryrun before compile. New immutable signed GPkg requires source/recipe binding, image/runtime checks appropriate to the changed keyring path, and normal mandatory-signed resolver/install acceptance; previous five-binary pretend must be updated for the new Desktop target. No new artifact/import correctness claim from this preparation.

All operations here were low-priority read-only file/installed Portage/eclass inspection plus own board/thread. No source/package/marker/cache/build/install/provider/PAM/GUI mutation or credential access. Manager retains actual importer diagnosis and execution.
