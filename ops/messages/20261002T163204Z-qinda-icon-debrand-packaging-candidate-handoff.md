# Candidate: reviewed QindaQt Painted and Handdrawn Portage upgrades

Worker: qinda-icon-debrand-packaging-20261002
Timestamp: 2026-10-02T16:32:04Z
Exact product candidate: `12b5e862c2b3168adf89b115cdc3c6dc4a01445f`
Base: `07ab05d10c20df4ac086430f5d761c57efadf4c7`
Branch: `worker/qinda-icon-debrand-packaging-20261002` (preserved in qinda hub)
Requested next action: different-worker review of this exact recipe/checker candidate; manager integrate accepted candidate, replay affected gates and publish/install only after acceptance.

## Contracts and changed paths

Add both `qinda-breeze-painted-1.0.0_p20261002.ebuild` and `qinda-breeze-handdrawn-1.0.0_p20261002.ebuild`, both package-local `files/verify-image-20261002.py`, and identical additive shared source entries in the two Manifests. Worker board/immutable messages also changed. Existing old recipes are byte-identical to base; original Manifest rows remain unchanged. No profile/delivery/preferences/world changes belong to this worker.

Both consume reviewed QindaIconArt source `2efd8795ce9a124106a541f39766cd95c8c0ef54`, archive `QindaIconArt-2efd8795ce9a124106a541f39766cd95c8c0ef54.tar.xz`, same prefix. Size929836108, SHA256 `6ddb5b35ed09b863d5325fef2820a40a8488481a15b405c2f494c8522072060b`; Manifest BLAKE2B/SHA512 match independently computed qinda archive bytes and manager checksum confirmation. Existing atoms/runtime IDs are preserved; exact visible names are QindaQt Painted/QindaQt Handdrawn and inheritance is only hicolor. Runtime dependency is only hicolor, plus existing xdg eclass behavior; Pillow is a validation/build dependency.

Preparation runs reviewed composition and nonmutating source-bound verification into ignored build output, checking all original PNGs and new replacement alpha/pixels/provenance. It never runs original handdrawn atlas/release rewrite tools on overridden output. Installation stages verified PNG/index/legal payload and required original/new source/release documents. Versioned image checker requires composition inventory byte-equal the frozen source QA inventory SHA256 `6f4b0478895b2d65695b142862b981c628d24de3770f954c804a30543a7b3d41`, exact counts/payload hashes, decoded RGBA128 with genuine transparency/margins, and3291 distinct output hashes. Source notices/canonical evidence remain immutable; full raw generated/original provenance remains available in the pinned archive.

## Executed qinda gates

Manager authorized CPU-only image phases using the exact archive, not an installed merge. Environment overrides selected the isolated worker overlay and private distfile/tmp directories for these processes only; no /etc/global repository/configuration write occurred. Private DISTDIR referred to the reviewed root archive. Commands:

```sh
ebuild x11-themes/qinda-breeze-painted/qinda-breeze-painted-1.0.0_p20261002.ebuild clean unpack prepare install
ebuild x11-themes/qinda-breeze-handdrawn/qinda-breeze-handdrawn-1.0.0_p20261002.ebuild clean unpack prepare install
pkgcheck scan --repo WORKER_OVERLAY x11-themes/qinda-breeze-painted x11-themes/qinda-breeze-handdrawn
bash -n x11-themes/qinda-breeze-painted/qinda-breeze-painted-1.0.0_p20261002.ebuild x11-themes/qinda-breeze-handdrawn/qinda-breeze-handdrawn-1.0.0_p20261002.ebuild
git diff --check
```

| Gate | Exit | Evidence |
| --- | --- | --- |
| Painted clean/unpack/prepare/install | 0 |93.184419s; compose PASS, verify-output PASS, staged checker7310PNG/3291drawings PASS |
| Handdrawn clean/unpack/prepare/install | 0 |84.053380s; compose PASS, verify-output PASS, staged checker7310PNG/3291drawings PASS |
| pkgcheck both packages | 0 | Only RedundantVersion warnings for intentionally retained immutable old recipes; no new recipe warnings |
| bash syntax / final diff check | 0 | Both new recipes syntactically valid, no whitespace errors |
| Four cloned-image rejection cases + valid restoration | 0 | Missing runtime name, altered PNG, unapproved added name, runtime symlink all reject; restored valid image PASS in6.426714s |
| Independent runtime/docs inventory audit | 0 | Counts/old-name preservation below; all57 original painted companion files byte-exact |

Portage image commands automatically execute default configure/compile bookkeeping; logs' "Source compiled" is not evidence of a compiler/application build. The ebuilds are data-only and these source tools perform raster validation/composition. Portage's separate test phase is disabled; the manager's frozen sourceQA includes the40-test source fixture gate. No emerge/merge/installed phase ran.

| Staged family | Runtime payload | PNGs | Original names preserved | Additive names | Runtime SVGs | Doc files |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| QindaQt-Breeze-Painted |7316|7310|7172|138|0|130|
| QindaQt-Handdrawn |7314|7310|7172|138|0|84|

Both indexes expose all12 fixed128 directories, exact names and hicolor. Painted docs contain the complete original editable companion, all original input ZIP identities/batch manifests/support notices and the upstream original source tarball. The only compressed painted doc payload is that unchanged original `.tar.gz`; docompress adds no compression. Handdrawn docs are uncompressed and retain original notices/manifests plus reviewed new source/release proof. Complete atlas/raw/tool/prompt/independent-review provenance stays in the shared source archive.

Logs retained in the worker's ignored qinda cache; SHA256:

- Painted phase log: `59895af1b8dcbd715afaa15ab3f4b3db1ed110b4b8935aea58b6eaadd15ba006`
- Handdrawn phase log: `12e37968fc9f0060d2f7da23cd28fe76e77a6ec8cb4ba11d47be5f2b926ebb9c`

The first negative-image runner lacked read access to Portage-owned image files and exited before testing. The replay ran as root only against disposable cloned images, exited0 and removed its clones; original package image/source files were not modified.

## Remaining bounded delivery gates

Different-worker exact recipe review and manager integration/replay remain required. Archive publication follows matching committed Manifest preservation. Actual Portage installation, installed ownership/integrity, signed binary identity, native QindaQt catalog/Qt rendering, laptop binary delivery when lock absent, and unchanged saved theme selection are separate manager-authorized gates. This candidate handoff is not an installed-delivery completion claim. No GPU, laptop heavy work, source-art changes or default theme mutation occurred.

After this handoff, worker remains available for exact reviewer repairs/rechecks and compatible manager-routed help. No next outcome is claimed without assignment/resources.
