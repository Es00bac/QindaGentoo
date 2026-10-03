# Installed final five / PAM / two-root PF25 PASS

- Timestamp: 2026-10-03T03:30:11.392851+00:00
- Exact overlay worker base: `2f538f7550e7cf1c49494a743b9f4e0f6b9c799c`.
- Checked only after each actual manager final-five-install-result.json showed installationPassed=true and GNOME retirement/five merge exit0. Manager owns installation and real sealed imports; this worker performed read-only installed verification only.
- Verdict: ACCEPT installed package/source/payload/auth-file/dependency boundary on both hosts. This is not physical fresh-login, provider ownership, lock/GPU or retired-package removal acceptance.

## Actual installed versions and payload counts

| Host | CPV | Regular files | Symlinks | Repository |
| --- | --- | ---: | ---: | --- |
| qinda | gui-wm/qindaqt-desktop-0.1.0_pre20261002-r3 | 2284 | 4 | qindaqt |
| qinda | app-misc/claude-desktop-bin-1.49585.0-r1 | 3209 | 2 | qindaqt |
| qinda | app-crypt/pinentry-1.3.2-r2 | 13 | 1 | qindaqt |
| qinda | virtual/secret-service-0-r3 | 0 | 0 | qindaqt |
| qinda | x11-misc/sddm-0.21.0_p20250502-r2 | 203 | 0 | qindaqt |
| laptop | gui-wm/qindaqt-desktop-0.1.0_pre20261002-r3 | 2284 | 4 | qindaqt |
| laptop | app-misc/claude-desktop-bin-1.49585.0-r1 | 3209 | 2 | qindaqt |
| laptop | app-crypt/pinentry-1.3.3-r1 | 13 | 1 | qindaqt |
| laptop | virtual/secret-service-0-r3 | 0 | 0 | qindaqt |
| laptop | x11-misc/sddm-0.21.0_p20250502-r2 | 203 | 0 | qindaqt |

Each host: 5,709 regular files +7 symlinks verified directly against accepted signed payload SHA256/type/mode/targets and installed ownership; 378 shared directories checked for presence. No unexpected package-owned non-directory paths after the exact accepted PF-only documentation path normalization. All five installed ebuild hashes and USE/IUSE/CHOST/RDEPEND/DEPEND/PDEPEND/BDEPEND/SLOT metadata match signed binaries. Actual default-cache archive hashes match prior independently accepted full-signature/full-image receipts; only signed metadata was reverified, with no repeat decompression or full-signature sweep.

Desktop r3 source correspondence remains exact accepted62acb69b931a091a9ee5161cf65dba570b5a17a4 via immutable29f archive +accepted8a install patch +62 six-file patch. Installed recipe SHA2561d4a51e7fe010bf129a2022b41c72e655210e2925fa2629f846312125c86f762; accepted GPkg SHA256bd279969c0f70bc5cb64dcb0d9d89c7676699c8b619ca76e0fd96dc2f5123b56. Other accepted source/signature bindings reused from Power signed-build-final-artifacts.json and each verification/artifact.json, not guessed from VDB version names.

## Installed two-root PF25

```sh
sudo -n nice -n19 ionice -c3 python3 tools/check-plasma-dependencies --installed \
  --root "=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r3" \
  --root "=gui-wm/qindaqt-kwin-6.6.6_p1-r3"
```

- Laptop: actual exit0, 573 runtime packages, zero forbidden Plasma packages.
- Qinda: actual exit0/2.618030s, 586 runtime packages, zero forbidden Plasma packages.
- Read-only installed metadata, both exact roots, RDEPEND/PDEPEND selected alternatives; no dynamic recipe substitution, host profile/world change or source-resolution fake pass. Only existing kwayland/layer-shell-qt allowances. Direct five-package RDEPEND/PDEPEND additionally contain no forbidden retired Plasma atom.

## Authentication files / CONFIG_PROTECT

Both hosts exact expected SHA256:

| Path | SHA256 |
| --- | --- |
| `/etc/pam.d/sddm` | `86cdc89dd89bdc5398080adf2c466ff29e977888bdb69c8ebfe645d39717a854` |
| `/etc/pam.d/sddm-autologin` | `09c36398c32ba745873f50744d0a26611da35a595e0c072a5125f7ca573a853b` |
| `/etc/pam.d/sddm-greeter` | `980e4bce55c1614828b35bd207e71d870eaf18ff3364143ba25b3ec03033cf17` |

Laptop custom `/etc/sddm.conf.d/01gentoo.conf` remains SHA2564f14078facbc330a7125fe50d845097e30837bfc06547e4b535e5f93773d4153. CONFIG_PROTECT left `/etc/sddm.conf.d/._cfg0000_01gentoo.conf`, SHA2561c0dec050b63c45c64c95242589f632fa7005a6c8331367adb51812b4ad961e5, exactly matching the signed packaged default; active custom file is intentionally retained. No pending SDDM PAM updates on either host, no qinda SDDM config candidates, and no critical authentication hash difference. Do not blindly replace the custom file. No config/PAM edits made.

## Actual commands/evidence and bounded qualification

- Existing trusted accepted payload inventories bundled to ignored QA only. Direct comparison command: `sudo -n nice -n19 ionice -c3 python3 /home/cabewse/.cache/pf-installed-final-five-20261003/check_installed.py /home/cabewse/.cache/pf-installed-final-five-20261003` on each host. Qinda exit0/1.299292s.
- Laptop first strict checker exit1/1.409451s solely because reused comparison inventory normalized documentation to oldr2, textual CPV parsing counted versioned allowed atoms, and preserved custom SDDM config differed from packaged default. Original result retained. Bounded separate qualification exit0 proved exact newr3 documentation SHA/mode/ownership, parsed actual allowed CPs, and verified custom hash +exact pending packaged config. No repeated whole-file scan or relaxed unknown difference.
- Ignored receipts on each host: `/home/cabewse/.cache/pf-installed-final-five-20261003/{accepted-payloads.json,installed-five-result.json,pf25-installed-status.json,pf25-installed.log}`; laptop also initial strict result. Exact JSON receipt SHA256s:

| Host / receipt | SHA256 |
| --- | --- |
| laptop / installed-five-result.json | `844fcc413eb04daf79017df0b9a45e84a707615e34cd401fbdf25fcc390adaf0` |
| laptop / pf25-installed-status.json | `930edc96b686b158c10d20c95e3c4063992fd7f67969fd13ec5f930e2f02fe82` |
| laptop / pf25-installed.log | `d1ce7f4b060c54f6b7491b916fd233958676898f08a78a39a0859e611c3ab2d0` |
| qinda / installed-five-result.json | `93d45f06ac245e5f336bc60c9a9cb80ff50e07202abaede31378fd7ff76d779e` |
| qinda / pf25-installed-status.json | `83e31d676ef829a88064255eae1af0ab2b31cdeb872e5c6cab184256ffa88b31` |
| qinda / pf25-installed.log | `ffeecb4853cb742cd8537682ba9796c4a587f3f7e7f18246fcfe0d3fc61935b6` |

No new build/packaging/install/unmerge/provider/name/UI/GPU/compiler/global settings or secret access. Low-priority read-only diagnostics only; old signed artifacts and importer image preserved. Worker stops with no active process/resource lease. Requested next action: manager may use this installed boundary receipt for the already-authorized fresh-session/runtime/retired-only cutover gates.
