# Concrete final source recipe/archive candidate

Exact manager source candidates: desktop `cb58205992bdf35bddc7bb30780482f5695f623d`, fork `a6964310dbfb3a11df06532a32059f4ab9e92ac2`. Recipes: desktop0.1.0_pre20261002 and fork6.6.6_p1-r1, unchanged dependency/option contracts. Gabbee accepted2e6/source0a232/signed10c9, Media27b OFF/PDEPEND, direct libei, KIO narrow recipes and profiles unchanged. This is candidate-source packaging only; native/runtime qualification remains underway. No publish/install/build/session restart.

Actual qinda archive commands use exact respective ~/git hubs, `git archive --format=tar --prefix=<prefix>/ <full commit>` piped to `gzip -n -1`, private output directory `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/candidate-distfiles`. Git/gzip both exited0. Each archive's normalized relative members, prefix and links inspected; no links/unsafe paths. Seven selected source members independently compared byte-for-byte to exact hub git show, including protected metadata/power and fork serial/native EIS predicate. Both actual new DIST rows carry computed BLAKE2B/SHA512; desktop old Manifest bytes unchanged, new fork Manifest only new row.

- qindaqt-desktop-0.1.0_pre20261002.tar.gz: 41323162bytes, 10713members, prefix `QindaQt-cb58205992bdf35bddc7bb30780482f5695f623d/`, SHA256 `c14fc9fa8f26e8b3df8bd6e3e7a9f6997ed4dd1110c0c28b7fb2111b9dfa75be`; archive+validation 1.906s.
- qindaqt-kwin-6.6.6_p1-r1.tar.gz: 15857349bytes, 4017members, prefix `qindaqt-kwin-6.6.6_p1-r1/`, SHA256 `38045acb9aa55f6bcf3d7d66be0cd206bf74a677614b9bf60ce6e90fa73fafac`; archive+validation 0.891s.

Archive receipt (all digests and member-byte evidence): `/home/cabewse/work_SPaC3/.qa/pf-desktop-portage-final-20261002/archive-receipt.json`, SHA256 `ee97f6792178c648235318227ee710d52596106f4e18e1284631cef402075173`.

Ready both-host read-only closure commands through existing task-local process repository/profile config: `tools/check-plasma-dependencies --resolve --root =gui-wm/qindaqt-desktop-0.1.0_pre20261002 --root =gui-wm/qindaqt-kwin-6.6.6_p1-r1`. Exact final-candidate replay follows root acknowledgment/source review; no host configuration/world edits, no compiler/build/install. Laptop lock must be absent immediately before replay. Preserve actual count/log/exit; do not relabel earlier586qinda/573laptop passes as this candidate.

Requested next action: independent root exact recipe/Manifest source review, then acknowledge read-only closure replay on both hosts. Native/runtime/source qualification and subsequent publish/build/install remain manager gates. No new tooling/framework or icon work.
