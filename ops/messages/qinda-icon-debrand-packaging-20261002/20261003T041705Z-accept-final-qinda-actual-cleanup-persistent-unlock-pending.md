# Final actual qinda retired-package cleanup PASS

- Timestamp: 2026-10-03T04:17:05.066049+00:00.
- Exact overlay base: `d718a4a2d68c3cf5f05ac84f3370923d55541d77`.
- Verdict: actual qinda scoped cleanup independently VERIFIED, completing the package-removal evidence for both hosts. Persistent Login unlock and fresh physical/PAM login remain pending; no complete physical-session acceptance.

## Actual current host and removal receipt

Direct qinda VDB:1541 packages, zero retired kde-plasma CPVs; only allowed `kde-plasma/kwayland-6.6.6` and `kde-plasma/layer-shell-qt-6.6.6` remain. Manager exact `qinda-final-retirement-apply-session-qualified-result.json`: exit0/64.668s, before26/after0, exact26 removed equal previously preserved rollback set, protected1541 removed0, world/world_sets unchanged. Direct world/world_sets hashes also equal pre-capture baseline.

Manager result explicitly `clientProbeScope=volatile-session`, `persistentLoginUnlockVerified=false`. Its source receipt SHA256 `a809095933f35154eae9afc8085817504b8d2fd5e0b6e2a013529c821fdc2428`. This worker did not query persistent data, relaunch any probe or infer an answered password/fresh-login gate.

Laptops prior exactd718 actual1359packages/retired0/PF25pass remains independent already verified evidence; no laptop work rerun.

## Installed two-root PF25 after final removal

```sh
sudo -n nice -n19 ionice -c3 python3 tools/check-plasma-dependencies --installed --root '=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r3' --root '=gui-wm/qindaqt-kwin-6.6.6_p1-r3'
```

Actual exit0/2.329545s,586 runtime packages,0 forbidden Plasma packages. Both exact installed roots and selected RDEPEND/PDEPEND closure checked, no supplied fakegraph/source substitution or CLI emerge action.

## Nonactivating native owner metadata

Direct existing user-bus connection; only standard bus `GetNameOwner`, `GetConnectionUnixProcessID`, `GetConnectionUnixUser`, and repeated owner-stability check with NO_AUTO_START. Native service owner stable, UID1000/PID491214; same real user. Actual `/proc/PID/exe` is `/usr/bin/qindaqt-keyring`, SHA256 `255a1fd04c7687e2de8d544eff290afb65b361cea70e89b44685eacae3467108`, matching accepted signed Desktop-r3 native payload. No reliance on service-name spelling alone. Zero secret-interface calls, no source identifiers/labels/values or credentials read/recorded, no provider activation/name change/UI/bridge lifetime action.

Ignored aggregate receipts qinda `/home/cabewse/.cache/pf-retired-rollback-20261003/`: final-qinda-cleanup-state.json, final-qinda-pf25-installed-status.json/log. Exact hashes:

| Receipt | SHA256 |
| --- | --- |
| final-qinda-cleanup-state.json | `7309ebacd6fb796bc7e8451016fbef2e58b6893867d035a9400a4eb8ca4e2f70` |
| final-qinda-pf25-installed-status.json | `aa027e2f8529350c5724ca01b0151ad0b8e02844867fcd912669c47bec8e600e` |
| final-qinda-pf25-installed.log | `ffeecb4853cb742cd8537682ba9796c4a587f3f7e7f18246fcfe0d3fc61935b6` |

Existing signed rollback52 filenames/hashes remain already verified immutable d718; no repeat rollback hash/full payload/signature/decompression. Read-only, nice19/idleIO, no build/GPU/install/unmerge/config/PAM/provider/password/product change. Requested next action: manager integrate final actual package cleanup evidence while retaining persistent Login unlock and physical/PAM fresh-session gates as pending. Worker stopped/resource-free and available.
