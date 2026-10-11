<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# QindaTK r18 coordinated delivery

This delivery pins QindaTK e6837dc5a501739bd35730f4f567cea4158426cb,
with the Office controls and mail batch, a D-Bus build dependency, and
subslot 0/18. The shared delivery advanced from r17 after the Office
integration and the installed consumer closure passed qualification.

The source qualification records 1123 passing QML cases and a successful
standalone CMake consumer configure, compile, link and run. The initial full CTest run passed 378/384; after correcting its QML regression,
the final QML rerun passed all 1123 cases. These combined gates qualify
379 of 384 targets: four offscreen RHI cases
require an unavailable graphics context, and one example requires the
separately packaged QindaTK.Raster module. Office qualification uses the
same frozen headers, library and QML via the source's build-tree package.

The release rebuilt C++ consumers against r18 before replacing the
installed toolkit. A dependency slot operator alone cannot rebuild a
binary-only package or a recipe that reuses an older desktop image.
The recipes were inspected explicitly, preserving their installed source
choices and runtime services. Portage built package artifacts on qinda's
archive drive with configured MAKEOPTS unchanged and delivered the matching
binary package set to both machines without restarting the live desktop.

The consumer inventory and exact package qualification below preceded the
`metadata/qinda-delivery` advance. Source and package artifacts remain
immutable after their Manifest was published.

## Installed consumer inventory (2026-10-10)

Portage NEEDED.ELF.2 on both hosts identifies Office, QQTerm and QindaWeb
as direct shared-library consumers. QindaHane is also a direct consumer on
the laptop. The desktop, system monitor, Android applications, Portage UI,
LlamaWatch, Studio, PhotoCraft, QQmpv and Venus Pro declare a runtime QML
dependency but do not link libqindatk in their installed ELF images.

The directly imported non-Office C++ classes are TerminalSession (QQTerm),
CommandContext/CommandRegistry/ShortcutMap (QindaWeb), and the stylus
signals/sample (QindaHane). Their public headers are byte-identical between
installed r17 source 30ac60604a97a09006459f15e642c4342103fd3b and this
candidate. Dynamic-symbol and runtime-QML checks passed below;
this inventory avoids treating an unchanged QML-only desktop image as an
ABI-sensitive source build. Office uses changed layouts and is rebuilt.

QQTerm 0.3.0-r1 and QindaWeb alpha1-r1 retain their installed source pins,
raise the toolkit floor and bind the candidate package to subslot 0/18 with an explicit subslot
dependency (without the built-only `=` suffix).
The explicit subslot is necessary for package-only qualification while r17
remains installed: Portage cannot infer r18 from the live installed database.
A future toolkit ABI needs a new recipe revision and a rebuilt package.
QindaHane r25 is an explicit ABI metadata checkpoint over the unchanged r24
archive: all six imported toolkit symbols resolve and StylusSample's layout
is unchanged. Its binary dependency locks subslot 0/18, because rebuilding
a binary-only recipe cannot repair a future incompatible interface. No
QindaHane source or proprietary payload is republished by this change.

## Private package qualification (2026-10-10)

The resumed Portage r18 build completed from the preserved work directory. The
previous stop was signal 15 during the owner's pause, not a compiler failure.
All work used `~/scratch/qqo/qq-build` on qinda, with the configured
`MAKEOPTS=-j24 -l24` unchanged. The toolkit used its recipe's default features
(alsa, cups, ffmpeg, pdf, qindaqt, quick3d and widgets); tests/examples were off
in this package build. The source gates above remain the toolkit test evidence.

The immutable toolkit archive is 35,299,902 bytes, SHA256
`4a66b4445a317e6d305842d16f188f3c77a24b2db413a90684070122d400f4fd`.
A fresh `git archive` plus `gzip -n` from the pinned hub commit reproduces those
bytes. The packaged library SHA256 is
`1ed23a6716913c6152914ae66e5ad852430dec84227a55b201ebfc8559c4bf08`.

The signed package artifacts are retained on qinda under
`/mnt/archive/cabewse/qindatk/r18-binpkgs-qualification/`. The selected
artifacts were installed through Portage on both hosts; each path below is
relative to that directory.

| Artifact | Bytes | SHA256 |
| --- | ---: | --- |
| `dev-libs/qindatk/qindatk-0.1.0-r18-1.gpkg.tar` | 22261760 | `512f9487baddfa9c09710c1354ea91382f605b45df5da5578e24799d9337ec32` |
| `gui-apps/qqterm/qqterm-0.3.0-r1-1.gpkg.tar` | 296960 | `725e477dd6bf18a62317a8b9c6e14a8e1c74c053431172fe3c2148b948a3d018` |
| `www-client/qindaweb/qindaweb-0.1.0_alpha1-r1-1.gpkg.tar` | 399360 | `ea239bb5fa7999764aa545635984d5cfb5adbc426a4b827c7e3146f38e9fa726` |
| `media-gfx/qindahane-bin/qindahane-bin-0.1.0_pre20260928-r25-1.gpkg.tar` | 21565440 | `09e4c283fb4b7cb1872d5135fbcd018e7b344110ea7cc6aff7304de9ffa2c571` |

Portage's full gpkg verifier checked the Manifest, metadata and image signatures
and all digests, with signature verification explicitly enabled. Each embedded
recipe equals the reviewed candidate recipe. Image parity covers all regular
files and symlinks: toolkit 722+2, QQTerm 46+0, QindaWeb 4+0 and QindaHane 4+0.
Every ELF RUNPATH excludes private source/build paths. Package metadata locks
all three consumers to toolkit subslot `0/18`; r17 cannot satisfy it.

QQTerm retains source `0c879058ac3abb97096559be0872db7853ca0b4c` and QindaWeb
retains `3f440915750ddafe1703ce60538150e2c9a428ed`. Both were compiled and
linked against the Portage-staged r18 SDK, selected by a task-local CMake cache
file through the supported `CMAKE_EXTRA_CACHE_FILE` setting. Their test
processes used the same staged library and QML import paths; no SDK was
installed under a home directory or substituted into `/usr`.

- QQTerm: all 3 CTest entries pass in 11.52 s (22 Qt cases plus the real-process
  command/exit-status/literal-argument/private D-Bus handoff test).
- QindaWeb: all 3 registered CTest entries pass in 0.18 s (11 Qt cases for
  keyboard resources, navigation and private launch IPC). The first keyboard
  run exceeded Unix socket path length under Portage's long archive path. The
  candidate recipe now creates a short private temporary directory for tests;
  the unchanged compiled test then passes. The separately built, unregistered
  Gecko browser integration test was not run; no browser/session claim follows.
- QindaHane: the r25 metadata checkpoint preserves all 4 r24 payload files
  byte-for-byte. The existing payload SHA256 remains
  `e5135d5018386d50cdb742f787a73920d6d5cb5e61226031963aaf5beaced3e0`.
  This is a binary compatibility gate, not a new application test suite.
- Dynamic relocation checks resolve against the staged r18 library without
  missing libraries/symbols. All toolkit imports resolve: QQTerm 4, QindaWeb 21,
  QindaHane 6. The five relevant public headers remain byte-identical to r17.
- The packaged `qtk-preview`, library and QML module instantiate the retained
  designer fixture under offscreen/software rendering on a private bus with
  exit 0 and no warnings. This checks the installed-layout module paths.

Evidence and reproducible audit scripts are retained on qinda at
`/mnt/archive/cabewse/qindatk/r18-package-evidence-20261010/`. Original build logs
also remain in `~/scratch/qqo/` as `qindatk-r18-package-resume.log`,
`qqterm-r18-package.log`, `qindaweb-r18-package.log` and
`qindahane-r18-package.log`. The initial QindaWeb failure is preserved separately.

Before adoption, both hosts reported installed `dev-libs/qindatk-0.1.0-r17`;
its library hash was unchanged:
`02b99ea493dfa19cafd181dca504cbccfe1761b83957de81f85d94bc9b990fc8`.
The QindaWrite long-document fix is carried into the Office r2 source. These
artifacts qualify the non-Office direct consumer set; physical
tablet/GPU/browser/session acceptance remains a separate manual gate.

## Integrated Office r18 delivery

`gui-apps/qindaoffice-0.1.0_p20261010-r1` pins QindaOffice
`be79420cf18a432a5979fc693148334536b73a45` and depends on toolkit
`>=0.1.0-r18:0/18`. It combines Word sections, graphics, references and
equations, Calc and Show work, Note/Base/Mail work, the bounded long-document
display repair, and the Books employee/time IIF migration. The exact
8,236,484-byte source archive was cut independently on the laptop and qinda;
both SHA256 digests are
`75b405405295882b5aafe775779aa8cf76fc25d2c822e1c3557d4c1b2e5e4aae`.
The archive carries the reviewed `.dist-commit` and QXlsx submodule source.
Its Manifest line and package remain an immutable qualification checkpoint;
r2 is the selected delivery.

The final test-source correction has its own, immutable
`gui-apps/qindaoffice-0.1.0_p20261010-r2` snapshot rather than replacing
the r1 archive. It pins QindaOffice
`9b5b18493569fdfa8b16228d1d4b264623109604`; the application sources
are the same, while the Mail Quick Steps host catalogue expectation and a
Qt moc-readable mixed Word regression are corrected. Laptop and qinda cuts
of the 8,236,588-byte r2 archive match SHA256
`15477c73343d740e32bc251baa97186bb18837cde168ed82aa3e0aafdedaf110`.
Its `.dist-commit` matches the pin, QXlsx is vendored, and the separate r2
Manifest line is recorded. The r1 candidate remains private and is not the
selected delivery.

The integrated r18 source passed a 28-target affected-workflow CTest batch:
**28/28 targets, 381 Qt checks passed, zero failed, two optional owner-corpus
skips**. This covers DOCX, math, Write, Show, Books and Mail on the frozen
toolkit. The exact r2 source then passed all **8/8 focused CTests and 81/81
Qt checks**, with zero failures, skips or Qt warnings. The final-source
qualification record is at
`/mnt/archive/cabewse/qindaoffice/r18-qualification-final-9b5b184/` on qinda.

The r2 Portage package completed with the configured qinda
`MAKEOPTS=-j24 -l24` unchanged. Its signed gpkg is 43,212,800 bytes,
SHA256 `7e158610f235a562a0a1f45226c55473b9653391d9b665b9c9914600fc0b1ef9`.
The full gpkg signature and digest audit passed; its embedded recipe matches
this revision, all 68 installed regular files match Portage's staged image,
and all ten ELF binaries have no private build or home-directory RUNPATH.
Package metadata requires QindaTK `>=0.1.0-r18:0/18`. The audit record is
`/mnt/archive/cabewse/qindaoffice/r18-office-r2-package-audit.json` on qinda.
The preceding r1 checkpoint also passed the same audit but is not delivered.

## Coordinated adoption (2026-10-10 MDT / 2026-10-11 UTC)

Portage installed the exact audited binaries on both hosts: QindaTK r18,
QindaOffice `0.1.0_p20261010-r2`, QQTerm `0.3.0-r1`, and QindaWeb
`0.1.0_alpha1-r1`. The laptop also installed QindaHane r25. The private
binary-only resolver planned four upgrades on qinda and five on the laptop,
without a source rebuild. QQTerm and QindaWeb were built with `USE=test` for
their qualifying CTests while the hosts default to `-test`; adoption used
Portage's explicit `--binpkg-respect-use=n` for this known difference.

Both installed QindaWrite binaries have SHA256
`b67edb396318d2071eac195c1a637d2c2ce017b0c206de0d6a3dc01ab9555619`;
both installed QindaTK libraries have SHA256
`1ed23a6716913c6152914ae66e5ad852430dec84227a55b201ebfc8559c4bf08`.
The installed Office, QQTerm and QindaWeb metadata requires toolkit subslot
`0/18`, as does QindaHane on the laptop. Dynamic linking reports no missing
libraries or unresolved symbols for those binaries. Portage's
`@preserved-rebuild` set is empty on both hosts. No live desktop process was
restarted; physical tablet/GPU/browser/session checks remain manual.
