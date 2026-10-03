# Actual laptop cleanup PASS; qinda cleanup pending

- Timestamp: 2026-10-03T04:10:46.582312+00:00.
- Exact overlay base: `796c876513fbdd8f8c3a7200741a3461d801e7c8`.
- Verdict: laptop scoped retirement independently VERIFIED. Qinda remains pending; no both-host cleanup claim.

| Observed host | Current installed packages | Retired Plasma CPVs | Installed two-root PF25 | Rollback26 archives |
| --- | ---: | ---: | --- | --- |
| laptop | 1359 | 0 | exit0/2.329324s;573 runtime packages/0 forbidden | filenames/sizes/SHA256 unchanged |
| qinda | 1567 | 26 | exit0/3.276738s;586 runtime packages/0 forbidden | filenames/sizes/SHA256 unchanged |

Both retain allowed `kde-plasma/kwayland-6.6.6` and `kde-plasma/layer-shell-qt-6.6.6`. Both exact installed roots remain Desktop0.1.0_pre20261002-r3 and native fork6.6.6_p1-r3. Qinda observed26 equal the preserved retired set.

## Laptop actual cleanup result

Read manager `qinda-top-final-retirement-apply-result.json` aggregates: normal scoped depclean exit0/59.528s, retired26before/0after, exactly26removed, protected1359 removed0, world/world_sets unchanged. Direct current VDB independently counts1359 packages with zero retired CPVs. Removed set equals preserved exact26. No credential/source identifiers, labels or provider records read/recorded.

## Read-only verification

```sh
sudo -n nice -n19 ionice -c3 python3 tools/check-plasma-dependencies --installed --root '=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r3' --root '=gui-wm/qindaqt-kwin-6.6.6_p1-r3'
```

Existing installed PF25 ran once per current host. No CLI emerge or source graph substitution. Direct VDB names and compressed rollback archive SHA256 only: no installed-file sweep, archive decompression, full-signature repeat, sourcebuild/GPU, provider/UI/password/config or product action. All52 signed archive filenames/paths/sizes/SHA256 match previously fully qualified receipt796. Hash/check times laptop0.194242s,qinda0.865300s; world/world_sets match pre-snapshot digests both.

Prior full52artifact path/hash list and complete32-binary graph remain `20261003T034057Z-accept-retired-26-signed-restoration-graphs.md`; existing alias/provider/config rollback ordering still applies.

Ignored QA on each host `/home/cabewse/.cache/pf-retired-rollback-20261003/`: current-cleanup-state.json includes actual26 artifact filename/hash checks; current-pf25-installed-status.json/log contain actual boundary command/status. Exact receipt hashes:

| Host / receipt | SHA256 |
| --- | --- |
| laptop / current-cleanup-state.json | `483b1db7673a35cd761816f0b602bfcda511eda8d5b79ce9e50109056ad0a680` |
| laptop / current-pf25-installed-status.json | `e95097b526cae77c339fcad6c0fd96c641159cc4d833561b33c9ca485932978f` |
| laptop / current-pf25-installed.log | `d1ce7f4b060c54f6b7491b916fd233958676898f08a78a39a0859e611c3ab2d0` |
| qinda / current-cleanup-state.json | `2b8ed69d1addd4d3cb79136df61ec21b99f4118d7b5805d91d014bcd503f2f2b` |
| qinda / current-pf25-installed-status.json | `f5f860374caeadc9b1d6cc9183fbf457e34bca578829a89f741124cec49df09c` |
| qinda / current-pf25-installed.log | `ffeecb4853cb742cd8537682ba9796c4a587f3f7e7f18246fcfe0d3fc61935b6` |

Requested next action: manager integrate laptop actual-cleanup evidence; provide qinda actual completion for final small read-only follow-up. Worker stopped/resource-free.
