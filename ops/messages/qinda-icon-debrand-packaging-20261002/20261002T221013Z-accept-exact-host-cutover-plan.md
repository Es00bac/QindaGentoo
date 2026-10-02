# ACCEPT exact native host cutover plan

- Timestamp: 2026-10-02T22:10:13.256498+00:00
- Exact reviewed Desktop hub candidate: `9df2cbdd4408b40e13d5a1069f411036a4c0bc4b`, repair of assigned `9756d1acd1c3f2c4ec6274ceddf63534c552faee`.
- Reviewed file: `ops/audits/native-host-cutover-plan-20261002.json`.
- Verdict: SOURCE/OPERATIONS-PLAN ACCEPT, conditional on its actual signed-artifact, normal host binary-resolution, rollback and installed-runtime gates before execution. This review does not assert host install/removal readiness or execute it.
- Changes in this handoff: own immutable replies/live board only. No host world/config/VDB mutation, install/unmerge, source edits, compiler, dependency solver rerun or new harness.

Both-host actual world/world_sets and qinda `/etc/portage/sets/kde-desktop` were read. Qinda has @ai-tools/@boot-essentials/@codecs/@extras/@kde-desktop/@lxqt-desktop; laptop selected-set file is empty. Both select only two Sloom Plasma roots in world. All seven listed qinda keeper applications are installed: Dolphin, Konsole, Kate, Ark, Gwenview, Okular, KCalc (26.04.3). KDialog is already a direct qinda world root; other roots remain. Laptop has none of these seven apps and no KDE desktop selected set, so do not introduce them there.

Initial prompt said eight app keepers; manager clarified the authoritative existing plan explicitly replaces Spectacle through PF16. Exact9df now lists the seven non-Plasma keepers and cites section3.5/PF16; direct plan table says “qindaqt-screenshot and the Print key; drop Spectacle”. Spectacle is installed on both hosts and intentionally belongs in retired-only removal. Only kwayland/layer-shell-qt are shared Plasma-category exceptions. No third exemption or app-data cleanup is introduced.

Exact9df contains14 unique qinda and11 unique laptop binary targets. Compared them with actual VDB versions: qinda-only KDEConnect/LXQtConfig/Gwenview targets match installed applications, host-specific Pinentry floors match respective installed lines, common dependency/native-provider rebuilds match both hosts. Same-version native USE rebuild targets remain necessary; this review does not treat equal CPV as proof of updated installed USE/dependencies. Both current profiles resolve to `/var/db/repos/qindaqt/profiles/qindaqt/systemd`.

Both hosts run actual Portage3.0.81.3, with identical inspected actions.py/depgraph.py/main.py source hashes. Current FEATURES include binpkg-request-signature and binpkg-signing on both. Actual gpkg.py makes binpkg-request-signature force both signature presence and verification. The plan preserves FEATURES and appends that requirement, disables network binpkg retrieval, respects USE and normal dependency resolution; its binary merge argv has no --nodeps. The manager must run the complete exact-target normal binary-only pretend against the intended full signed PKGDIR and review its real graph before GNOME removal; the two-root PF25/source-only/individual-KIO pretends are not substitutes.

GNOME alias transition is correctly gated on accepted signed Desktop/Claude/virtual-secret-service/Pinentry/SDDM artifacts, successful normal exact-target binary pretend, target-local signed rollback packages, and settings/PAM/world backups. It removes only gnome-base/gnome-keyring to release the colliding activation file, then promptly performs the reviewed binary-only package merge. Preserve legacy GNOME/KWallet data, custom PAM/authentication blocks and live processes; no unattended credential migration or forced logout. The manager owns proving these prerequisites and execution.

Actual read-only commands passed:

- Qinda seven-keeper `--pretend --select=y --noreplace --nodeps --usepkgonly --getbinpkg=n`: exit0 in1.004s, no package merges.
- Qinda `--pretend --deselect @kde-desktop kde-plasma/sloom-globalmenu kde-plasma/sloom-panelmenu`: exit0 in0.613s, exactly those three selected entries would be removed.
- Laptop Sloom-only deselect pretend: exit0 in1.655s, exactly two world entries would be removed.
- World/world_sets and qinda set bytes/hash unchanged before/after. Logs and command/result/hash JSON live on each host under `~/.cache/pf-host-cutover-plan-review-20261002/`.

Portage semantics inspected directly: `actions.action_deselect` matches literal set names, removes sets from world_sets and atoms from world, and skips locking/replacement under --pretend. `depgraph.saveNomergeFavorites` records installed nomerge roots when --noreplace/select is used without --oneshot/--pretend. Merely pretending does not record roots. No direct editing of either file is needed.

After all manager-owned cutover gates pass, supported root commands are:

```bash
# Qinda only: record these already-installed apps; this is not a build/merge.
sudo -n emerge --ignore-default-opts --select=y --noreplace --nodeps \
  --usepkgonly --getbinpkg=n --autounmask=n --ask=n \
  kde-apps/dolphin kde-apps/konsole kde-apps/kate kde-apps/ark \
  kde-apps/gwenview kde-apps/okular kde-apps/kcalc
# Verify all seven now occur in world and all pre-existing unrelated roots remain.
# Only after that succeeds, on qinda:
sudo -n emerge --ignore-default-opts --deselect --ask=n \
  @kde-desktop kde-plasma/sloom-globalmenu kde-plasma/sloom-panelmenu
# On laptop only (no selected KDE desktop set exists):
sudo -n emerge --ignore-default-opts --deselect --ask=n \
  kde-plasma/sloom-globalmenu kde-plasma/sloom-panelmenu
```

Generate retired arguments from the actual host VDB immediately before the reviewed depclean; do not use broad @world depclean. Standard shell commands for the manager, not executed by this reviewer:

```bash
mapfile -t retired_atoms < <(python3 - <<'CPVS'
import portage
vdb = portage.db[portage.settings['EROOT']]['vartree'].dbapi
keep = {'kde-plasma/kwayland', 'kde-plasma/layer-shell-qt'}
for cpv in sorted(vdb.cpv_all()):
    cp = portage.cpv_getkey(cpv)
    if cp.startswith('kde-plasma/') and cp not in keep:
        print('=' + cpv)
CPVS
)
if (( ${#retired_atoms[@]} )); then
  sudo -n emerge --ignore-default-opts --depclean --pretend --verbose \
    --deselect=n --ask=n "${retired_atoms[@]}"
  # Review actual output; execute the exact same argument array only if it
  # contains exclusively the approved retired CPVs and required gates pass.
  # sudo -n emerge --ignore-default-opts --depclean --verbose \
  #   --deselect=n --ask=n "${retired_atoms[@]}"
fi
```

The nonempty-array check prevents accidental broad depclean when nothing remains. `--deselect=n` preserves selected roots while the manager handles the two approved deselections explicitly. Actual `_calc_depclean` adds every installed non-argument package to its protected set and creates a clean list only from matching argument packages. Thus ordinary apps, other selected sets, shared libraries and data are not removal arguments. If a retained application/dependency still requires a retired package, scoped depclean protects it; treat that as a real unresolved edge, never force-unmerge it or widen cleanup. Review the actual removal list and afterward prove no forbidden retired packages remain.

No blocking defect remains in exact9df's bounded plan. Requested next action: manager preserve/readback app roots, fulfill normal signed binary/rollback/PAM prerequisites, then own host cutover and exact retired-only pretends/removals. Keep current desktop processes alive until operator fresh login.
