# Desktop Portage source-ready handoff

2026-10-02T18:41:29Z

Exact source candidate `c41a8625f8f087ff63a6c0743f1ea54588c8aa31` on `worker/pf-desktop-portage-20261002`, base `8f23e1e90490ab02f49e88d5c99994bbf1f0082b`. Isolated laptop `/home/cabewse/work_space/QindaGentoo-desktop-portage-20261002`, qinda mirror `/home/cabewse/.cache/pf-desktop-portage-20261002`; clean at source checkpoint. This receipt successor changes own ops only. Stable packaging persona; no icon recipes/assets or source changes.

## Prepared delivery

- New desktop `gui-wm/qindaqt-desktop-0.1.0_pre20261002`: provisional manager pin `1502fcc7a635d6a149448e0094377b49f28438e2`, own exact fork dependency, replaced KDE locker/portal/polkit/PowerDevil/spectacle/activities edges removed; native OpenSSL3.2 keyring, PAM, CUPS/Qt PrintSupport and existing QtQuick runtime declared.
- New fork `gui-wm/qindaqt-kwin-6.6.6_p1-r1`: provisional manager pin `7f4b2483a9b7e1de2efb2f62036679770008681d`, adapting held1819e4a p1. Both VDBs lack this package; source serial1 and desktop6.6.6.1 EXACT contract require retaining p1, with r1 distinct PF archive. Slot0/6.6.6_p1; native shortcuts ON, native lock ON, activities OFF and native Schedule1 nightlight built in. Remove replaced Plasma daemon/runtime declarations, retain only KWayland allowance and actual KIO framework dependency.
- Desktop enables real `QINDAQT_NATIVE_POWER_EXCLUSIVE=ON` option from reviewed worker candidate99cfa78e7. Current provisional pin precedes that merge: final manager pin MUST include the accepted option/unit/supervisor changes; no ignored flag is release-qualified. No final archive/size/hash is fabricated; new desktop/fork Manifest entries remain pending exact qualified archives.
- Proposed profile parent is ordinary Gentoo desktop/systemd, not Plasma. Native fork enters packages; retired KDE service/Sloom applet selections leave packages. QtBase/fork accessibility match actual host Qt selection. World and all host configuration remain unchanged; unrelated installed Plasma stays independent. Proposed delivery metadata names the two new atoms, explicitly provisional.

Changed product paths: new desktop/fork recipes; `profiles/qindaqt/systemd/{parent,packages,make.defaults,package.use,package.accept_keywords}`; `metadata/qinda-delivery`; README/CLAUDE; authorized narrow `kde-frameworks/kio/` recipes/Manifest/provenance/original patch and additive `profiles/categories` row. All released recipes/old DIST entries unchanged.

## Actual runtime closure evidence and blocker repair

Existing accepted PF25 tool is unchanged. Process-local `PORTAGE_REPOSITORIES` retains each host's normal repository configuration but points only qindaqt at the isolated candidate; `PORTAGE_CONFIGROOT` is a task-local configuration whose make.profile selects the candidate profile and whose user config inputs are read-only links to originals. No /etc writes, scheduler, merge or world changes.

Actual command on both hosts:

`tools/check-plasma-dependencies --resolve --root '=gui-wm/qindaqt-desktop-0.1.0_pre20261002' --root '=gui-wm/qindaqt-kwin-6.6.6_p1-r1'`

Exact pre-KIO candidate4008184ff0dabe9d13e47bf024ac2bad17ba7f46:

- qinda-top exit1,22.371s;579 runtime packages,2 forbidden providers. KIO6.27.0 -> keditfiletype6.6.6 -> kde-cli-tools-common6.6.6.
- qinda exit1,18.112s;592 runtime packages,2 forbidden providers. KIO6.29.0 -> keditfiletype6.7.5 -> kde-cli-tools-common6.7.5.
- First qinda exit2 accessibility USE mismatch preserved and repaired in candidate profile, not host settings.
- Laptop lock absent immediately before and throughout its actual read-only replay.

Manager subsequently paused all heavy work for desktop/audio recovery and authorized matching KIO adaptations removing ONLY keditfiletype PDEPEND. Actual native MIME association editing exists at exact desktop1502: Settings default-apps route and FileManager `open_with_controller.cpp` call shared `saveMimeTypeDefault`, persisting per-MIME default/Added Association with unrelated rows preserved. Original Gentoo6.27/6.29 implementation/build/dependencies, kded post-dependency, DIST rows and6.29 patch retained byte-exact; only external editor edge/comment changed. Broader standalone MIME definition/icon/glob authoring is not claimed native; users needing that legacy external action may independently install keditfiletype. No widened guard or fake graph.

New KIO candidate has NOT been solver replayed after recovery hold; runtime closure is unresolved until actual two-host rerun.

## Static checks and preserved evidence

`bash -n` all4 new ebuilds exit0. Byte reconstruction of each KIO recipe equals its respective actual Gentoo original after restoring only removed dependency/comment, exit0; patch matches qinda upstream byte-exact and2 original DIST records match upstream, exit0. Production `git diff --check BASE -- . ':(exclude)kde-frameworks/kio/files/*'` exit0. Unfiltered diff-check reports11 original trailing-whitespace lines in the byte-exact imported mail-format Gentoo patch; that upstream artifact is deliberately not rewritten.

Logs under `/home/cabewse/.cache/pf-desktop-portage-qa-20261002/` on each host. qinda-top-resolve.log SHA256 `c7ca90b5f1cba50f55578b17ce4ed7aa3c78b2b19d2765dadb9419f09dab1d87`; qinda-resolve.log SHA256 `60b383254cc5d2ade676f8542cb1fc8debb8c80040b529603ab5c6b2cb7a0e15`; first accessibility failure separately preserved. KIO original recipe/patch hashes and exact rationale in `kde-frameworks/kio/QINDAQT-PROVENANCE.md`.

Requested next action: independent exact source/recipe review now; after root recovery release, actual both-root/both-host PF25 replay. Manager supplies final integrated desktop/fork pins and matching archive Manifests after runtime qualification. No C++ compile, GPU, install, native runtime or desktop restart ran. Compiler slot remains released; source-ready candidate is not actual desktop delivery.
