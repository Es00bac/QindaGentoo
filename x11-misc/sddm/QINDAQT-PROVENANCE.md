# Native SDDM keyring integration

Adapted from Gentoo's `sddm-0.21.0_p20250502-r1` recipe, metadata,
Manifest and its four unmodified downstream patch/logrotate inputs. Original
Gentoo copyright and GPL-2 recipe notices are retained; upstream SDDM and
PAM archives retain their existing Manifest hashes and licenses.

Revision `-r2` adds default-off `qindaqt` USE, constrained to systemd. It
requires the native desktop package that supplies `pam_qindaqt_keyring.so`
and the trusted system-owned launcher/unit. With native USE only, preparation
replaces optional GNOME keyring callbacks and removes optional KWallet
callbacks from the normal and autologin PAM defaults. Authentication/account
policy, system-login ordering, greeter PAM, upstream code and stock-mode
behavior are unchanged. Autologin has no login password and keeps native
prompt fallback. No service restart, credential transfer or legacy import
is performed by this recipe. Portage owns/protects the resulting PAM config.

See container-wm ADR-0300 and `docs/wiki/architecture/keyring-pam.md` for the
trusted-token contract. Migration and new-login runtime acceptance are
separate from this configuration adaptation.
