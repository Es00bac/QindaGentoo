# Actual qinda runtime closure and final-pin preparation

2026-10-02T18:51:01Z

Exact overlay tested: `73e5a115c3f2d616529393dce38ff43369f93f16`, product source `c41a8625f8f087ff63a6c0743f1ea54588c8aa31`. Manager recovery release permitted qinda read-only solver only. No compiler, GPU, install, host configuration/world write or desktop restart occurred. Laptop replay remains deferred during recovery; its older pre-KIO failure is not a closure pass.

The unchanged accepted PF25 command ran once with process-local candidate repository/profile settings:

```sh
tools/check-plasma-dependencies --resolve \
  --root '=gui-wm/qindaqt-desktop-0.1.0_pre20261002' \
  --root '=gui-wm/qindaqt-kwin-6.6.6_p1-r1'
```

Actual result: **586 runtime packages, zero forbidden Plasma packages, exit 0, 19.369 seconds**. This proves qinda candidate runtime dependency closure under the proposed profile; it does not qualify provisional source pins or prove installed runtime behavior. Narrow KIO recipes remove the original two-package external-editor tail without widening the guard.

Exact qinda evidence:

- `/home/cabewse/.cache/pf-desktop-portage-qa-20261002/qinda-resolve.log`, SHA256 `a01469bd2f117d5ee9842691469f542ca1d802b48e3dd579bbbef0a0880c7cf0`.
- `qinda-resolve.exit` contains `0`.
- Prior failing log preserved as `qinda-resolve-pre-kio-failure.log`, SHA256 `60b383254cc5d2ade676f8542cb1fc8debb8c80040b529603ab5c6b2cb7a0e15`; matching prior exit retained separately.

## Ready commands after manager supplies final reviewed pins

These commands are prepared, **not executed**. First replace both provisional recipe pins with manager-supplied exact qualified commits and verify the desktop includes accepted NativePowerExclusive unit/supervisor changes. Current desktop1502 does not yet contain that option. Confirm fork serial1 and desktop exact6.6.6.1 ABI remain valid; a source serial change requires coherent recipe/version revision rather than silently reusing these atoms.

On qinda, set `desktop_release_commit` and `fork_release_commit` to the exact reviewed 40-character commits. Read the hubs, not a dirty working checkout. Cut private archives with the existing recipe prefixes, using fixed qinda Git/gzip versions:

```sh
set -e
set -o pipefail
release_distdir=/home/cabewse/.cache/pf-desktop-portage-qa-20261002/final-distfiles
mkdir -p "$release_distdir"
git -C /home/cabewse/git/container-wm.git cat-file -e "${desktop_release_commit}^{commit}"
git -C /home/cabewse/git/qindaqt-kwin.git cat-file -e "${fork_release_commit}^{commit}"
git -C /home/cabewse/git/container-wm.git archive --format=tar \
  --prefix="QindaQt-${desktop_release_commit}/" "$desktop_release_commit" \
  | gzip -n -1 > "$release_distdir/qindaqt-desktop-0.1.0_pre20261002.tar.gz"
git -C /home/cabewse/git/qindaqt-kwin.git archive --format=tar \
  --prefix=qindaqt-kwin-6.6.6_p1-r1/ "$fork_release_commit" \
  | gzip -n -1 > "$release_distdir/qindaqt-kwin-6.6.6_p1-r1.tar.gz"
```

After exact archives exist, calculate actual sizes/BLAKE2B/SHA512 with the existing Portage manifest workflow using this private DISTDIR; append only the new archive DIST rows, preserving old records. For reviewable standalone digest output:

```sh
python3 - "$release_distdir" <<'PY'
import hashlib
from pathlib import Path
import sys
for name in ('qindaqt-desktop-0.1.0_pre20261002.tar.gz',
             'qindaqt-kwin-6.6.6_p1-r1.tar.gz'):
    path = Path(sys.argv[1]) / name
    blake = hashlib.blake2b()
    sha = hashlib.sha512()
    with path.open('rb') as source:
        for block in iter(lambda: source.read(1048576), b''):
            blake.update(block)
            sha.update(block)
    print(f'DIST {name} {path.stat().st_size} BLAKE2B {blake.hexdigest()} SHA512 {sha.hexdigest()}')
PY
```

Preserve the matching recipe/Manifest candidate commit in the qinda hub and obtain manager review before publishing archives with existing `tools/qinda-sync publish`. Do not copy into global DISTDIR first. Root owns source/runtime qualification, subsequent integrated image gates and any installation. No placeholder digest or new framework is introduced.

Requested next action: finish exact source review; provide final qualified desktop/fork pins when ready. Queue the laptop read-only replay only after recovery release. This qinda pass removes the concrete solver blocker; two-host closure and release delivery are still pending.
