# Native session-agent selection

The original6.27.0 recipe is copied from qinda's installed VDB. Only the policykit-gated KDE session-agent PDEPEND is omitted. +policykit, PolkitQt6-1 backend discovery, every build/runtime dependency, source archive and configure/test choices are retained. The native QindaQt session owns the standard Polkit agent registration; this profile must qualify that registration before retiring the old agent. This does not bypass Polkit authorization, change PAM or manufacture an agent fallback. Independent stock sessions may continue installing their own agent. The original archive is fetched unchanged from KDE; its newly measured Manifest is not presented as a preserved old Gentoo checksum.

Original recipe/patch and revised recipe SHA256:

- kde-frameworks/kauth/kauth-6.27.0-r1.ebuild: original 4569989eeb91e209c50f38330388c3497ca29d97d25a354e9bc827a93ea92ed9; candidate c96f9ebc6c36a08625769a3fd4838758caa9786f44081c657051943ed672d3a8

Unmodified source: https://download.kde.org/stable/frameworks/6.27/kauth-6.27.0.tar.xz

- Bytes: 2273648
- SHA256: 741934765f0c9f1c535598203fbad3f1b97231cc683a218a7f39fab948c13eab
- Existing Gentoo DIST row matched: False

Original copyright and licenses remain in recipe/source/patches. Exact installed-version adaptation only; later upstream versions must be reviewed separately. No global Plasma mask, install, world mutation, service restart or app removal.

Original Gentoo maintainer/upstream metadata.xml copied unchanged, SHA256: 77ee1ab93ae0abe8515be0b1f533f7dc8f64bc5ecb708f2476a7361a9f55998a.
