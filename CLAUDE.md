# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Gentoo Portage overlay (repo name `qindaqt`, `masters = gentoo`, thin Manifests) for
everything Sloom Studio / QindaQt develops in-house: the QindaQt Wayland desktop and its
apps, QindaOffice, QindaStudio, QindaFox, and the Sloom Studio Plasma bits. There is no
application code here, only ebuilds, a profile, and two shell tools. The one exception to
"in-house" is `net-wireless/*`, the third-party SDRangel stack: it is kept here rather
than in a local overlay so the patches it carries are version-controlled and reach both
machines. Ebuilds are edited
either directly here or in each source project's `packaging/gentoo/` (QindaStudio uses
`packaging/portage/`) and then copied in. The README's table maps packages to source
projects; those projects are expected as sibling checkouts of this directory.

## Commands

```sh
# Pull every sibling project's packaging/ tree into this overlay and regenerate
# Manifests (uses pkgdev if installed, else `ebuild ... manifest` per ebuild).
tools/sync-from-projects

# Regenerate one package's Manifest after editing or adding an ebuild
ebuild gui-wm/qindaqt-desktop/qindaqt-desktop-<ver>.ebuild manifest

# Build/install a package from this overlay (the overlay is mounted as ::qindaqt)
sudo emerge -av gui-wm/qindaqt-desktop::qindaqt

# List every installed package that comes from this overlay
portageq match / '*/*::qindaqt'

# Install the committed exact delivery on the laptop over SSH
# (LAPTOP env var overrides the host name, default qinda-top)
tools/push-to-laptop

# Synchronize a clean checkout's current branch through qinda; divergence stops.
tools/qinda-sync code .

# Install metadata/qinda-delivery locally; fetch missing archives/shared Git sources.
tools/qinda-sync

# Publish an archive after committing its matching Manifest to the hub.
tools/qinda-sync publish /path/to/package.tar.gz

# Select the desktop profile on a machine
eselect profile set qindaqt:qindaqt/systemd
```

There is no test suite or linter configured. Manifests are the correctness check: a
version bump is not done until the Manifest line for the new distfile exists.

## Architecture and conventions

**Two machines, one git repo.** The overlay is developed on the desktop and consumed by
the laptop; both point their `qindaqt` repo at this git repository with `sync-type = git`,
and the laptop pulls binary packages from the desktop's binhost (port 8090).
`qinda-sync` works on either machine; qinda's bare Git repositories and existing
binhost are the shared source. `push-to-laptop` invokes that command remotely.
The exact approved delivery lives in `metadata/qinda-delivery`. The helper never
auto-commits, force-pushes, overwrites differing recipes, updates `@world`, or
restarts the desktop. Publish commits and verified archives explicitly; invoke
the package command when the receiving machine is ready. See README for usage.

**Distfile conventions.** Every first-party source repository is now published under
github.com/Es00bac (2026-09-18), but the ebuilds still pin an exact reviewed commit and
still cut their own archive: the checkpoints they pin are not GitHub releases, and
`RESTRICT="fetch"` stays until a revision has actually been built from the GitHub archive
URL and its Manifest verified on both machines. Each ebuild gets its archive one of three
ways; match the existing shape when bumping:

- `gui-wm/qindaqt-desktop`, `gui-apps/qindaqt-apps`, `gui-apps/qindaqt-system-monitor`:
  `QINDAQT_COMMIT` pinned, `SRC_URI` points at a GitHub archive URL, but the desktop
  package carries `RESTRICT="fetch"` and the operator cuts the tarball with `git archive`
  (prefix `QindaQt-<commit>/`) into DISTDIR. `pkg_nofetch` prints the recipe.
- `gui-apps/qindaoffice`: `SRC_URI="${PF}.tar.xz"` with `RESTRICT="fetch"`; the archive is
  produced by QindaOffice's own `tools/make-dist.sh <PVR> <DISTDIR>`, which vendors the
  QXlsx submodule so the build works under `network-sandbox`.
- `gui-apps/qqterm` still uses `git-r3` against a `file://` path that exists only on the
  desktop; the in-ebuild note says to move it to a tarball once the repo is hosted.

Archives for snapshots are named after `${PF}` (revision included), not `${P}`. A re-cut on
the same day is a new revision with different bytes, and a `${P}` name would give two
different tarballs the same Manifest line, silently building the stale one. The archive
must also be reproducible across machines or the laptop rejects it as a Manifest mismatch.

**Version scheme.** Snapshots are `0.1.0_preYYYYMMDD` (desktop) or `0.1.0_pYYYYMMDD`
(office) with `-rN` for re-cuts of the same day. Old ebuilds and their Manifest lines are
kept, not deleted, when a new one is added. Commit messages follow
`<package>: revision <ver>, <one-line reason>` (or `snapshot`, `checkpoint`), with a body
explaining which upstream commit is pinned and why.

**Ownership of shared QindaQt libraries.** `gui-wm/qindaqt-desktop` installs the whole
QindaQt tree, including the global-menu and settings-client static archives and headers
that `qqterm`, `qindaoffice`, `qindastudio` and `qindaqt-system-monitor` link against via
`find_library`. Those packages therefore `RDEPEND` on a minimum `qindaqt-desktop` and must
not install a second copy of the runtime; the desktop blocks the old `gui-apps/qindaqt-apps`
package for the same reason. Component packages built from the QindaQt monorepo configure
the whole tree with the shell/KWin plugin switched off, then `cmake_build` only their
targets and `cmake --install --component` only their component.

**Exact compositor ABI.** The native cutover uses co-installable
`gui-wm/qindaqt-kwin-6.6.6_p1-r3`, whose source serial1 exports exact6.6.6.1
CMake packages. The desktop matches that fork with a subslot dependency.
Earlier released desktop recipes retain their original stock KWin6.6.6 and
Plasma requirements; those old recipes and archive records stay immutable.
The legacy KWin/plasma-activities copies and Sloom ABI packages remain for
those independent older installations, not as native cutover dependencies.

**Profile.** `profiles/qindaqt/systemd` inherits
`gentoo:default/linux/amd64/23.0/desktop/systemd` and adds the `@profile` package
set (`packages`), USE defaults (`make.defaults`, `package.use`), and `~amd64` keywords for
every overlay package (`package.accept_keywords`). Adding a package to the overlay usually
means adding it to both `packages` and `package.accept_keywords`. `profiles/categories` is
regenerated by `sync-from-projects` from the category directories present.

**Binary packages.** `www-client/qindafox-bin` and `media-gfx/sloom-studio-bin` are
prebuilt (`QA_PREBUILT`, `RESTRICT="strip"`); QindaFox's tarball comes from its project's
`tools/package-gentoo-bin`, Sloom Studio's from GitHub releases.

## Native desktop cutover candidate

New desktop pre20261002-r1 and fork6.6.6_p1-r3 preserve all released recipes and
old distfile records. Exact manager source freeze candidates are desktop
cae9114ae1e64cd375b6cb79fb206cae8e9c7f1e and fork
55d1f2738723316fae4686468757aef66ce7590b. Private qinda archives and actual new
Manifest rows await independent recipe review and native/runtime qualification.
Do not publish or run qinda-sync installation from this candidate.
Fork serial1 remains the
exact6.6.6.1 plugin ABI; r3 names a distinct `${PF}` archive. Native shortcuts,
lock and Schedule1 nightlight replace the retired Plasma runtime providers.
The desktop enables the integrated `QINDAQT_NATIVE_POWER_EXCLUSIVE` option
and its reviewed startup-failure repair. Source routing separates 13 ordinary
portal interfaces from 5 protected sharing/input interfaces; all 18 rows select
native owners under defaultnone, pending coherent runtime qualification.
The ordinary desktop/systemd profile stops selecting replaced Plasma
services/applets. This does not unmerge independently installed packages or
change world. Reuse tools/check-plasma-dependencies for actual solver-picked
runtime closure of both exact candidate roots on both hosts. Register the
worktree/profile through isolated process settings only and preserve logs.
No installation or final release claim before reviewed source pins, archives,
Manifest entries and manager runtime gates. See README's prepared cutover.

**Gabbee native checkpoint (2026-10-02).** The new p20261002 recipe pins
integrated0a232449 and the prepared desktop requires that floor. Copying the
old recipe preserves Python/Whisper/IBus behavior and generic stock source;
only the pin and qindaqt-mode obsolete KDE portal drop-in installation change.
No old recipe or Git source revision is rewritten. The accepted source fixes
watchdog portal/unit selection for physical native qindaqt-kwin and keeps
stock kwin_wayland compatibility; root independently reran40 focused fixtures.
Installed physical-session behavior remains a separate manager gate.
Signed build-only Portage output does not merge/restart a host or update world.

Final desktop revision 1 and fork revision 3 preserve all earlier recipes and
archive records. Historical fork revision 1 has a bare-modifier parser defect;
revision 2 lacks native repeat activation. Neither is final delivery. Revision 3
includes both reviewed fixes, retains exact6.6.6.1 ABI, and is undergoing the
authorized private signed build-only. The final desktop source includes the
accepted helper regression and release documentation. Exact two-host closure,
manager runtime acceptance and installs remain separate gates; no old source
archive is recut under its existing filename.
