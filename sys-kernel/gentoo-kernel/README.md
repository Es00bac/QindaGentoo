# Linux 7.3.1 for qinda-top

This recipe supplies kernel.org's stable Linux 7.3.1 through Portage while
Gentoo's 2026-10-30 repository still stops at 7.2.13. It is based on
`gentoo-kernel-7.2.13.ebuild`, with the upstream 7.3 base and complete 7.3.1
stable patch, Gentoo's 7.2.13 distribution patches, and its 7.2.10 Fedora
configuration. Kconfig updates the configuration for 7.3. Only amd64 is
keyworded. This is an optional kernel, not a desktop profile dependency.

The existing `kernel-build` and `kernel-install` eclasses retain distribution
kernel integration, initramfs generation, external-module headers, and boot
loader hooks. Existing kernel command lines and module settings remain host
configuration. On qinda-top these include `i8042.reset=1` and the RTL8852BE
ASPM/power-saving workarounds. The current kernel stays installed as a boot
fallback.

## CVE-2026-98432

The Linux kernel security team's [CVE record](https://git.kernel.org/pub/scm/linux/security/vulns.git/plain/cve/published/2026/CVE-2026-98432.mbox)
identifies upstream commit `e3f33b0a1d89d738e2b913dab519226eaf76e15b` as
the fix, first included in 7.3. Both `inet_sock_destruct()` in
`net/ipv4/af_inet.c` and `tcp_v4_reqsk_destructor()` in
`net/ipv4/tcp_ipv4.c` must free the options with `kfree_rcu()`. This is
already part of 7.3.1; no additional security patch is necessary. The old
6.18.48 fallback predates the fix (the 6.18 branch was fixed in 6.18.56).
Installing a new kernel does not patch the running kernel: rebooting into
the new version is required.

## Verification

The source and stable update are pinned by the Manifest. `USE=verify-sig`
also verifies kernel.org's signed checksums with the Portage-managed kernel
signing keys. `USE=test` with `FEATURES=test` runs Gentoo's QEMU boot test
before installation. The laptop's external v4l2loopback module must be
rebuilt against the new headers; `USE=dist-kernel` enables future automatic
rebuilds.

## qinda-top installation, 2026-10-30

The full Portage build and its QEMU boot test passed. All nine Gentoo patches
applied without modification. Installed packages are `gentoo-kernel-7.3.1`,
`virtual/dist-kernel-7.3.1`, `linux-firmware-20261019`, and
`v4l2loopback-0.15.4`. The kernel release is `7.3.1-gentoo-dist`.

Final verification checked the following:

- The EFI boot image matches the installed kernel image byte for byte.
- The Qinda menu and systemd-boot select 7.3.1 and retain the 6.18.48 entry.
- Twelve required modules have the new kernel's version magic, and the
  attached PCI/USB devices retain module coverage across 23 device entries.
- The existing RTL8852BE configuration is present in the new initramfs.
- Both CVE-2026-98432 fix sites are present. The stable update and all nine
  Gentoo patches leave those two files unchanged from the signed 7.3 base.

The installed image's SHA-256 is
`8beb3c595e7232c675cdc438026e8c8e2729733bc1e38a9d73a578ae16e8e7d3`.
The full receipts are in
`~/.local/state/kernel-upgrade-20261030/verification.json` on qinda-top,
with a copy under `~/.local/state/qinda-top-kernel-upgrade-20261030/` on qinda.
The original boot files are backed up on qinda-top at
`/var/lib/kernel-upgrade/20261030-7.3.1/boot-before.tar`.

The full debug build exceeded the initial 29 GiB of space available to
unprivileged processes. Its follow-up virtual package hit ENOSPC after the
kernel had installed. The completed build tree was cleaned and the remaining
packages installed successfully; approximately 27 GiB was free afterward.
Archive source evidence before installation: the eclass removes source files
that are not needed by the installed external-module build support.

`/usr/src/linux` now selects the new source-built kernel. The world atom is
the unpinned `sys-kernel/gentoo-kernel`, with package-scoped `~amd64` acceptance
for it and `virtual/dist-kernel`, so normal Portage updates can follow newer
upstream stable releases. Kernel source signature verification and automatic
external-module rebuilds are enabled.

`pkgcheck` completed with advisory notes for the single-provider virtual and
newer Python compatibility in the inherited eclass. This host uses Python
3.14. Native boot adoption remains pending: the running kernel at handoff is
6.18.48, and the security fix takes effect after rebooting into 7.3.1.
