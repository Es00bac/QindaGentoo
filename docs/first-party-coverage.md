# First-party non-game project coverage

This is the source-to-package map for the Qinda family. A repository is not
necessarily a desktop application: companion tools and documentation remain
optional, while firmware, private data and the overlay itself have different
installation boundaries. Package presence is not a claim that the latest
source commit is installed or that hardware/live-session acceptance passed.

The qinda bare hubs remain the development source of truth. Public repository
names below are under `github.com/Es00bac`; `LocalAiPortage` is published as
`QindaPortage`, and `container-wm` is published as `QindaQt`. Historical recipes
retain their exact commits, archive bytes, fetch restrictions and licenses.
Publishing a repository does not change those contracts.

| Source hub / public project | Overlay package coverage | Installation boundary |
| --- | --- | --- |
| `container-wm` / `QindaQt` | `gui-wm/qindaqt-desktop`; `gui-apps/qindaqt-apps`, `qindaqt-system-monitor`, `qindaqt-removable-media`, `qindaqt-windows-runner`, `qindaqt-android-applications`; `media-plugins/obs-qindaqt` | Desktop and independently versioned components; existing exact delivery controls adoption. |
| `qindaqt-kwin` | `gui-wm/qindaqt-kwin` | Co-installable compositor fork with its exact plugin ABI. |
| `QindaTK` | `dev-libs/qindatk`, `dev-libs/qindatk-raster` | Shared toolkit and pure QML/raster companion. |
| `QindaOffice` | `gui-apps/qindaoffice` | Native office applications; archived dependencies stay vendored. |
| `QindaStudio` | `media-gfx/qindastudio` | Graphics application; this is its current category, not the old `gui-wm` README name. |
| `QindaQt_Apps` | `gui-apps/qqterm`, `www-client/qindafox-bin` | Terminal and nested `QindaFox` browser project; the browser keeps its accepted binary archive. |
| `QindaMPV` | `media-video/qqmpv` | Media player. |
| `QindaThemes` | `x11-themes/qinda-seven`, `x11-themes/qinda-icons` | Appearance data; user selection remains separate. |
| `QindaIconArt` | `x11-themes/qinda-breeze-painted`, `x11-themes/qinda-breeze-handdrawn` | Independent artwork families and provenance; original archives remain immutable. |
| `gabbee` | `app-accessibility/gabbee` | Dictation service with existing dependency/activation policy. |
| `sloom-studio-gpl` | `kde-plasma/sloom-globalmenu`, `kde-plasma/sloom-panelmenu`, `media-gfx/sloom-studio-bin` | Existing Plasma integrations and Studio binary delivery. |
| `QindaVenusPro` | `app-misc/venusprolinux` | Mouse utility; device qualification remains separate. |
| `screensaver-suite` | `x11-misc/circuit-reef`, `qinda-patrol`, `prism-circuit`, `prism-brawl`, `starward-reimagined` | Screensavers built from the integrated suite, including legacy standalone project names. |
| `circuit-reef`, `qinda-patrol` | `x11-misc/circuit-reef`, `x11-misc/qinda-patrol` | Earlier standalone repositories remain source history; current recipes use `screensaver-suite` and do not install duplicates. |
| `QindaBoot` | `sys-boot/qinda-boot` | Original code GPL-3+; reused artwork retains reserved/separate terms. Publication never deploys to an ESP or changes firmware. |
| `QindaLLM` | `sci-ml/qinda-llm-server` | GPL-3+ service/configuration sources; external runtime/model licenses and activation are independent. |
| `QindaLlamaWatch` | `gui-apps/qindallamawatch` | Desktop monitor for a separately configured server. |
| `LocalAiPortage` / `QindaPortage` | `app-portage/qindaportage` | Portage manager; existing source pin is unchanged. |
| `QindaPhotocraft` | `media-gfx/qindaphotocraft` | Native PhotoCraft; exact repository spelling is retained. |
| `QindaWeb` | `www-client/qindaweb` | Experimental native-browser branch; README-only `main` is not a replacement for the accepted implementation pin. |
| `QindaFoxAgent` | `www-plugins/qindafox-agent` | Optional CLI/MCP, native host and unsigned browser extension; details below. |
| `QindaTK-agent-guide` | `app-doc/qindatk-agent-guide` | Optional static teaching website and recorded media; no server or hosting setup. |
| `JevReader` | `dev-util/jevreader` | Optional Python CLI/MCP reader; no model, service or agent auto-registration. |
| `QindaDeck` | `app-misc/qindadeck-tools` | Optional GPL-3+ host CLI, schema and docs only; no firmware/Android installation. Third-party source notices are retained. |
| `QindaGentoo` | This overlay | Portage repository/profile metadata, not a redundant package of itself. |

`QindaHane` remains proprietary and is already covered by fetch-restricted
`media-gfx/qindahane-bin`; it is not part of open-source publication.
`RecoveryBackup` is private backup data, `QindaVBAN` has no source commit in its
hub, and `floor-body-150` is unrelated hardware work. None is an installable
non-game software addition. Game repositories and third-party model
packages are outside this first-party coverage change.

## Optional developer companions

The four new packages are keyworded for explicit selection but absent from
`profiles/qindaqt/systemd/packages` and `metadata/qinda-delivery`. Existing
profile/USE policy, compiler parallelism, host services and user preferences
are unchanged.

- `www-plugins/qindafox-agent-0.1.0_p20261012` pins QindaFoxAgent
  `9316a5aecf0eb75105cece809eb372eea27a859e` (MIT). It installs wrappers under
  `/usr/bin`, plugin/skill/unsigned-extension assets under
  `/usr/share/qindafox-agent`, and native messaging manifests for Gentoo and
  prebuilt Firefox. These manifests permit only `agent@qindafox.local`; the
  native process starts only after a user explicitly loads that extension.
  The optional `launcher` USE flag adds geckodriver and an isolated-browser
  wrapper. The package neither loads an extension nor registers a Codex/MCP
  client. The upstream home-directory installer is not installed. A focused
  downstream path repair makes remote Jev mode invoke the Portage-owned
  `qindafox-agent-jev` command on the chosen host instead of a home checkout.
- `app-doc/qindatk-agent-guide-0.1.0_p20261012` pins
  `3d515432d65fedffe8ce047c455e4316c092063b`. Code/text are LGPL-3+ and reused
  fictional showcase media are GPL-3+, as recorded in `dist/sources.md`.
  Static assets install under `/usr/share/doc/${PF}/html` without compression;
  ES modules need an explicitly started HTTP server. No web server dependency,
  service, Sites project settings, speech generation or model access is added.
- `dev-util/jevreader-0.1.0_p20261012` pins
  `843cae73e43a31d084edc809d9c67ae58ddf358c` (GPL-3+ source SPDX declarations).
  Python modules and CLI/MCP wrappers are packaged. `outline` reads locally;
  optional relevance operations can use the user's preconfigured remote Jev
  backend. The package installs no key, model, service or client configuration.

- `app-misc/qindadeck-tools-0.1.0_p20261012-r1` pins
  `38f3731652058114288d96d592f3750a45774ff7`. The host CLI `deckctl`, protocol
  schema and reference docs are available without installing the Android or
  firmware toolchains. Optional `zeroconf` adds Python discovery; an explicit
  `--host` works without it. No command is sent to a device while packaging.
  The owner grants GPL-3+ for original code. Upstream README and LICENSE are
  installed. The earlier conservative recipe/archive remains available.
  Gradle Apache-2.0 and Espressif Unlicense/CC0 source notices remain
  intact in the archive, though those components are not built or installed.

For the two model-capable tools, remote key paths and host selection retain
upstream's user-configuration contract. Nothing reads credentials or contacts
a model during package build/install. Package tests use deterministic local
fixtures only. Live browser behavior and model accuracy/availability remain
separate acceptance checks.

New source archives are immutable per Manifest and must contain the named
commit. Existing recipes and all earlier Manifest rows stay byte-identical;
public-source availability never justifies recutting an existing distfile.
See each package's `README.gentoo.md` for explicit opt-in usage.

## License-only Boot and LLM source revisions

`sys-boot/qinda-boot-1.0.0-r1` pins licensed source
`f778750ea9e9622b76b2abd84f0710486757997f`, whose only changes from accepted
`a49f02407d1170c574921fe6bd2c8f9455faff4f` are LICENSE and the README scope
notice. Original code is GPL-3+, while the reused Reclaimed wallpaper and
generated artwork/font assets retain their existing terms. The complete
package therefore uses `GPL-3+ all-rights-reserved` and keeps fetch, mirror and
binary-distribution restrictions. README and LICENSE ship with the package.
Boot files, configuration, ESP deployment behavior and hardware state are
unchanged by this source/license revision.

`sci-ml/qinda-llm-server-1.0.0-r2` pins licensed source
`91a294cd967f0331bbef13f95b74920a27cd2d7e`, likewise changing only LICENSE and
README from accepted r1 source `977f93f57fa6d2fc15fba9707dedecc012065cf2`.
It uses GPL-3+ for its own service/configuration code and preserves the existing
runtime dependencies, model configuration, secret-generation and startup
policy. The existing `sci-misc/llama-cpp[vulkan]` provider comes from `::guru`,
which external users must configure alongside this overlay; it is outside the
`gentoo`-only masters used by standalone metadata scans. External llama.cpp and
model weights keep their own licenses. The
source archive contains no model weights or runtime binary. It is a reproducible,
fetch-restricted `git archive | gzip -n` snapshot from the accepted source hub;
later GitHub publication must not replace its bytes or remove its restriction.

These are new immutable recipe/source revisions; the older git-r3 recipes,
source commits, dependency policy and delivery entries remain intact. Source
archive verification and inert package-image staging do not authorize boot
activation, model downloads/builds/tests, service operations or host merges.
Those live/installed qualifications remain separately controlled.
