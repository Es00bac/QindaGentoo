# Final desktop/fork freeze workflow ready

Working overlay: worker/pf-gabbee-portage-20261002; exact accepted recipe2e6e8fb7a0ff4feef2d83acf50fbcce876bb4076 plus signed receipt10c9d74. Preserve Gabbee0a232449a64ac54b1c065ec391f6ba53f7fbe95e, desktop direct libei, native Power/Shortcuts options and RemovableMedia OFF/exact PDEPEND leaf; preserve all old recipes and old DIST records. Desktop/fork pins remain provisional pending manager exact freeze.

Ready existing-workflow sequence, qinda only:

1. Verify each manager-supplied full commit exists in respective ~/git/container-wm.git and ~/git/qindaqt-kwin.git hubs. Read final native option declarations, source fork serial1/exact6.6.6.1 ABI and qualified conditional broker metadata installation. No branch-tip inference, compiler or runtime test.
2. Pin only QINDAQT_COMMIT in new qindaqt-desktop pre20261002 and QINDAQT_KWIN_COMMIT in new fork6.6.6_p1-r1. Update only relevant README/CLAUDE and delivery freeze comments to distinguish source freeze from uncompleted runtime/package/install qualification.
3. Cut task-private deterministic archives on qinda: `git --git-dir=<container hub> archive --format=tar.gz --prefix=QindaQt-<exact desktop commit>/ <exact desktop commit>` to qindaqt-desktop-0.1.0_pre20261002.tar.gz; fork equivalent `--prefix=qindaqt-kwin-6.6.6_p1-r1/ <exact fork commit>` to qindaqt-kwin-6.6.6_p1-r1.tar.gz. Output under task-local ignored QA, never global DISTDIR before matching committed Manifest.
4. Validate exact prefix, safe relative paths/no unsafe links, source pin/serial via archive member bytes. Compute actual size, BLAKE2B and SHA512 on qinda, append only matching new DIST rows. Do not rewrite old distfile entries or fabricate hashes. Retain archive SHA256 and exact source identity receipt.
5. bash-n two changed recipes, git diff-check, compare untouched Gabbee/Media/libei and old recipe/Manifest entry bytes; hand off one exact commit and archive receipts for independent root recipe review. No repeat healthy closure/C++/native tests without a new dependency change or root request.
6. Publish archives through existing tools/qinda-sync publish ONLY after matching Manifest commit is preserved hub and accepted by root. Root owns source qualification, production source integration, final Portage phases/signature/ownership/installed merges and active-session restart.

No final archive/Manifest generated yet; source review receiptac2c1c07bfaa9be18f22e71db989886d125aeaac is not runtime acceptance. Requested next action: manager final desktop/fork freeze pins, then exact final recipe/archive candidate handoff. No new release framework.
