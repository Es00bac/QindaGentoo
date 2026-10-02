# Narrow KIO dependency adaptation

KIO6.27.0-r1 and6.29.0-r1 are exact matching Gentoo recipes from the two
actual PF25 host resolutions, with **only** `kde-plasma/keditfiletype` removed
from PDEPEND and its explanatory comment replaced. Copyright/licenses,
source archives, build functions, implementation, all RDEPEND/DEPEND/BDEPEND,
the remaining kded PDEPEND and the6.29 Gentoo shell-script patch are unchanged.
No KIO source fork or invented substitute service exists. DIST records are
byte-exact original Gentoo Manifest rows.

Original recipe SHA256:

- kio6.27.0: `446edc5ff750d23ddb3a9ad1cd12b04dc9ea12949ef26be5ed31c67534dd5771` (qinda-top Gentoo snapshot).
- kio6.29.0: `6f82f97c6c7dd5af98265371b07c8c6f75740747969765688225d2eed57e5656` (qinda Gentoo snapshot).
- Original6.29 patch: `90b83294a29bb0a09c93f134d13243ddc6f1df99d7e9d19be2e7f6af4e5948e8`.

The unconditional upstream dependency exists for the external Edit File Type
action reachable from a KIO/KWidgetsAddons file-properties dialog (Gentoo
bug944812). QindaQt does not delegate its association editor to that action.
Exact desktop1502fcc7a635d6a149448e0094377b49f28438e2 already exposes
Settings `--page default-apps` over native mimeapps.list persistence and File
Manager Open With uses that same store per MIME type: `open_with_controller.cpp`
calls `saveMimeTypeDefault`; `default_applications_store.cpp` implements the
bounded, reparsed per-type default and Added Association write. The normative
`docs/wiki/apps/default-applications.md` and ADR0269 describe exact precedence
and preservation of unrelated associations.

This preserves native MIME application association editing, not the standalone
keditfiletype utility's broader MIME definition/icon/glob authoring. Users of
legacy KDE properties dialogs who need that external tool may install it
independently; this profile does not unmerge it or modify world. The adaptation
is limited to native desktop dependency closure, under manager authorization.

Before this change, both actual two-root PF25 graphs failed with desktop ->
KIO -> keditfiletype -> kde-cli-tools-common (579 packages on qinda-top,592
on qinda, two forbidden providers each). Following the manager's desktop
recovery hold, no solver rerun or runtime-closure PASS is claimed for these
new recipes. Independent review and an actual two-host read-only resolver
rerun remain required after recovery release; no install/build is authorized.
