# Mandatory-signed target-local old-five rollback PASS

- Timestamp: 2026-10-03T03:08:11.440770+00:00
- Exact overlay base: `2cf07fdb2b44dfd2188528492018d689e7b9de3e`
- Outcome: both ordinary binary-only rollback graphs select exactly five reinstalls/five binaries, zero extra packages/zero KiB. No merge, unmerge, provider/PAM/session operation, source build or global configuration change.
- Existing configured signer/trust policy retained; normal quickpkg appended binpkg-signing, one compressor thread per invocation. Original unsigned laptop snapshots and original signed r2/r3 images remain unchanged.

## qinda

- Resolver exit: 0; elapsed 2.450112s; five reinstalls/five binaries/0 KiB.
- World/world_sets unchanged: True; installed kde-plasma CPVs unchanged: True, count 28 (includes retained kwayland/layer-shell-qt).
- Target-local PKGDIR: `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs`.
- All six artifacts below passed full GPkg signature/payload verification and exact installed USE/IUSE/RDEPEND/DEPEND/PDEPEND/BDEPEND/SLOT/CHOST comparison. The sixth, GNOME48-r1, is the separately available legacy-provider snapshot, outside the five-target plan.

| CPV | Artifact path | Bytes | SHA256 |
| --- | --- | ---: | --- |
| gui-wm/qindaqt-desktop-0.1.0_pre20260927-r7 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/gui-wm/qindaqt-desktop/qindaqt-desktop-0.1.0_pre20260927-r7-1.gpkg.tar` | 41656320 | `fb371bce659c4ec02287319a8572fef4413e0c5a403c15b6fc37032bdfd6172f` |
| app-misc/claude-desktop-bin-1.49585.0 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/app-misc/claude-desktop-bin/claude-desktop-bin-1.49585.0-1.gpkg.tar` | 218685440 | `7cd182d51c0e0820c82b2145f02bbb5ec3f1cb00ea783a0246a32243835a3ce4` |
| app-crypt/pinentry-1.3.2-r1 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/app-crypt/pinentry/pinentry-1.3.2-r1-4.gpkg.tar` | 215040 | `ddb4504c74a16622b3dab55ea20f5e571978770a4c9d47debd9f304bcdcb93ce` |
| virtual/secret-service-0-r1 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/virtual/secret-service/secret-service-0-r1-1.gpkg.tar` | 20480 | `09caca7a924442281a8386c2ea84bfbec06a49a62c935e268005f74b3a2fafe2` |
| x11-misc/sddm-0.21.0_p20250502-r1 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/x11-misc/sddm/sddm-0.21.0_p20250502-r1-8.gpkg.tar` | 3829760 | `1d1beffce91ffbb0e7eb6b303aa101c243f5ec1142dfe5ad516ffe414de0f827` |
| gnome-base/gnome-keyring-48.0-r1 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/gnome-base/gnome-keyring/gnome-keyring-48.0-r1-6.gpkg.tar` | 1013760 | `5cd329ea2f38db70a4c35c40cf350fdcc7fbe2a7e844bd44eaf32f5c93bb2e5e` |

Exact read-only resolver argv (mandatory-signature process feature appended to existing features):

```sh
task_features="$(portageq envvar FEATURES) binpkg-request-signature"
sudo -n nice -n19 ionice -c3 env FEATURES="$task_features" PKGDIR=/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs emerge --pretend --selective=n --verbose --ignore-default-opts --usepkgonly --getbinpkg=n --binpkg-respect-use=y --oneshot --newuse --with-bdeps=n --dynamic-deps=n --autounmask=n --autounmask-write=n --backtrack=0 --ask=n =gui-wm/qindaqt-desktop-0.1.0_pre20260927-r7 =app-misc/claude-desktop-bin-1.49585.0 =app-crypt/pinentry-1.3.2-r1 =virtual/secret-service-0-r1 =x11-misc/sddm-0.21.0_p20250502-r1
```

Executable five-package restoration uses precisely that argv with only `--pretend` removed. Manager owns execution and existing provider/PAM/alias ordering; no restoration ran.

## laptop

- Resolver exit: 0; elapsed 1.639161s; five reinstalls/five binaries/0 KiB.
- World/world_sets unchanged: True; installed kde-plasma CPVs unchanged: True, count 28 (includes retained kwayland/layer-shell-qt).
- Target-local PKGDIR: `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs`.
- All six artifacts below passed full GPkg signature/payload verification and exact installed USE/IUSE/RDEPEND/DEPEND/PDEPEND/BDEPEND/SLOT/CHOST comparison. The sixth, GNOME48-r1, is the separately available legacy-provider snapshot, outside the five-target plan.

| CPV | Artifact path | Bytes | SHA256 |
| --- | --- | ---: | --- |
| gui-wm/qindaqt-desktop-0.1.0_pre20260928-r3 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/gui-wm/qindaqt-desktop/qindaqt-desktop-0.1.0_pre20260928-r3-1.gpkg.tar` | 53094400 | `9d10da700d3339a4935321282480b6c8b122ade559053652ae69486bc2e68972` |
| app-misc/claude-desktop-bin-1.49585.0 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/app-misc/claude-desktop-bin/claude-desktop-bin-1.49585.0-1.gpkg.tar` | 218685440 | `7cd182d51c0e0820c82b2145f02bbb5ec3f1cb00ea783a0246a32243835a3ce4` |
| app-crypt/pinentry-1.3.3 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/app-crypt/pinentry/pinentry-1.3.3-2.gpkg.tar` | 225280 | `13378dc15aa15a1a598b4d6bb82bcf74dafab6983f19983e997c1f53f0afe4d8` |
| virtual/secret-service-0-r1 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/virtual/secret-service/secret-service-0-r1-1.gpkg.tar` | 20480 | `9fcac63c837015cf38fc08b2977dcb652bafb2616064505010ecfc035c4b45e7` |
| x11-misc/sddm-0.21.0_p20250502-r1 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/x11-misc/sddm/sddm-0.21.0_p20250502-r1-8.gpkg.tar` | 3829760 | `d9e5ea7789fb0b24939c4121c0b81b52248e89a899e7c943255290cc805a624b` |
| gnome-base/gnome-keyring-48.0-r1 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/gnome-base/gnome-keyring/gnome-keyring-48.0-r1-6.gpkg.tar` | 1013760 | `456430a4c7d1195bec529427204be9368ab7d6995f94276ed16cf008224eb096` |

Exact read-only resolver argv (mandatory-signature process feature appended to existing features):

```sh
task_features="$(portageq envvar FEATURES) binpkg-request-signature"
sudo -n nice -n19 ionice -c3 env FEATURES="$task_features" PKGDIR=/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs emerge --pretend --selective=n --verbose --ignore-default-opts --usepkgonly --getbinpkg=n --binpkg-respect-use=y --oneshot --newuse --with-bdeps=n --dynamic-deps=n --autounmask=n --autounmask-write=n --backtrack=0 --ask=n =gui-wm/qindaqt-desktop-0.1.0_pre20260928-r3 =app-misc/claude-desktop-bin-1.49585.0 =app-crypt/pinentry-1.3.3 =virtual/secret-service-0-r1 =x11-misc/sddm-0.21.0_p20250502-r1
```

Executable five-package restoration uses precisely that argv with only `--pretend` removed. Manager owns execution and existing provider/PAM/alias ordering; no restoration ran.

## Evidence and bounded conditions

- Laptop normal signed quickpkg recaptured GNOME48-r1, old Desktop, old SDDM and tiny old Pinentry/virtual: exit0/3.172632s. Qinda retained signed Desktop/GNOME/SDDM snapshots and recaptured only old Pinentry/virtual: exit0/0.910837s. Existing signed old Claude reused after exact installed metadata/signature verification; registered copies through standard binarytree.inject, no signature-policy override.
- The initial laptop `--newuse` plan selected zero packages because all old targets remain installed. That receipt is preserved; installed Portage create_depgraph_params supports `--selective=n` to remove implicit selective behavior. The final plans above genuinely select all five binaries, without --nodeps, --emptytree, USE bypass or private host/profile overrides.
- Laptop evidence: `/home/cabewse/.cache/pf-desktop-rollback-20261003/{quickpkg-command.json,quickpkg-status.json,quickpkg.log,verified-artifacts.json,old-five-command.json,old-five-status.json,old-five.log}`. Qinda equivalent receipts: `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-qualification-20261003/`.
- Snapshot captures preserve original legacy data. Standard --include-unmodified-config=y excludes locally modified `/etc/sddm.conf.d/01gentoo.conf`; manager must retain its existing separate config/PAM rollback backups. No credential content was read or recorded.
- Graph acceptance applies to the actual current installed dependency set. Keep retired dependencies installed through the manager's fresh native-session acceptance/rollback window; this receipt does not qualify a rollback after their removal. Legacy GNOME alias restoration must follow replacement of the native Desktop owning those aliases, according to accepted cutover ordering; no force-overwrite permitted.
- Requested next action: manager may proceed with already-authorized cutover/import gates using this signed rollback prerequisite. Worker releases all resources and waits for next bounded assignment.
