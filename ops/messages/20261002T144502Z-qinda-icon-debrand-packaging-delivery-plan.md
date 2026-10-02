# Review request: concrete Qinda icon debrand Portage delivery plan

Worker: `qinda-icon-debrand-packaging-20261002`
Timestamp: 2026-10-02T14:45:02Z
Base: `07ab05d10c20df4ac086430f5d761c57efadf4c7`
Branch: `worker/qinda-icon-debrand-packaging-20261002`
Requested next action: manager review of the runtime identity, shared source layout and verification interface; then supply the exact reviewed source commit/archive and package-phase resource authorization.

## Current recipes and inspected source

| Existing package | Source shape | Runtime identity | Existing checks |
| --- | --- | --- | --- |
| `qinda-breeze-painted-1.0.0_p20260929` | `${PF}.tar.gz`, prefix `${P}/`, `theme/`, `source/`, `INPUT-SHA256SUMS`, `PACKAGE-README.txt` | `QindaQt-Breeze-Painted` | supplied `theme/verify.py` validates original PNG SHA256 and IHDR RGBA128; file count 7,172 |
| `qinda-breeze-handdrawn-1.0.0_p20261001` | `${PF}.tar.xz`, prefix `QindaIconArt-6cdcfeccf22411534f2b0fb07579c7c53c5e73b6/`, `data/icons`, `sources`, `provenance`, `tools` | `QindaQt-Handdrawn` | original atlas verifier; original release builder; overlay original-release completeness/index checker |

Read-only checks ran on qinda, not the laptop. Painted archive SHA256 is `c92ca981df77279751c089e27b0f2ea115f1105d41b72ef15cc0b825a05176ef`, matching the recorded source archive. All 7,172 unique source-manifest paths equal the actual painted runtime file set across twelve categories. Its 7,230 tar members contain no absolute/traversal paths or links. It retains the eleven original ZIP identities in `INPUT-SHA256SUMS`, not the eleven raw ZIP files; the complete unpacked editable source companion, original batch manifests, renderer, build/verification scripts, upstream pinned source tarball and legal notices are present. Preserve all these original companion files and manifest bytes in the new shared source archive and package documentation. Never execute the supplied installer.

Handdrawn archive listing contains 11,454 members, no absolute/traversal paths or links, 7,172 runtime PNGs, and 3,703 original provenance files. Its original release CSV maps each runtime path to original source hash, output hash, canonical path and extraction record. Its immutable source manifest has 7,172 rows and the original procedural source identities. The original source tools require original artwork hashes; `handdrawn_release.py` rewrites original release manifest/summary and must not be invoked against debranded runtime artwork.

These checks establish layouts and preservation requirements, not new artwork acceptance. There is no new reviewed debrand source commit/archive yet and no placeholder recipe, digest or completed delivery claim.

## Proposed immutable upgrade boundary

- Add `qinda-breeze-painted-1.0.0_p20261002.ebuild` and `qinda-breeze-handdrawn-1.0.0_p20261002.ebuild`. Keep the existing package identifiers, old recipes and old distfile Manifest rows unchanged. A later recut uses a new `-rN` and distinct source revision/archive.
- Both recipes consume exactly one fetch-restricted shared `QindaIconArt-<reviewed-commit>.tar.xz`, with prefix `QindaIconArt-<reviewed-commit>/`; both append the same verified archive digest row to their package Manifest. The common immutable source-commit name is the explicit shared-source exception to the overlay's ordinary `${PF}` archive convention and needs manager documentation.
- Prefer retaining runtime IDs `QindaQt-Breeze-Painted` and `QindaQt-Handdrawn` to preserve saved preferences. Exact visible XDG names are `QindaQt Painted` and `QindaQt Handdrawn`; user-facing comments/localizations contain no Breeze/KDE/Plasma branding. Both inherit only hicolor. If architecture instead requires `QindaQt-Painted`, the manager/source owner must define the hidden thin old-ID alias and catalog behavior before packaging.
- Keep only `x11-themes/hicolor-icon-theme` at runtime. Use `python-any-r1` and Pillow at build/validation time where the reviewed checker requires decoded pixel/alpha checks. No Plasma dependency, selection write, world update, theme switch or desktop restart belongs in a package hook.
- Install runtime PNG bytes from the verified source release, not regenerated/repainted during package phases. Retain prominent original artwork licenses plus new modification notices in the runtime and uncompressed source/provenance documents. Complete original raw provenance remains in the pinned source archive; original painted editable companion is retained in package docs as before.
- The manager owns final README/current-delivery updates outside this worker's path ownership. Existing metadata.xml files and delivery/profile/world/preferences will not be edited by this worker.

## Required source and checker contract

Source ownership must supply exact paths and CLI before recipes are written. Preferred shape: `data/icons/<retained-theme-ID>/` contains final runtime families; preserved painted companion and immutable original handdrawn evidence occupy separately named original-source locations; debrand manifests/summaries occupy a distinct versioned provenance namespace.

The source-side nonmutating checker must run from unpacked source without Git metadata, network or host-specific paths. It must verify both runtime families, all original evidence, and complete new override lineage without rewriting old records. A proposed CLI is `python3 tools/verify_debrand_release.py --theme painted|handdrawn` (actual CLI is the source owner's decision). A read-only installed/package-image mode, or documented root/manifest arguments for an overlay checker, must validate the staged runtime bytes against the same source-bound debrand inventory.

Required invariants:

- Exactly all original 7,172 category/name paths remain present in both themes, plus only the explicitly reviewed equal small native Qinda alias set. Source manifests have unique safe relative paths; reject traversal, extra files, symlinks and incomplete checkpoints.
- Every runtime PNG is fully decoded 128×128 RGBA, has visible artwork and genuine usable transparency; enforce the reviewed alpha/margin policy and PNG SHA256, not only IHDR fields. Fixed128 discovery covers each of the twelve categories exactly once and honors documented contexts.
- Every unchanged runtime path equals its pinned original family bytes; every overridden path maps to reviewed override artwork with source/parent/prompt/tool/review/extraction/hash lineage and correct alias behavior. Original handdrawn canonical extraction provenance and original release records remain immutable. Override hash expectations are distinct from original release hashes.
- Runtime display metadata is debranded while mandatory legal origin/source notices remain preserved. Exact runtime metadata and each source/provenance inventory are cryptographically bound in a complete release summary; a successful partial authoring check cannot authorize packaging.
- Package checker must reject missing/duplicate runtime names, malformed release evidence, changed unchanged-file hashes, unrecorded added aliases, altered override bytes, missing notices, mismatched display names/inheritance, and unusable PNG alpha.

The worker will author only packaging-specific validation under its assigned theme package paths if a source verifier lacks stage-root checking. It will not author source artwork/extraction/provenance tools.

## Proposed acceptance evidence after source/resource authorization

1. Independently review exact source candidate and checker contract; establish archive digest/reproducibility and immutable source evidence. Review pinned recipe commit without claiming an unfinished checkpoint complete.
2. Static ebuild syntax and dependency checks; generate additive Manifests against the exact shared archive on qinda. Verify old Manifest lines and old ebuild files remain byte-identical to the base.
3. Execute source checker plus package preparation/install phases in an isolated qinda Portage image, with recorded commands/status/counts and no installation. Verify both image roots have full original inventory plus the exact approved alias list, all source-bound hashes/alpha/index/notices, expected documentation, and only data files. Meaningful negative checker cases exercise missing/extra/path-invalid/tampered/alpha-invalid/incomplete inputs.
4. Compare upgraded staged files with the old package lists to prove each old runtime path remains owned by the same package. Read-only native QindaQt catalog discovery and focused Qt rendering checks require the manager's desktop resource authorization; preserve existing saved icon selection.
5. Different worker reviews the exact candidate commit. Manager integrates and reruns affected gates before delivery metadata publication. Real Portage install, ownership/integrity, signed binary identity, laptop consumption and native installed rendering remain later manager-authorized delivery gates.

No package phases, compile, GPU, emerge, install or source-artwork mutation have run. Await exact source/checker contracts and manager review at this stopping point.
