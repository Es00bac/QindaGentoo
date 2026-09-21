# QindaGentoo — the Sloom Studio / QindaQt Portage overlay

Repository name: `qindaqt`. One overlay for everything developed here:

| Package | Source project |
| --- | --- |
| `gui-wm/qindaqt-desktop` | `container-wm` |
| `gui-apps/qindaqt-apps`, `gui-apps/qindaqt-system-monitor` | `container-wm` |
| `gui-apps/qindaoffice` | `QindaOffice` |
| `gui-apps/qqterm` | `QindaQt_Apps` |
| `www-client/qindafox-bin` | `QindaQt_Apps/QindaFox` |
| `gui-wm/qindastudio` | `QindaStudio` |
| `app-misc/venusprolinux` | `QindaVenusPro` (Venus Pro mouse utility with the QindaTK interface) |
| `kde-plasma/sloom-globalmenu`, `kde-plasma/sloom-panelmenu`, `media-gfx/sloom-studio-bin` | `sloom-studio-gpl` |
| `kde-plasma/kwin`, `kde-plasma/plasma-activities` | pinned 6.6.x copies the desktop's KWin plugin ABI needs |

### Third-party packages

`net-wireless/*` is the SDRangel software-defined-radio stack: `sdrangel` itself
plus the twelve upstream libraries it needs that Gentoo does not package
(`aptdec`, `cm256cc`, `cspice`, `dab-cmdline`, `dsdcc`, `ggmorse`, `inmarsatc`,
`libsigmf`, `mbelib`, `serialdv`, `sgp4`). These are not developed here; they
live in this overlay because it is the version-controlled one, so the patches
carried against them are tracked and reach both machines. `licenses/CSPICE` is
the NASA/Caltech licence `net-wireless/cspice` refers to.

`profiles/qindaqt/systemd` is the desktop profile: parent
`default/linux/amd64/23.0/desktop/plasma/systemd` plus the QindaQt package set,
USE defaults, keywords and licenses. Select it with
`eselect profile set qindaqt:qindaqt/systemd`.

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
host's configured compiler flags and `MAKEOPTS`. Already installed versions are
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
