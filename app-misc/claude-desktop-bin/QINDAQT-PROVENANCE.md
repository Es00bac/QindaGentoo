# Native providers for the unchanged Claude application

This revision derives from the installed 1.49585.0 recipe in sloom-private.
The vendor archive, unpack/prepare/install functions, launcher, Cowork behavior,
data locations, copyright and licenses remain unchanged. New `qindaqt` USE is
default OFF. Its native profile selection requires Desktop revision 2 for the
standard portal/Secret Service endpoints and the vendor-supported trash-cli.
Stock sessions retain the original portal, trash and keyring alternatives.

The preserved launcher supplies `--password-store=gnome-libsecret` only when the
caller supplied no password-store flag. This names Electron's generic libsecret
backend, not a direct GNOME daemon implementation. The unmodified Debian control
record depends on libsecret-1-0 and accepts trash-cli among its trash helpers.
The vendor binary contains `libsecret-1.so.0` and `trash-put` strings; those are
static supporting observations, not application runtime qualification. No user
credential or application-data access is needed to prepare this recipe.

Exact original recipe SHA256: 4dc5d6181331d3cb03118d4278800d7d5b6a0830fae1508805cc0e4dda1266f9.
Revised recipe SHA256: f6be2e2bd94885bf4ab055d140e750db04a52cc685ce92b056aa8f68e2df8bcd.
Preserved launcher SHA256: ece753e323e2b08f74ee381e684c77e392be16fee30a9d71e8c4d8a753af5f89 (also matches installed launcher).
Unchanged vendor archive `claude-desktop-bin-1.49585.0_amd64.deb`: 170566964 bytes,
SHA256 `e0b4ce6313943a69e9bd61749a293bfca241b4dfb37f88df6411b4b69ec67a40`.
Its BLAKE2B/SHA512 match the copied original Manifest DIST row.

Actual candidate Portage selection uses native Desktop and trash-cli; the
observed runtime graph selects no KDE portal/cli, GNOME keyring or KWallet PAM.
It contains an ordinary runtime provider cycle through the Secret Service
virtual and Desktop's transitive application dependencies, accepted by the
targeted Portage resolver. Resolver success must not be
reported as an acyclic graph or installed/runtime acceptance. Signed image,
Desktop provider registration, ownership/file-collision transition and physical
application smoke remain manager gates. No keyring migration, daemon stopping,
world edits or host installation occurs in source preparation.
