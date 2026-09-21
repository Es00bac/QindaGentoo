# Portage configuration shared by both hosts

These are the `/etc/portage` fragments both qinda and qinda-top need in order
to build the same software. They live here so the two machines cannot drift
apart silently, and so a rebuilt host is one copy away from correct.

| File here | Install as |
| --- | --- |
| `package.use--80-gaming` | `/etc/portage/package.use/80-gaming` |
| `package.accept_keywords--80-gaming` | `/etc/portage/package.accept_keywords/80-gaming` |

## The gaming fragment, and why it is shaped this way

`ACCEPT_LICENSE="*"` is set in each host's own `make.conf` at the operator's
instruction — every license is accepted.

`abi_x86_32` is enabled globally in `make.conf`, because the Steam client and
its runtime are 32-bit. **Wine is the exception**: `wine-proton`'s `wow64`
mode runs 32-bit Windows programs on a pure 64-bit Wine and needs no 32-bit
host libraries, and its own `REQUIRED_USE` forbids combining the two
(`wow64? ( !abi_x86_32 )`). So the fragment turns `abi_x86_32` **off** for
wine and leaves `wow64` on. Enabling it there instead would force a large,
pointless 32-bit rebuild and still not give a working Wine.

## Not installable from the main tree

- `games-util/steam-launcher` and `games-util/mangohud` are not in the Gentoo
  repository; they come from the steam overlay, which is not enabled here yet.
- `games-util/lutris` requires a `python_single_target` of 3.12 or 3.13 and
  both hosts are on 3.14, so it cannot build. This is not a problem worth
  solving: the operator asked for a native QindaQt launcher instead of Lutris.
