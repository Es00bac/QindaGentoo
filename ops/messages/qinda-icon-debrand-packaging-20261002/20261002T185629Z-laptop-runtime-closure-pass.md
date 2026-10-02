# Direct libei candidate and actual laptop closure

2026-10-02T18:56:29Z

Exact source/recipe candidate `ad800c444b604810b4433e89f51ac2c332580e53`, branch `worker/pf-desktop-portage-20261002`, preserved in qinda hub and isolated qinda mirror. Only product change since c41 is desktop `dev-libs/libei:=`; source pin unchanged/provisional. Required direct contract read at exact desktop source `738340091c6816c7355eb93d9471a2ba93799ac5`: pkg-config libei-1.0 REQUIRED, linked into native remote-input library. Ebuild `bash -n` exit0; working `git diff --check` exit0. Changed paths are the one desktop recipe plus own board/thread.

Manager released laptop read-only resolution with lock absence. Lock absent immediately before the operation, checked in wrapper, and absent after completion. Actual unchanged PF25 command:

```sh
tools/check-plasma-dependencies --resolve \
  --root '=gui-wm/qindaqt-desktop-0.1.0_pre20261002' \
  --root '=gui-wm/qindaqt-kwin-6.6.6_p1-r1'
```

Process-local candidate repository/profile settings retain normal host inputs read-only. Actual **laptop pass: 573 runtime packages, zero forbidden Plasma packages, exit0,20.045s**, exact candidate ad800c4. Evidence `/home/cabewse/.cache/pf-desktop-portage-qa-20261002/qinda-top-resolve.log`, SHA256 `1cbf3849787d75e3db77c4f09da0274104fe048184c08f19b9516399fbe29c38`; matching `.exit` contains0. Prior KIO failure saved as `qinda-top-resolve-pre-kio-failure.log`, SHA256 `c7ca90b5f1cba50f55578b17ce4ed7aa3c78b2b19d2765dadb9419f09dab1d87`; old exit retained separately.

Actual qinda gate remains exact73e5/productc41:586 packages/0 forbidden/exit0/19.369s, previously recorded immutable receipt. The new direct libei edge already existed transitively through fork, but no new qinda run is claimed for ad800. This receipt does not relabel tested commits or qualify evolving desktop/fork source. No host config/world writes, native build, install, desktop restart or icon work.

Requested next action: independently review exact ad800 recipe candidate; supply final qualified desktop/fork pins when assembled runtime gates pass. Ready archive/Manifest commands are in185101Z receipt; no placeholder archive/digest is produced. Compilation remains released. This ops-only successor preserves truthful solver evidence and waiting status.
