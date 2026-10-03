# Retired26 signed rollback completeness and restoration graphs PASS

- Timestamp: 2026-10-03T03:40:57.216117+00:00
- Exact overlay base: `647b871adba07e87933668d72e76493a8c90ed1e`.
- Verdict: target-local signed snapshots and complete normal binary-only restoration graph READY FOR MANAGER REVIEW on both hosts. No install/unmerge/provider/name/PAM/globalconfig or sourcebuild. Execution still follows alias/provider ordering below.
- Exactly26 retired kde-plasma CPVs per host; kwayland/layer-shell-qt retained and excluded from capture/removal scope. Six qinda/five laptop existing valid signed binaries reused byte-exact. Normal signed quickpkg captured only20/21 gaps, sequential hosts/T1/nice19/idleIO: qindaexit0/6.729514s, laptopexit0/7.477365s. Laptop lock rechecked absent immediately before capture. No binhost needed; all required exact versions obtained locally.
- Every26 artifact fully signature/payload verified and matches that host installed USE/IUSE/CHOST/SLOT/RDEPEND/PDEPEND/DEPEND/BDEPEND. Existing oldfive+GNOME full-signature-qualified bytes preserved/rechecked against prior SHA256; no recapture.

## qinda

- Target-local PKGDIR `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs`.
- Complete oldfive+GNOME+26 actual normal resolver: exit0/3.454402s;32packages/32binaries,5downgrades+1GNOMEnew+26reinstalls,0KiB, no extra/unpreserved dependency.
- World/world_sets and exactly26 installed retired CPVs unchanged.

| Exact CPV | Absolute signed artifact | Bytes | SHA256 | Reused |
| --- | --- | ---: | --- | --- |
| kde-plasma/aurorae-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/aurorae/aurorae-6.6.6-1.gpkg.tar` | 215040 | `d7e4ba0737eaea3e9857c82fe60836d70de9eb225d5b0fdf7977be225bf3933a` | False |
| kde-plasma/breeze-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/breeze/breeze-6.6.6-1.gpkg.tar` | 42680320 | `547d175e172df4cd86b015183adf17eb5b42f8e6a5d6a9bcad7290f2d4dac5a7` | False |
| kde-plasma/kactivitymanagerd-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/kactivitymanagerd/kactivitymanagerd-6.6.6-1.gpkg.tar` | 286720 | `dbcb5c43a31ce265498665328d039fb4f6ddd6aa65dc6acbf1ee832ed503a5ed` | False |
| kde-plasma/kde-cli-tools-common-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/kde-cli-tools-common/kde-cli-tools-common-6.6.6-1.gpkg.tar` | 491520 | `50a7993bbd4d53ae85995e1bfb1bbc02bd41a3b94518e690e93b04a8c0f2c09c` | True |
| kde-plasma/kdecoration-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/kdecoration/kdecoration-6.6.6-1.gpkg.tar` | 153600 | `2bdccd97674f205ae59a9f20a8629e877393c76d049e0bcec96e1c6b59bdba32` | False |
| kde-plasma/kdesu-gui-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/kdesu-gui/kdesu-gui-6.6.6-1.gpkg.tar` | 61440 | `d6fc5f2eec5f86195249348a4985c8a6e05be05cb887470786ea117fc6c17ac0` | False |
| kde-plasma/kglobalacceld-6.6.6-r1 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/kglobalacceld/kglobalacceld-6.6.6-r1-1.gpkg.tar` | 174080 | `128cc0793ca1c85ec91330613de8280d0e475ccea3a0e50d247bdb8fc277d382` | False |
| kde-plasma/knighttime-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/knighttime/knighttime-6.6.6-1.gpkg.tar` | 122880 | `a456c0be5e3e54f9263222643e67fec67db763d84e910d3098eeca6386c1d612` | False |
| kde-plasma/kpipewire-6.6.6.1 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/kpipewire/kpipewire-6.6.6.1-1.gpkg.tar` | 266240 | `91e4fee78915f7a260c573819c623b40c9d19b7bfb225f50aef28beda9180062` | False |
| kde-plasma/kscreenlocker-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/kscreenlocker/kscreenlocker-6.6.6-1.gpkg.tar` | 358400 | `f31881304b0d54d4688287485baa054750baee4806c2b7dd6777c720db3ac015` | False |
| kde-plasma/kwin-6.6.6-r1 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/kwin/kwin-6.6.6-r1-8.gpkg.tar` | 6912000 | `6188edc8b37014b8a85e7e99a04f2d69365e77dad435562ad7d10a62569d8a95` | True |
| kde-plasma/kwin-x11-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/kwin-x11/kwin-x11-6.6.6-1.gpkg.tar` | 6092800 | `7ee4aa8796ca7e72daba4ba8dbc16b0ddc9684366556724fc5f50579d5379189` | True |
| kde-plasma/libkscreen-6.6.6-r1 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/libkscreen/libkscreen-6.6.6-r1-1.gpkg.tar` | 460800 | `10b03274314979c4e52c98767699d626d7592895f43e84c9401b9a68da49090e` | False |
| kde-plasma/libksysguard-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/libksysguard/libksysguard-6.6.6-1.gpkg.tar` | 880640 | `aa84f4ca20444432fbab158366a5f426a661b809a32b6a756d74f3b7a32818e2` | False |
| kde-plasma/libplasma-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/libplasma/libplasma-6.6.6-1.gpkg.tar` | 2990080 | `74de4e0fb6ae47e824df4679ad3b9e4621ac66e7366014bef633643a45032ab7` | False |
| kde-plasma/milou-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/milou/milou-6.6.6-1.gpkg.tar` | 153600 | `9c16361ccdc99b4989e7f83dad856d3c6aa8b1591aedc50a150746671c1a8e78` | False |
| kde-plasma/plasma-activities-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/plasma-activities/plasma-activities-6.6.6-1.gpkg.tar` | 194560 | `b1c3d7d15fa2a81d9106f5697513112d651aa6eb0ad76438543db09ca5dcfa57` | False |
| kde-plasma/plasma-activities-stats-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/plasma-activities-stats/plasma-activities-stats-6.6.6-1.gpkg.tar` | 153600 | `539a574392b856e11d5b33f338de492c3799a59f8db40896c8d362db557f6aca` | False |
| kde-plasma/plasma-integration-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/plasma-integration/plasma-integration-6.6.6-1.gpkg.tar` | 235520 | `20db1268a699d1361fd66d142650f4ce91dc74486f2d516cc62be65038b9c42a` | False |
| kde-plasma/plasma-login-sessions-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/plasma-login-sessions/plasma-login-sessions-6.6.6-1.gpkg.tar` | 40960 | `f8306ae06c0e58f454855e6da85c508f8486147c5ce4b6a75d5410ace2927376` | False |
| kde-plasma/plasma-workspace-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/plasma-workspace/plasma-workspace-6.6.6-1.gpkg.tar` | 19548160 | `fd507dc48e897362fd6389f574938b1c2847d721d65f2b1e7e22ea24a431127e` | True |
| kde-plasma/polkit-kde-agent-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/polkit-kde-agent/polkit-kde-agent-6.6.6-1.gpkg.tar` | 122880 | `655566d4dfa3d7d1fbb40458830efd5d556c3c673dd8dfed3b97330791bb8e65` | False |
| kde-plasma/powerdevil-6.6.6-r1 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/powerdevil/powerdevil-6.6.6-r1-1.gpkg.tar` | 1044480 | `86a1d8d90782f5b944de2c43ab8fa5dd76a5c7bb78c7941e113b57412e57a209` | True |
| kde-plasma/qqc2-breeze-style-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/qqc2-breeze-style/qqc2-breeze-style-6.6.6-1.gpkg.tar` | 665600 | `e306a00efcd16354fc91049b0c00ace147c62381482b0ce4aae05479d0ba879c` | False |
| kde-plasma/spectacle-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/spectacle/spectacle-6.6.6-1.gpkg.tar` | 1085440 | `274352c25c7e7f4180b950fbb9b7a5cc54dab4a0d5347004735bd83a3092563f` | True |
| kde-plasma/xdg-desktop-portal-kde-6.6.6 | `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs/kde-plasma/xdg-desktop-portal-kde/xdg-desktop-portal-kde-6.6.6-1.gpkg.tar` | 870400 | `feb19c1ba118a8fca78e51367202db0c47a9bfc70906ce619cec68c711f8b646` | False |

Exact read-only resolver command:

```sh
task_features="$(portageq envvar FEATURES) binpkg-request-signature"
sudo -n nice -n19 ionice -c3 env FEATURES="$task_features" PKGDIR=/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs emerge --pretend --selective=n --verbose --ignore-default-opts --usepkgonly --getbinpkg=n --binpkg-respect-use=y --oneshot --newuse --with-bdeps=n --dynamic-deps=n --autounmask=n --autounmask-write=n --backtrack=0 --ask=n =gui-wm/qindaqt-desktop-0.1.0_pre20260927-r7 =app-misc/claude-desktop-bin-1.49585.0 =app-crypt/pinentry-1.3.2-r1 =virtual/secret-service-0-r1 =x11-misc/sddm-0.21.0_p20250502-r1 =gnome-base/gnome-keyring-48.0-r1 =kde-plasma/aurorae-6.6.6 =kde-plasma/breeze-6.6.6 =kde-plasma/kactivitymanagerd-6.6.6 =kde-plasma/kde-cli-tools-common-6.6.6 =kde-plasma/kdecoration-6.6.6 =kde-plasma/kdesu-gui-6.6.6 =kde-plasma/kglobalacceld-6.6.6-r1 =kde-plasma/knighttime-6.6.6 =kde-plasma/kpipewire-6.6.6.1 =kde-plasma/kscreenlocker-6.6.6 =kde-plasma/kwin-6.6.6-r1 =kde-plasma/kwin-x11-6.6.6 =kde-plasma/libkscreen-6.6.6-r1 =kde-plasma/libksysguard-6.6.6 =kde-plasma/libplasma-6.6.6 =kde-plasma/milou-6.6.6 =kde-plasma/plasma-activities-6.6.6 =kde-plasma/plasma-activities-stats-6.6.6 =kde-plasma/plasma-integration-6.6.6 =kde-plasma/plasma-login-sessions-6.6.6 =kde-plasma/plasma-workspace-6.6.6 =kde-plasma/polkit-kde-agent-6.6.6 =kde-plasma/powerdevil-6.6.6-r1 =kde-plasma/qqc2-breeze-style-6.6.6 =kde-plasma/spectacle-6.6.6 =kde-plasma/xdg-desktop-portal-kde-6.6.6
```

Exact ignored artifact/command/status/log receipt hashes:

| Receipt | SHA256 |
| --- | --- |
| retired-verified-artifacts.json | `e452f52c3a04a6bdf67dde00c623ffce738d198158de0fa1e30b2cbe997f8d10` |
| restoration-command.json | `1acd029a31119401771181f159b21a94b02f72c872e0bca58dfa4b9653f9ab94` |
| restoration-status.json | `e49aa34f25485f24e90358babb9b7e912a007b7212b0f5abdbe7c07208d58950` |
| restoration.log | `d0d60d5c1b0213ddea6283a2d6e6a34b17cf708da0b222f39d15ec2840772827` |

## laptop

- Target-local PKGDIR `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs`.
- Complete oldfive+GNOME+26 actual normal resolver: exit0/3.270704s;32packages/32binaries,5downgrades+1GNOMEnew+26reinstalls,0KiB, no extra/unpreserved dependency.
- World/world_sets and exactly26 installed retired CPVs unchanged.

| Exact CPV | Absolute signed artifact | Bytes | SHA256 | Reused |
| --- | --- | ---: | --- | --- |
| kde-plasma/aurorae-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/aurorae/aurorae-6.6.6-1.gpkg.tar` | 215040 | `84fd6d97c364d85153a47fbb1fc3a717b68de7cc15253a4842c783ede20bb9fb` | False |
| kde-plasma/breeze-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/breeze/breeze-6.6.6-1.gpkg.tar` | 42680320 | `b65859296d6de32a189d6ce53219ed62ac95cb40dd75270b28452c2137e09d60` | False |
| kde-plasma/kactivitymanagerd-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/kactivitymanagerd/kactivitymanagerd-6.6.6-1.gpkg.tar` | 286720 | `4776e689702847ace1bd73bd0b7655dabcf0d0b7591d3e6ae337ca2945c26052` | False |
| kde-plasma/kde-cli-tools-common-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/kde-cli-tools-common/kde-cli-tools-common-6.6.6-1.gpkg.tar` | 491520 | `50a7993bbd4d53ae85995e1bfb1bbc02bd41a3b94518e690e93b04a8c0f2c09c` | True |
| kde-plasma/kdecoration-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/kdecoration/kdecoration-6.6.6-1.gpkg.tar` | 153600 | `df93d6b3335d29c8862feee0ba3eaeac6d003a983a58748fdeadce9052241801` | False |
| kde-plasma/kdesu-gui-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/kdesu-gui/kdesu-gui-6.6.6-1.gpkg.tar` | 61440 | `57d119acb90299626d67b08e1f409eaded98629fda9cb5cf02d891c6d5d233ce` | False |
| kde-plasma/kglobalacceld-6.6.6-r1 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/kglobalacceld/kglobalacceld-6.6.6-r1-1.gpkg.tar` | 174080 | `7a5fa9f31d1cd484c0f1017a207a1e6b6ad6df754357c81958ab38bcd5de930c` | False |
| kde-plasma/knighttime-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/knighttime/knighttime-6.6.6-1.gpkg.tar` | 122880 | `d620f990cae9e3972701a1d5ad5165529918b73d6ec2d5605c6a1357a45465ef` | False |
| kde-plasma/kpipewire-6.6.6.1 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/kpipewire/kpipewire-6.6.6.1-1.gpkg.tar` | 266240 | `c0f6e41373a37a4532a3c04d99ceb76215cbe980d774f3da24fd57d24c020b22` | False |
| kde-plasma/kscreenlocker-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/kscreenlocker/kscreenlocker-6.6.6-1.gpkg.tar` | 358400 | `78b19fdad88bc8bdd5a18ce72195b2e3f77ec569d6b4224c4147d5bd38e555a6` | False |
| kde-plasma/kwin-6.6.6-r2 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/kwin/kwin-6.6.6-r2-1.gpkg.tar` | 6932480 | `371a95a4fc506d07cfe74a42162f62d3265b66f0be0c41f697af25f7a7921b9f` | False |
| kde-plasma/kwin-x11-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/kwin-x11/kwin-x11-6.6.6-1.gpkg.tar` | 6092800 | `7ee4aa8796ca7e72daba4ba8dbc16b0ddc9684366556724fc5f50579d5379189` | True |
| kde-plasma/libkscreen-6.6.6-r1 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/libkscreen/libkscreen-6.6.6-r1-1.gpkg.tar` | 460800 | `0820bdf9a8733ecd396d8f12927db2163cea69d823fdb8434f0e1bc6f034ed5d` | False |
| kde-plasma/libksysguard-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/libksysguard/libksysguard-6.6.6-1.gpkg.tar` | 880640 | `55fe0c35b7e30eafbfe03013fb8edf174637914da2f644b609f587a10e0a7bae` | False |
| kde-plasma/libplasma-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/libplasma/libplasma-6.6.6-1.gpkg.tar` | 2990080 | `7b3b72681bb6d17ae188c7ad38a5d4e49d343bc81c84d5bd38c4e9fd31e128cb` | False |
| kde-plasma/milou-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/milou/milou-6.6.6-1.gpkg.tar` | 153600 | `78217884af63b3ac9570cf27cec254fef0f7e6534db5bce7280f0d5672b6c5de` | False |
| kde-plasma/plasma-activities-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/plasma-activities/plasma-activities-6.6.6-1.gpkg.tar` | 194560 | `25bdc1f5ac7be3d4084c9225d8caf6cc1f81ff938f7e46b09af47e7b80c687f7` | False |
| kde-plasma/plasma-activities-stats-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/plasma-activities-stats/plasma-activities-stats-6.6.6-1.gpkg.tar` | 153600 | `512cc31983d70229ba70c6c6565702ad92e5e60c499733d008f4819aa0834073` | False |
| kde-plasma/plasma-integration-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/plasma-integration/plasma-integration-6.6.6-1.gpkg.tar` | 235520 | `31ff8e6521e481df78997a338048ae8b65c526e1298bc3b8c0e961db1ddc71b1` | False |
| kde-plasma/plasma-login-sessions-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/plasma-login-sessions/plasma-login-sessions-6.6.6-1.gpkg.tar` | 40960 | `96940385a3554154bc6b3d013ecf3f03bc7f2406349472b95c42513327c41358` | False |
| kde-plasma/plasma-workspace-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/plasma-workspace/plasma-workspace-6.6.6-1.gpkg.tar` | 19548160 | `fd507dc48e897362fd6389f574938b1c2847d721d65f2b1e7e22ea24a431127e` | True |
| kde-plasma/polkit-kde-agent-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/polkit-kde-agent/polkit-kde-agent-6.6.6-1.gpkg.tar` | 122880 | `5b5f64d4db8a1e95ec561aa6f2efb098e7151b89aa7e653a3344586f5fe8bf2c` | False |
| kde-plasma/powerdevil-6.6.6-r1 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/powerdevil/powerdevil-6.6.6-r1-1.gpkg.tar` | 1044480 | `86a1d8d90782f5b944de2c43ab8fa5dd76a5c7bb78c7941e113b57412e57a209` | True |
| kde-plasma/qqc2-breeze-style-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/qqc2-breeze-style/qqc2-breeze-style-6.6.6-1.gpkg.tar` | 665600 | `3da3fe11a92aa511ec8a4e131622ccba0bf780aa85edf586e109abc4e036e4c0` | False |
| kde-plasma/spectacle-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/spectacle/spectacle-6.6.6-1.gpkg.tar` | 1085440 | `274352c25c7e7f4180b950fbb9b7a5cc54dab4a0d5347004735bd83a3092563f` | True |
| kde-plasma/xdg-desktop-portal-kde-6.6.6 | `/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs/kde-plasma/xdg-desktop-portal-kde/xdg-desktop-portal-kde-6.6.6-1.gpkg.tar` | 870400 | `9cc8b1227b1cfb5d23e5800b9abd55f9de4d1aec6dd864f226e507cc07d29d33` | False |

Exact read-only resolver command:

```sh
task_features="$(portageq envvar FEATURES) binpkg-request-signature"
sudo -n nice -n19 ionice -c3 env FEATURES="$task_features" PKGDIR=/home/cabewse/.cache/pf-desktop-rollback-20261003/rollback-signed-binpkgs emerge --pretend --selective=n --verbose --ignore-default-opts --usepkgonly --getbinpkg=n --binpkg-respect-use=y --oneshot --newuse --with-bdeps=n --dynamic-deps=n --autounmask=n --autounmask-write=n --backtrack=0 --ask=n =gui-wm/qindaqt-desktop-0.1.0_pre20260928-r3 =app-misc/claude-desktop-bin-1.49585.0 =app-crypt/pinentry-1.3.3 =virtual/secret-service-0-r1 =x11-misc/sddm-0.21.0_p20250502-r1 =gnome-base/gnome-keyring-48.0-r1 =kde-plasma/aurorae-6.6.6 =kde-plasma/breeze-6.6.6 =kde-plasma/kactivitymanagerd-6.6.6 =kde-plasma/kde-cli-tools-common-6.6.6 =kde-plasma/kdecoration-6.6.6 =kde-plasma/kdesu-gui-6.6.6 =kde-plasma/kglobalacceld-6.6.6-r1 =kde-plasma/knighttime-6.6.6 =kde-plasma/kpipewire-6.6.6.1 =kde-plasma/kscreenlocker-6.6.6 =kde-plasma/kwin-6.6.6-r2 =kde-plasma/kwin-x11-6.6.6 =kde-plasma/libkscreen-6.6.6-r1 =kde-plasma/libksysguard-6.6.6 =kde-plasma/libplasma-6.6.6 =kde-plasma/milou-6.6.6 =kde-plasma/plasma-activities-6.6.6 =kde-plasma/plasma-activities-stats-6.6.6 =kde-plasma/plasma-integration-6.6.6 =kde-plasma/plasma-login-sessions-6.6.6 =kde-plasma/plasma-workspace-6.6.6 =kde-plasma/polkit-kde-agent-6.6.6 =kde-plasma/powerdevil-6.6.6-r1 =kde-plasma/qqc2-breeze-style-6.6.6 =kde-plasma/spectacle-6.6.6 =kde-plasma/xdg-desktop-portal-kde-6.6.6
```

Exact ignored artifact/command/status/log receipt hashes:

| Receipt | SHA256 |
| --- | --- |
| retired-verified-artifacts.json | `3290586d8a225b4f835a2589dce13a627f9a2226936a82f7810fc78d806df37d` |
| restoration-command.json | `d087bc5366743d7061f557b64b8aed4668f988588134df59184b23f90c2598cf` |
| restoration-status.json | `e4234b5a98e3191f830d48e44d6ee2633b5b313729056c0138db7d71f560dcfb` |
| restoration.log | `4df59e945975dd1d25ba7b7d10e1d4913e29cca0e412527ab27446d7c88afe46` |

## Concrete execution boundary and stopping point

- This proves actual currently configured normal Portage dependency/USE graph with mandatory signatures, not a fabricated supplied graph. No --nodeps, --emptytree/broad upgrade, profile/USE/signature bypass, dynamic source substitution or autounmask. All26 packages scheduled as reinstalls in the pretend, so their cached binaries are genuinely selected even though they remain installed now. Every package the manager plans to remove is a preserved exact target; all other graph dependencies remain installed/non-retired.
- The actual graph orders GNOME48-r1 before old Desktop. Native Desktop-r3 owns the GNOME alias files. Consequently do NOT merely drop --pretend and run this graph while native aliases are still owned: manager must first quiesce its selected native lifetime and release the exact native Desktop package aliases through normal Portage package transition, then restore the coherent old32 graph. No force-overwrite/hand-deletion, provider auto-start or blind name switch. This is a concrete co-install ordering constraint, not a missing binary/dependency; manager owns execution and original/native data preservation. Re-run the normal pretend at any actual rollback if retained non-retired dependency/configuration state changes.
- Preserve separate verified custom SDDM/PAM/settings backups. Standard quickpkg --include-unmodified-config=y intentionally excludes modified configurations; package snapshots do not authorize replacing user configs or removing native/original credential data. Oldfive+GNOME paths/hashes are in immutable prior2f538 receipt; no source/image changes were made here.
- Ignored QA on each host: `/home/cabewse/.cache/pf-retired-rollback-20261003/` contains availability-root.json, existing-qualified.json, capture-command.json/capture-status.json/capture.log, retired-verified-artifacts.json, restoration-command.json/restoration-status.json/restoration.log and before.json. Both target-local rollbackPKGDIRs also retain oldfive+GNOME.
- Requested next action: independent manager review of exact signed restoration readiness and concrete alias ordering, then manager may perform its already-authorized scoped retirement. Worker stops/resource-free; no retirement or physical-session/provider claim.
