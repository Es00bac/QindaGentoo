# Remove an unused Plasma runtime atom

The exact Gentoo1.12.1 recipe is retained except its unconditional libplasma runtime atom. All modules, dependencies and build/test choices remain. Inspection of exact official/tagged1.12.1 CMake/QML/C++ sources finds no Plasma library link/find or QML import. Token hits describe desktop fallback, sample/about text and a sound-theme name. There is no optional Plasma component to omit. In particular the upstream treeview falls back to org.kde.desktop/Fallback; app defaults explicitly initialize colours when not using Plasma's QPlatformTheme. Archive DIST hashes exactly match the original Gentoo Manifest. Metadata proof is not QML runtime proof; actual ordinary addon instantiation against the installed native theme remains a required smoke gate.

Original recipe/patch and revised recipe SHA256:

- dev-libs/kirigami-addons/kirigami-addons-1.12.1-r1.ebuild: original d7d6c889d7a23285c5be8724acf4e2fc352b3b40bcee2d01437e5a78c3f3db31; candidate b255d435dfa870d85dd36150d427dcb98390d327a879feee334ae75d1a715c1b

Unmodified source: https://download.kde.org/stable/kirigami-addons/kirigami-addons-1.12.1.tar.xz

- Bytes: 2815592
- SHA256: c543a493ce5875f405fb1c9ff6d531060ed082cc6d710e56d46ac42d164207bb
- Existing Gentoo DIST row matched: True

Original copyright and licenses remain in recipe/source/patches. Exact installed-version adaptation only; later upstream versions must be reviewed separately. No global Plasma mask, install, world mutation, service restart or app removal.

Original Gentoo maintainer/upstream metadata.xml copied unchanged, SHA256: 0e3474b5e35be6e9756b6a1aaed32d0531c0990e2f9c0df961d849fa790a2561.
