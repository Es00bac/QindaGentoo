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
| `kde-plasma/kwin`, `kde-plasma/plasma-activities` | pinned 6.6.x copies the desktop's KWin plugin ABI needs |

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
  --root '=gui-wm/qindaqt-desktop-0.1.0_pre20261001' \
  --root '=gui-wm/qindaqt-kwin-6.6.6_p2'
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
`default/linux/amd64/23.0/desktop/plasma/systemd` plus the QindaQt package set,
USE defaults, keywords and licenses. Select it with
`eselect profile set qindaqt:qindaqt/systemd`.

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
