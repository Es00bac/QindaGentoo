# Deliver stock Waypipe on both hosts

- Outcome: `gui-apps/waypipe-0.9.2-r1::gentoo` installed on qinda and qinda-top through normal mandatory-signed binary-only Portage. No relay/dialog/daemon/provider or SSH action was performed.
- Base: overlay43bcc05648686c3d119a5a7428bff22cb3cda30a, source plan5917da5c054ccd8ed9fd0be5a2ac9db549a4bb1c. Overlay hub fetched and unchanged; own prior deployment receipt preserved. No recipe/source implementation added.
- Stock recipe SHA2569b8e585052b3b6eaae8ad1407dd451e42dd525810dab4a9ceb011d787a9572d7; MIT, meson. Actual normal plans: qinda exit0/4.22s, laptop exit0/3.20s, exactly one new Waypipe package and zero dependency changes;192KiB source. Same effective USE/CPU flags both hosts; no existing installed/signed Waypipe available initially.

## Actual package evidence

Normal qinda build-only command (no --nodeps, profile override, source/overlay changes):

```bash
sudo -n nice -n19 ionice -c3 env MAKEOPTS='-j2 -l16' NINJAOPTS='-j2 -l16'   emerge --ignore-default-opts --buildpkgonly --oneshot --jobs=1 --load-average=16   --usepkg=n --getbinpkg=n --autounmask=n --autounmask-write=n --ask=n   '=gui-apps/waypipe-0.9.2-r1'
```

Actual owned PID/PGID88416, exit0/18.004304904s; continuously checked6GiB memory guard never fired, minimum26,039,074,816bytes. Stock test phase restricted/disabled; no test-suite PASS claim. Logs/status/argv: qinda `~/.cache/pf-waypipe-portage-20261002/{build.log,build-command.json,build-status.json,artifact.json}`. Build log SHA256f38bef0c29343e4e3244cd8231c50695aca44aacf413209aec4ee77cea39dbbb.

Signed artifact (same on both hosts): `/var/cache/binpkgs/gui-apps/waypipe/waypipe-0.9.2-r1-1.gpkg.tar`,153,600bytes, SHA256`ba0c26ac190d7fcfb7aaa6a62a160a885ac9df00514dc91d1539923d707e8d19`. Portage gpkg signature verification and exact packaged stock-ebuild correspondence PASS. Existing FEATURES retains binpkg-signing/binpkg-request-signature; trusted key/signature policy unchanged.

Exact normal install command, both hosts:

```bash
sudo -n nice -n19 ionice -c3 emerge --ignore-default-opts --usepkgonly   --getbinpkg=n --binpkg-respect-use=y --oneshot --autounmask=n   --autounmask-write=n --ask=n '=gui-apps/waypipe-0.9.2-r1'
```

Qinda exit0, one binary/one new package, dependency calculation2.80s. Laptop test lock absent at initial check, immediately before cache import, and immediately before install. Exact signed artifact copied only to Portage cache (not installed software files). First laptop binary pretend exit1 because existing pkgdir-index-trusted did not index the copied object; no dependency failure/build. Installed Portage `binarytree.inject` verified exact signature/SHA then registered only that package under the existing index lock, same allocated path; no feature/security/configuration change or full reindex. Corrected normal binary pretend exit0/1.98s, one binary/zero download. Laptop actual install exit0/10.544003555s; argv/log/status at laptop `~/.cache/pf-waypipe-portage-20261002/install-{command.json,status.json}` and `install.log`.

Both VDB repositories `gentoo`; `/usr/bin/waypipe` CONTENTS ownership/integrity MD5`3c7044a509f36efb69dc98c911d3e882` matches actual file on both. Actual `--version` reports0.9.2 and help documents `--no-gpu`, `--oneshot`, `--threads`. Manager can bound later relay CPU with `--no-gpu --threads 1`; this worker did not launch a relay or make any credential/UI/session/provider action. No laptop source build/GPU, dependency upgrades, host settings/world selection changes, SSH-security modifications or broad package graph.

## Handoff

Infrastructure outcome complete. Manager owns any real authorized Waypipe relay/password-window use and actual import. Compiler/worker runtime lease released; no continuing process claimed.
