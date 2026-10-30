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
rebuilds. Build and installation results are recorded after completion.
