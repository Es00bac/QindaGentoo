# Native SDDM optional keyring hooks

Exact base128064c, isolated `.cache/pf-native-sddm-pam-20261002`, branch
`worker/pf-native-sddm-pam-20261002`. Root owns only `x11-misc/sddm` and
this reply. Power owns shared native-profile USE; no collision.

Adapt installed source0.21.0_p20250502-r1 into-r2 with default-off qindaqt USE,
systemd requirement and native Desktop-r2 runtime module provider. Native
preparation replaces only optional keyring callbacks in normal/autologin PAM;
stock defaults, all auth/account/session-critical blocks and greeter remain
unchanged. Ten actual original-PAM-archive preparation checks PASS0/0.029s,
original archive SIZE+BLAKE2B+SHA512 PASS; Bash syntaxPASS0. No real PAM/session,
service restart, binary installation or user credential operation.

Request different-worker exact source/metadata/preparation review before
integration/build. Pending native profile flag, signed Portage build/image
verification, config-protected live install and new-login runtime gate.
