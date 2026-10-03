# Prepare final five signed upgrades after actual import

- Verdict: deployment argv ready; actual import/provider/PAM activation is gated, not completed or authorized by this receipt.
- Exact overlay: `43bcc05648686c3d119a5a7428bff22cb3cda30a`.
- Exact Desktop plan: `5917da5c054ccd8ed9fd0be5a2ac9db549a4bb1c`, `ops/audits/native-host-cutover-plan-20261002.json`; accepted plan descendant of9df.
- Hubs fetched, canonical heads match. Old integrate dc828 is an ancestor, not an advance. Both installed overlay heads3da268acdd2e648ebea0a73c25a94d6cf81fb46d differ from43 only own ops; no deployment product delta.
- Reused actual normal five-binary pretends on both hosts: five upgrades/five binaries/no build/download. Qinda exact command receipt exit0/3.526313697s. Both configured/default PKGDIR=/var/cache/binpkgs contain the accepted artifacts; no private repository/cache/profile override.

## Exact execution argv, manager only, after gates below

Run on each host with Bash. Choose exactly the corresponding installed-host Pinentry line. Preserve current FEATURES and require signatures. This is preparation; no command here was executed by the worker.

```bash
# qinda:
pinentry='=app-crypt/pinentry-1.3.2-r2'
# qinda-top: use this line instead:
# pinentry='=app-crypt/pinentry-1.3.3-r1'
opts=(--ignore-default-opts --usepkgonly --getbinpkg=n --binpkg-respect-use=y
      --oneshot --newuse --with-bdeps=n --dynamic-deps=n --autounmask=n
      --autounmask-write=n --backtrack=0 --ask=n)
targets=(=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r2
         =app-misc/claude-desktop-bin-1.49585.0-r1
         "$pinentry" =virtual/secret-service-0-r3
         =x11-misc/sddm-0.21.0_p20250502-r2)
features="$(portageq envvar FEATURES) binpkg-request-signature"
sudo -n nice -n19 ionice -c3 emerge --ignore-default-opts --unmerge --ask=n \
  =gnome-base/gnome-keyring-48.0-r1
sudo -n nice -n19 ionice -c3 env FEATURES="$features" PKGDIR=/var/cache/binpkgs \
  emerge "${opts[@]}" "${targets[@]}"
```

Stop on any failure. No source fallback, --nodeps, USE/signature bypass, autounmask, broad upgrade or service restart. If targets/config/artifact identity changes after the accepted pretend, repeat this same normal resolver with `--pretend` before unmerge; never bypass a changed dependency result.

## Provider and PAM ordering

1. Root completes the actual bounded Secret Service/KWallet acquisition, sealed native import and application compatibility required by `docs/wiki/architecture/keyring-import.md`. Revalidate the selected unique owner/PID/session/display, source quiescence and absence of a destination writer. Preserve original stores and settings/PAM/world backups. Exact5917 still records locked nonempty GNOME stores67/9 and no completed import; user unlock authorization does not itself satisfy import.
2. Required signed replacements, normal five-target graph and target-local rollback readiness must pass before the GNOME package unmerge. Do not initialize native PAM/storage/name ownership early. Package unmerge changes aliases/files and cache hooks; it does not itself stop the existing provider, so an accepted pinned source may remain resident across the short file transition. No claim that an arbitrary process survives logout or can retain ownership without revalidation.
3. Immediately execute the one normal five-binary merge above. Do not force-kill providers. Native Secret Service refuses an occupied old service name before constructing its storage writer; the explicit verified old-owner release/native ownership and restored application attach follow complete import, installed-file/PAM checks and actual provider readiness. Do not invent or execute a stale PID/name-based kill command.
4. Verify SDDM CONFIG_PROTECT disposition against the already accepted measured file/VDB state. Expected final SHA256: sddm86cdc89dd89bdc5398080adf2c466ff29e977888bdb69c8ebfe645d39717a854; autologin09c36398c32ba745873f50744d0a26611da35a595e0c072a5125f7ca573a853b; greeter980e4bce55c1614828b35bd207e71d870eaf18ff3364143ba25b3ec03033cf17. Preserve laptop custom `/etc/sddm.conf.d/01gentoo.conf` SHA2564f14078facbc330a7125fe50d845097e30837bfc06547e4b535e5f93773d4153. Critical authentication blocks remain; no blind .cfg replacement/manual PAM rewrite or forced SDDM/compositor/logout. Deliberate fresh login belongs to manager/operator.
5. After native installed/runtime checks, finish only the existing guarded nonempty exact retired-CPV depclean plan. Preserve seven promoted KDE application roots and every non-retired package, kwayland/layer-shell-qt and original data. No repetition of already-completed world/set edits, no broad world depclean or forced unmerge.

## Rollback gate and executable restoration boundary

Qinda existing signed quickpkg capture exit0/3.218336098s at `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/rollback-binpkgs` contains old Desktop0.1.0_pre20260927-r7, GNOME48.0-r1 and SDDM0.21.0_p20250502-r1. Laptop old Desktop is0.1.0_pre20260928-r3. Both old Claude1.49585.0/virtual0-r1; old Pinentry qinda1.3.2-r1/laptop1.3.3. No additional package/signature sweep was run.

Remaining concrete prerequisite: manager supplies the laptop target-local signed rollback path and proves a dependency-complete normal signed rollback graph including the changed virtual/Pinentry/Claude selection, matching old USE/configuration, not merely existence of three snapshots. Preserve remaining retired dependencies until this graph is safe or retain their signed rollback artifacts too.

If import/compatibility fails, leave existing provider/PAM/package selection intact. If GNOME unmerge succeeds and the five merge fails before installing the new alias, restore exact GNOME48.0-r1 through normal mandatory-signed binary-only Portage from that host's verified rollback PKGDIR. If native aliases/PAM/provider selection already changed, first preserve native/original data and quiesce only the manager-selected native lifetime; normal Portage restores the coherent old Desktop/provider/SDDM/virtual/Pinentry/Claude graph with the target-local rollback cache. Reuse `opts`/signature policy, exact old target atoms above and verified rollbackPKGDIR; require its normal pretend before execution. No colliding force overwrite of the Secret Service alias or home-copied binary. Restore only protected settings from verified backups without overwriting preserved application world roots. Current task does not claim that missing laptop path/rollback graph has passed.

## Read-only evidence and stopping point

Only hub fetch/isolated FF, exact source documents, VDB CPV names, default cache path/existence and prior command/status receipts were read. No package install/unmerge/build/cache mutation, live provider/session action, secret read, credential prompt, full artifact verification or new harness. Manager owns actual unlock/import, rollback readiness, five-package execution and subsequent retirement/runtime acceptance.
