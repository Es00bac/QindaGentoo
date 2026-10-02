# Optional Plasma applet with applications retained

The exact Gentoo26.04.3-r3 recipe becomes-r4. Three existing Gentoo patches are copied byte-exact. A default-on plasmoid USE preserves independent stock desktop behavior. With -plasmoid, only the libplasma runtime atom and the package-only root add_subdirectory(plasmoid) are omitted using the existing Gentoo cmake helper. Upstream plasmoid/CMakeLists merely installs the Plasma package; daemon, application, indicator, SMS application, CLI, plugins, DBus/model/core and integration targets stay. No production source is rewritten and the existing X11 handling/patches are unchanged. Archive DIST hashes exactly match the original Gentoo Manifest. Native-profile -plasmoid does not imply binary/runtime qualification; compile and genuine app/daemon smoke remain required.

Original recipe/patch and revised recipe SHA256:

- kde-misc/kdeconnect/kdeconnect-26.04.3-r4.ebuild: original defd9fef4d2dff702bc82dbc4555ff6db79a1773d081946d82be578c95225606; candidate 9dec9446f3fede26505b2d77ac05a31d75836ff13737a80dcb53322d991c1ea9
- kde-misc/kdeconnect/files/kdeconnect-26.04.3-openssl4.patch: original a340ba21b7021c3a642869bc90cd56b8a78664f14f514a4e1e3fd54315ba6923; candidate a340ba21b7021c3a642869bc90cd56b8a78664f14f514a4e1e3fd54315ba6923
- kde-misc/kdeconnect/files/kdeconnect-26.04.3-solid-6.26-freeze.patch: original 208c642da2585aafef0a7b2727b84f1d687eb49c08eb837569c16d000b516cd7; candidate 208c642da2585aafef0a7b2727b84f1d687eb49c08eb837569c16d000b516cd7
- kde-misc/kdeconnect/files/kdeconnect-26.04.3-with_x11.patch: original 63485bc2ad8840513cef2fa4cbc781c4da28ef0b78ca920c922b5ffd16c22405; candidate 63485bc2ad8840513cef2fa4cbc781c4da28ef0b78ca920c922b5ffd16c22405

Unmodified source: https://download.kde.org/stable/release-service/26.04.3/src/kdeconnect-kde-26.04.3.tar.xz

- Bytes: 691476
- SHA256: 505b58b52630a662a8f6a2c50c58eda1de66779762c31d5ea5247b48bba52561
- Existing Gentoo DIST row matched: True

Original copyright and licenses remain in recipe/source/patches. Exact installed-version adaptation only; later upstream versions must be reviewed separately. No global Plasma mask, install, world mutation, service restart or app removal.

The original Gentoo metadata.xml credits/upstream descriptors are retained, with only the new local plasmoid USE description added. Original metadata SHA256: 9bd51fa96234944f234a7247420373111f7e4375833a22879683e178bb9e30f5.
