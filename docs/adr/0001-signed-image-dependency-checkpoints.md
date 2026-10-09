# ADR 0001: Signed-image dependency checkpoints

- Status: Accepted source design; package/image qualification required
- Date: 2026-10-09

A desktop dependency-only checkpoint may consume an exact previously signed
Portage gpkg rather than recompile unchanged source. R24 retains R23 source
1a5359e and every image path while changing the media post-dependency to r3.
The earlier source-build R24 recipe and stopped attempt remain in Git/evidence.

The input is pinned by the committed Manifest and SHA256. Portage must verify
its complete GPG signature, exact embedded R23 recipe/source and all 2,622
image path/type/mode/content records before staging into its private image.
For this exact SHA/Manifest-pinned immutable input only, GPG verification runs
as the ebuild user inside the unchanged Portage sandbox. Its writable temporary
home contains only the trusted public ring/trustdb; nobody cannot traverse
Portage's private T. No secret keys, system-keyring writes or arbitrary input
are admitted. No compiler runs, no stripping is allowed, and the new signed package must
match that image ledger again. Unverified inputs or parity failures stop the
package; missing trust is never bypassed. Runtime dependencies, license, SLOT
and compositor ABI retain the reviewed image's contract.

Repacking occurs only inside Portage. Direct VDB edits, dependency-bypassed
adoption and hand installation would leave package metadata or ownership false.
Normal Portage resolves the R24+r3 pair and signs the new gpkg. Rollback uses
the retained signed R23+r2 packages through normal Portage, preserving the
current session and user data; no restart or device action is automatic.
