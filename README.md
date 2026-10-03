# QindaGentoo — the Sloom Studio / QindaQt Portage overlay

Repository name: `qindaqt`. One overlay for everything developed here:

| Package | Source project |
| --- | --- |
| `gui-wm/qindaqt-desktop` | `container-wm` |
| `gui-apps/qindaqt-apps`, `gui-apps/qindaqt-system-monitor`, `gui-apps/qindaqt-removable-media` | `container-wm` |
| `gui-apps/qindaoffice` | `QindaOffice` |
| `gui-apps/qqterm` | `QindaQt_Apps` |
| `www-client/qindafox-bin` | `QindaQt_Apps/QindaFox` |
| `dev-util/opencode-bin` | OpenCode official Linux release, packaged through Portage |
| `gui-wm/qindastudio` | `QindaStudio` |
| `app-misc/venusprolinux` | `QindaVenusPro` (Venus Pro mouse utility with the QindaTK interface) |
| `app-office/obsidian` | Obsidian public Linux desktop release, packaged through Portage |
| `sys-boot/qinda-boot` | `QindaBoot` (graphical boot menu and Plymouth splash) |
| `sci-ml/qinda-llm-server` | `QindaLLM` (LLM Server mode, qinda only) |
| `gui-apps/qindallamawatch` | `QindaLlamaWatch` (desktop monitor for a remote llama.cpp server; counterpart of `qinda-llm-top`) |
| `app-portage/qindaportage` | `LocalAiPortage` (QindaPortage: Portage manager with a local LLM, dependency graph, impact previews, qinda-local overlay for URL installs) |
| `media-gfx/qindahane-bin` | `QindaHane` (Tiltmark painting app; proprietary prebuilt archive cut by its `tools/package-gentoo-bin`, fetch-restricted) |
| `app-accessibility/gabbee` | `gabbee` (dictation; QindaQt's `org.qindaqt.Voice1` provider) |
| `x11-themes/qinda-seven` | `QindaThemes` (seven themes, paired decorations, and KDE color schemes) |
| `kde-plasma/sloom-globalmenu`, `kde-plasma/sloom-panelmenu`, `media-gfx/sloom-studio-bin` | `sloom-studio-gpl` |
| `kde-plasma/kwin`, `kde-plasma/plasma-activities` | retained pinned 6.6.x copies for older desktop deliveries |

### Removable media

`gui-apps/qindaqt-removable-media` owns the removable-media executable, launcher
and compatibility XDG autostart entry. It builds only the `RemovableMedia`
component from the reviewed source; the desktop package owns shared QML runtime
libraries. Future desktop recipes using that source must configure
`-DQINDAQT_BUILD_REMOVABLE_MEDIA=OFF` to avoid overlapping package files.
The source supervisor owns the helper in new sessions; the session-bus singleton
makes the compatibility autostart's second `--watch` invocation inert.
UDisks and the FAT/exFAT/ext4 providers are Portage dependencies. The initial
unreleased, rejected recipe is masked; r2 is in the shared delivery. Its dependency floor is the current shared
pre20260927-r7 desktop; the component also runs on the laptop's newer desktop.

### Supplied Breeze Painted icon family

`x11-themes/qinda-breeze-painted-1.0.0_p20260929` installs the complete supplied
`QindaQt-Breeze-Painted` XDG family under `/usr/share/icons`: 7,172 unchanged
128 x 128 RGBA PNG category/name paths and the original `index.theme`.
It is independent of QindaThemes and introduces no desktop dependency or
selection change. Its only runtime dependency is the system hicolor theme;
Breeze in the original inheritance list is an optional ambient fallback.

The immutable fetch-restricted `${PF}.tar.gz` consolidates the ten original
2026-09-29 icon batch ZIPs plus Source-and-Manifest ZIP. Its `INPUT-SHA256SUMS`
pins all eleven input files, and `PACKAGE-README.txt` records upstream Breeze
snapshot `533733ff0b463f4d1118b22595346b99be0029fd` and preservation scope.
The archive contains the complete original source companion, manifests,
licenses, renderer/build source and modification notices. Installed originals
are retained uncompressed under `/usr/share/doc/${PF}/theme` and `/source`;
the supplied shell installer is documentation only and must never be run.
This artwork is the supplied procedural gouache/ink treatment, not the later
separate hand-drawn family.

Archive: `qinda-breeze-painted-1.0.0_p20260929.tar.gz`, 94,243,325 bytes;
SHA256 `c92ca981df77279751c089e27b0f2ea115f1105d41b72ef15cc0b825a05176ef`.
The Portage Manifest pins its BLAKE2B and SHA512 as well. Exact original inputs
(SHA256, matching the archived INPUT-SHA256SUMS):

```text
865aa9cf5e3192b03fa1c92255851cac638fde65275b0b980f0d59fa9be28064  QindaQt-Breeze-Painted-01-of-10-720-icons.zip
e1f7abd659c1ebac8032e2ef46fada460a0441bf38b2e0cee46347ce5e9e8d1f  QindaQt-Breeze-Painted-02-of-10-720-icons.zip
953bea4a430c596d15865653b478e3a3c3c0e38beac6ee45fc821cd7705a9bac  QindaQt-Breeze-Painted-03-of-10-720-icons.zip
c8da3bf972a41f07de5278a45265cac39ef3c1871439126eefcce9db160e35ce  QindaQt-Breeze-Painted-04-of-10-720-icons.zip
7fe9ee006c6dfbcd923f053b83d804d089fec31307d3066f95b68058d9287be9  QindaQt-Breeze-Painted-05-of-10-720-icons.zip
479703559fe4524c26080cfb7dafe45dc81bfaeb36b88ceede62ae584a42d3be  QindaQt-Breeze-Painted-06-of-10-720-icons.zip
2319a3033040ab2854729df96c0e88535dd4a025b02ba2201dc6e8daa04ef736  QindaQt-Breeze-Painted-07-of-10-720-icons.zip
69924a8338ded774636a6075ad67e19ebcc2ba5ebc57c90aa59f65c44c7562a6  QindaQt-Breeze-Painted-08-of-10-720-icons.zip
89ff0fb5dd62a89dfb06e6a6a46f79637a4e68926b5169f975f216490c554161  QindaQt-Breeze-Painted-09-of-10-720-icons.zip
47839d5a83de2834ee9f607ee1d316f748c16cb8ed66339407a253a257836bf9  QindaQt-Breeze-Painted-10-of-10-692-icons.zip
c236ae058dcec5fb252e844c313a87f6910c235843399595238ef0a37de5457e  QindaQt-Breeze-Painted-Source-and-Manifest.zip
```

The source preparation verifies all supplied PNG hashes, dimensions and RGBA
modes and the complete 7,172-file runtime inventory. Package-image and installed
QA must compare the original manifest against the runtime icon root, verify
Portage ownership/integrity and read-only native catalog/QIcon rendering, and
confirm that the existing selected icon family stays unchanged on both hosts.
Settings discovers the valid installed XDG index through the existing bounded
catalog; no hard-coded registry or forced Settings write is needed.

### Complete hand-rendered icon family

`x11-themes/qinda-breeze-handdrawn-1.0.0_p20261001` packages the independent
`QindaQt-Handdrawn` XDG family: the same 7,172 category/name paths as the supplied
painted pack, backed by 3,261 distinct canonical colored-pencil and pastel
drawings. Original source-identical aliases share their corresponding drawing.
The runtime consists of static 128 x 128 RGBA PNGs with authored colors;
symbolic filenames do not introduce runtime recoloring. All twelve categories
have fixed128 discovery metadata and only hicolor is a runtime dependency.

The source is QindaIconArt commit
`6cdcfeccf22411534f2b0fb07579c7c53c5e73b6`, independently verified complete with
zero missing names or provenance errors. The fetch-restricted archive is
`qinda-breeze-handdrawn-1.0.0_p20261001.tar.xz`, 740,774,588 bytes, SHA256
`6a8e2810c331c6a47f42989fcac85a88c984bea03d077279642c78926b55cb5d`;
its prefix is `QindaIconArt-6cdcfeccf22411534f2b0fb07579c7c53c5e73b6/`.
The Manifest also pins SHA512 and BLAKE2B. The archive retains original raster
references, raw generated atlases, prompts/tool records, unchanged-pixel crop
proofs, per-atlas reviews and the source-bound release manifest. The hand-rendered
appearance was generated with ImageGen; it is not a claim of human authorship.

Source preparation verifies full artwork provenance, then rebuilds the complete
release manifest and rejects incomplete authoring checkpoints before installation.
Runtime `COPYING-ICONS` and `HANDDRAWN-MODIFICATIONS.txt` prominently preserve
LGPL notices and explain the separate method. Source notices and release proofs
remain uncompressed under `/usr/share/doc/${PF}`. Complete raw provenance is
available in the pinned source archive without duplicating it in the runtime
package. The package makes the theme available for discovery and never changes
the saved icon choice. Delivery requires package-image byte/inventory checks,
native QindaQt catalog and twelve exact Qt render samples, followed by Portage
ownership, integrity and signed-binary identity checks on each host.

### Plasma-free runtime dependency gate (PF25)

`tools/check-plasma-dependencies` checks only the resolved runtime closure rooted
at exact QindaQt desktop and fork package versions. Stock Plasma may remain
independently installed: it fails the gate only when a runtime dependency path
from either root reaches it. The final allow-list is exactly
`kde-plasma/kwayland` and `kde-plasma/layer-shell-qt`; no temporary locker or
shortcut exceptions and no global Plasma masks are introduced.

After configuring the reviewed candidate repository/profile in a clean Portage
image, supply both immutable recipe versions (these example versions are
placeholders, not a published delivery):

```sh
tools/check-plasma-dependencies --resolve \
  --root '=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r2' \
  --root '=gui-wm/qindaqt-kwin-6.6.6_p1-r3'
```

This invokes Portage's backtracking resolver in pretend/empty-tree mode with
world selection and automatic configuration writes disabled. It does not fetch,
merge, unmerge, update world, change profiles or start services. Its traversal
uses selected alternatives, USE flags and virtual providers and follows both
RDEPEND and PDEPEND (including runtime slot-operator edges). Build-only edges
are excluded from the reported runtime closure; the source resolver can still
refuse candidates whose build dependencies cannot be solved. Candidate selection
uses the configured repositories/profile; isolated, unregistered worktree recipes
are not magically visible. This gate does not qualify build-time dependencies,
co-installation files, physical login, portals, locks or secret migration.

For a read-only installed diagnostic, `--installed` accepts one or both exact
roots and uses installed metadata without dynamic recipe substitution. A
single-root diagnostic is **not** the final two-root delivery gate:

```sh
tools/check-plasma-dependencies --installed \
  --root '=gui-wm/qindaqt-desktop-0.1.0_pre20260927-r7'
python3 -m unittest discover -s tests -p test_plasma_dependencies.py -v
```

Exit 0 means the inspected graph passes the category policy, exit 1 reports every
reachable forbidden package with a shortest dependency chain, and exit 2 means
invalid input, unavailable roots, incomplete resolution, unsupported resolver
API, or malformed graph. A missing fork/root cannot produce a final gate pass.
The installed diagnostic refuses runtime nodes needing installation. Neither
mode calls Portage's scheduler or commits mtimedb. The resolver adapter uses
private Portage APIs (qualified initially on 3.0.81.3); API drift fails closed
and requires a focused adapter recheck.

`--graph FILE` inspects a supplied resolved-runtime snapshot for review/fixtures;
it explicitly reports that this is not Portage resolution evidence. Schema 1 has
exactly `schemaVersion:1`, `roots:[exact-cpv,...]` naming both roots and
`nodes:{exact-cpv:[runtime-child-cpv,...]}`. Every root and edge must exist;
duplicate keys/roots/edges and unknown schema fields are rejected. Supplied
snapshots cannot prove that a producer included every dependency, so use
`--resolve` for real candidate acceptance. Focused tests cover shared libraries,
forbidden direct/transitive paths, unrelated installed Plasma, runtime versus
build edges, PDEPEND, cycles, duplicate identities, and fail-closed input/API
errors.

### Documentation build tools

The `dev-python/mkdocs` recipe and its small Python dependency recipes keep the
QindaQt wiki's required `mkdocs build --strict` gate available through Portage.
They are developer tooling and are not entries in `metadata/qinda-delivery`.

### Third-party packages

`app-office/obsidian` packages Obsidian's official Linux release tarball and Debian metadata archive through Portage; its ebuild, license text, and checksums are tracked here.

`dev-util/opencode-bin` packages the official OpenCode Linux CLI release through
Portage so the version and release checksum are shared by both Qinda hosts.

`sci-ml/qinda-llm-server` and `sci-ml/gguf-coding-models` are qinda's local
coding-model service. `qinda-llm.service` runs llama.cpp's `llama-server`
(::guru's `sci-misc/llama-cpp[vulkan]`, on the RX 5700 XT through RADV) in
router mode with an API key, over the Ornith 1.5 35B-A3B GGUF weights (Qwen3.6
35B-A3B optional) pinned to Hugging Face revisions under `/usr/share/gguf`. Settings are
in `/etc/qinda-llm/`. Its "LLM Server" boot mode (`qinda-llm-server.target`)
skips SDDM and the desktop and shows the `qinda-llm-top` console on tty1. It
runs on qinda only, so it is not in `metadata/qinda-delivery`; qinda-top's
coding agents reach it over Tailscale.

`sci-ml/qinda-notes-llm` is the laptop's offline notes model for QindaNote's
live notes: Qwen3.5-4B (unsloth UD-Q4_K_XL, pinned; USE=vision adds the
image projector) under `/usr/share/gguf`, served by the same
`sci-misc/llama-cpp[vulkan]` on the integrated GPU. It is on demand:
`qinda-notes-llm.socket` listens on `127.0.0.1:8080`, the first connection
starts llama-server and waits for the model, and it unloads after
`NOTES_IDLE_EXIT` (15 min) without a connection. Settings are in
`/etc/qinda-notes-llm/serve.env`; enable once with
`systemctl enable --now qinda-notes-llm.socket`.

`sys-boot/qinda-boot` is the boot experience of both hosts: a themed rEFInd
menu of boot modes in `EFI/qinda` on the ESP (first in the firmware boot
order, systemd-boot kept as fallback and "Advanced" row) and the `qindaqt`
Plymouth splash. First deployment is `emerge --config sys-boot/qinda-boot`,
then an initramfs rebuild; kernel updates keep the menu current.

`net-wireless/*` is the SDRangel software-defined-radio stack: `sdrangel` itself
plus the twelve upstream libraries it needs that Gentoo does not package
(`aptdec`, `cm256cc`, `cspice`, `dab-cmdline`, `dsdcc`, `ggmorse`, `inmarsatc`,
`libsigmf`, `mbelib`, `serialdv`, `sgp4`). These are not developed here; they
live in this overlay because it is the version-controlled one, so the patches
carried against them are tracked and reach both machines. `licenses/CSPICE` is
the NASA/Caltech licence `net-wireless/cspice` refers to.

`sci-ml/ctranslate2`, `dev-python/faster-whisper`, `dev-python/av` and
`app-accessibility/faster-whisper-models` are Gabbee's offline dictation,
`app-accessibility/gabbee[whisper]`, which is on by default: when online
recognition fails, the recording is transcribed on the machine itself.
They are the CTranslate2 engine built on oneDNN for the CPU, faster-whisper
on top of it, PyAV (a verbatim copy of ::guru's, because this overlay's only
master is ::gentoo), and Whisper models pinned to upstream revisions and
installed under `/usr/share/faster-whisper`, so nothing is downloaded at run
time. `distil-small.en` is the default model, chosen by measurement on both
machines; the `base-en` and `large-v3-turbo` USE flags add others. The profile
accepts the `~amd64` Hugging Face packages they need from ::gentoo.

`profiles/qindaqt/systemd` is the desktop profile: parent
`default/linux/amd64/23.0/desktop/systemd` plus the QindaQt package set,
USE defaults, keywords and licenses. Select it with
`eselect profile set qindaqt:qindaqt/systemd`.

The profile installs `x11-misc/qindaqt-xdg-menu` so KWin can resolve installed application desktop entries for screenshot and portal permissions after Plasma removal.
The r6 desktop package holds exclusive native power composition off until its physical login receipts are qualified; Power1 remains installed and active while the session uses the nonexclusive path.

The profile installs `x11-misc/dotool` for Gabbee's focused-window typing
route and `x11-themes/qinda-seven` for the appearance catalog. The latter pins
the source-controlled theme pack in the local Git hub; Portage owns its 21
installed data files. The user still chooses a theme in Settings → Appearance.

## Workflow

1. Bump an ebuild in the source project's `packaging/gentoo/` (or edit here directly).
2. Copy the completed recipe and its Manifest entries into this tree, preserving
   other packages.
3. Update `metadata/qinda-delivery` to name the exact versions to share, then commit
   the overlay. `qinda-sync code .` publishes the committed branch to qinda.
   `qinda-sync publish /path/to/package.tar.gz` verifies its Manifest and makes
   the archive available in qinda's `/var/cache/distfiles` from either machine.
4. Run `qinda-sync` on either machine to install that delivery through Portage.
   From qinda, `tools/push-to-laptop` runs the same command on `qinda-top`.

Both machines point their `qindaqt` repo at this git repository
(`sync-type = git`), and the laptop also pulls binaries from the desktop's
binhost on port 8090.

## One command on either machine

`tools/qinda-sync` is installed as `/usr/local/bin/qinda-sync` on both hosts.
Run it as `cabewse`; it uses passwordless sudo only for Portage-owned files and
installation. The default command reads the committed `metadata/qinda-delivery`
from qinda's bare Git hub, obtains missing archives and pinned shared Git sources,
preserves existing overlay entries, and asks Portage to install those exact
versions. Available binaries use the existing binhost; source builds retain the
host's configured compiler flags and `MAKEOPTS`. On qinda the install also
writes a signed binary package (`--buildpkg`), so `qinda-sync` on `qinda-top`
then installs the same build from the binhost. Already installed versions are
skipped. It never updates `@world` or restarts the desktop.

```sh
qinda-sync                              # install the published delivery here
qinda-sync packages --prepare-only       # fetch inputs and show the package plan
qinda-sync packages =x11-misc/qinda-patrol-0.2.0
qinda-sync code ~/work_space/container-wm # exchange committed work with qinda
qinda-sync publish /path/to/package.tar.gz # supply an archive built on either host
```

For code, run the command in each checkout when publishing or receiving work.
It uses qinda's existing `/home/cabewse/git/PROJECT.git` repositories, fast-forwards
when one side is ahead, and pushes the current branch without force. Dirty trees
or divergent branches stop with Git's explanation; unfinished work is never
auto-committed, reset, or overwritten. Other checked-out worktrees remain under
their current owner's control. New projects need a bare repository on the hub.

Conflicting existing recipes or archive hashes also stop for an explicit version
bump; the helper does not repair unrelated overlay changes. Updates run when
invoked, so an offline laptop catches up with one command when it reconnects.
There is no background timer. `QINDA_HUB` overrides the SSH host alias if needed.

### Prepared native desktop cutover (2026-10-02)

The new desktop `0.1.0_pre20261002-r2` and fork `6.6.6_p1-r3` recipes are
exact manager source freeze candidates, **not release-qualified delivery**.
Desktop source is `29f7174a62175475f6ba54fa7627dc2fd4c8a21f`; fork source is
`55d1f2738723316fae4686468757aef66ce7590b`. Matching private qinda archives
and actual new Manifest rows are prepared for independent review. Native/runtime
qualification, publication and installation remain pending manager gates.
The held fork p1 recipe/archive are preserved on their original
branch; p1-r3 retains source ABI serial1 (6.6.6.1) and uses `${PF}.tar.gz`,
so new source bytes never replace the held p1 archive.

The profile now derives from the ordinary Gentoo desktop/systemd profile,
adds the native fork, and stops selecting KDE portal/polkit and Sloom Plasma
applet packages. Existing independently installed Plasma packages and user
world remain untouched. Desktop/fork runtime dependencies keep only the
explicit PF25 KWayland and LayerShellQt allowances. Native session lock and
Schedule1 nightlight are fork built-ins; `KWIN_NATIVE_SHORTCUTS=ON` selects
the reviewed native adapter, Activities are OFF, and the desktop selects
`QINDAQT_NATIVE_POWER_EXCLUSIVE=ON` with ordinary native QtQuick presentation.
The frozen desktop source includes the reviewed native Power option and
startup-failure repair. Its portal composition exports 13 ordinary interfaces
and 5 protected sharing/input interfaces, with all 18 selected natively and a
closed default; source review does not qualify their runtime behavior.
CUPS and Qt PrintSupport supply the native Print portal's existing FD/spool
flow.

Review uses a task-local candidate repository and profile through process
settings only. Read-only two-root PF25 resolution on **each** host is required;
a syntax pass, empty synthetic graph, missing source archive or unresolved
Portage graph does not count as delivery. Host configuration is not changed
by preparation. Laptop resolution waits while its test lock exists. Final
source qualification, archive publication, integrated runtime gates and install
remain manager-owned.

The first actual two-host PF25 candidate resolution found KIO's unconditional
`kde-plasma/keditfiletype` post-dependency (and its `kde-cli-tools-common`):
579 runtime packages on qinda-top and592 on qinda, two forbidden providers
each. The narrow matching KIO6.27/6.29-r1 recipes preserve implementation and
all other dependencies, omitting only that external association editor because
QindaQt Settings and File Manager Open With already edit MIME app associations.
See `kde-frameworks/kio/QINDAQT-PROVENANCE.md` for original recipe/patch hashes
and the standalone utility's broader limits. Subsequent805 closure passed589 packages on qinda and576 on qinda-top,
zero forbidden on both; those receipts remain bound to their original roots.
Final revision2/revision3 closure must be recorded separately.

The Gabbee `0.1.0_p20261002` checkpoint pins integrated source
`0a232449a64ac54b1c065ec391f6ba53f7fbe95e`, which selects native QindaQt
KWin scripting endpoints and binds watchdog recovery to the physical native
compositor/portal pair while preserving independent stock compatibility.
The new desktop floor selects that snapshot. In `qindaqt` mode its recipe
installs the frontend physical-session drop-in and native recovery unit
drop-ins, omitting the obsolete KDE portal backend drop-in; generic stock
fallback source remains unchanged. This git-r3 recipe retains the existing
local-hub source workflow and has no source distfile/Manifest digest to invent.
Build-only signing and manager review precede publication or installation.
Native watchdog source was independently reviewed and its40 focused fixtures
passed on qinda. Signed build-only output is package preparation; installed
physical-session behavior remains a separate manager gate.
The r2 Gabbee recipe pins `a8b54c8`: physical login generation changes and two failed Display1 snapshots permit bounded recovery. The r3 recipe pins `7b0af2f`: a fresh login retains its healthy session-owned native portal, even if D-Bus unique names repeat, and restarts only stale portal peers before dictation rebind. The isolated-bus r3 source suite passed 375 tests and 20 subtests; installed physical-session behavior remains a separate gate.

Final desktop revision 2 and fork revision 3 preserve all earlier recipes and
archive records. Historical fork revision 1 has a bare-modifier parser defect;
revision 2 lacks native repeat activation. Neither is final delivery. Revision 3
includes both reviewed fixes, retains exact6.6.6.1 ABI, and is undergoing the
authorized private signed build-only. The final desktop source includes the
accepted helper regression and release documentation. Exact two-host closure,
manager runtime acceptance and installs remain separate gates; no old source
archive is recut under its existing filename.

Desktop revision 1 remains a superseded archive/source candidate. Revision 2
includes the independently accepted native release contract and fork pin
metadata repair. Root reports actual native Shortcuts 8/8 and protected input
receipts accepted; package build/signature/installed gates stay separate.

### Prepared installed-application Plasma edge cleanup

The matching installed-version KAuth6.27-r1, Kirigami-addons1.12.1-r1 and
KDEConnect26.04.3-r4 recipes preserve upstream implementation and licensing.
KAuth retains its Polkit backend while the native session supplies its agent;
Kirigami drops an unused Plasma metadata dependency; KDEConnect adds a
default-on optional Plasma applet without removing its daemon or applications.
The native profile disables only that applet, Sloom's Plasma panel menu,
xdg-utils' Plasma integration and LXQt's separate monitor module. The native
Settings display controls remain the native profile's display route.
Per-package QINDAQT-PROVENANCE.md binds original recipe/patch and source hashes.

These source/metadata candidates do not unmerge apps, change host world,
qualify newer upstream versions, or prove installed runtime readiness.
Six focused metadata/source-preparation checks cover native/default behavior.
Actual builds, QML/app smoke, native Polkit agent registration and reviewed
per-host world/depclean plans remain manager gates. The earlier exact-root
PF25 receipts are not relabeled as installed-world closure evidence.

### Prepared native application portal and Secret Service providers

Claude 1.49585.0-r1 keeps its exact vendor archive and launcher while new
default-OFF qindaqt USE selects Desktop-r2 and supported trash-cli. Pinentry
1.3.2-r2 retains all GUI/optional caching choices and uses the generic Secret
Service virtual instead of a hardcoded GTK keyring daemon. Virtual 0-r3 keeps
the original stock provider alternatives and selects Desktop-r2 in native mode.
Ten focused source/metadata checks pass; actual selected graph evidence chooses
native portal/Secret Service and trash providers without KDE portal/cli or
GNOME/PAM descendants. The graph has an explicit native runtime-provider cycle;
resolver success is not a no-cycle or installed-readiness claim.

Per-package provenance binds unchanged original archives, patches and launcher.
No app/data/credential change, build, installation, migration or daemon stop is
part of this source checkpoint. The manager owns provider-file collision and
rollback handling before Desktop installation, plus physical application and
Secret Service registration gates. Matching installed-version build dependencies
are checked against the installed VDB; do not trigger an unrelated deep newuse
world upgrade to rebuild these narrow recipes.

Laptop Pinentry1.3.3 uses matching1.3.3-r1; qinda1.3.2 uses1.3.2-r2.
The same provider-only substitution preserves each installed upstream revision.
Both versions' required build dependencies are present in qinda's actual VDB,
allowing manager review of independent signed build-only without a downgrade or
unrelated KF upgrade. Laptop targets omit qinda-only KDEConnect/LXQt/Gwenview.

Before its first binary artifact, desktop-r2 carries an install-only downstream
patch corresponding exactly to upstream8a622b4b76d25d509ca50e8ca7fbf62d62753a4e.
It installs the actual Keyring `_qml.qmltypes` filename bound by generated
qmldir. The immutable29f archive and compiled application code are unchanged.
Retained Portage phase continuation uses independently accepted source and recipe
changes; package signing and installed qualification remain separate gates.
