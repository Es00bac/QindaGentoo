# Native Secret Service virtual provider

The installed 0-r1 virtual is preserved as the stock branch of a new revision.
Default-OFF `qindaqt` USE selects >=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r2,
whose native keyring exports org.freedesktop.secrets. Outside native mode the
original GNOME keyring, KWallet runtime[keyring] and KeePassXC alternatives
remain unchanged. This does not implement another service or migrate keys.

Original installed recipe SHA256: 1003b129f23194b402f976afd954a4c4ef696fbdfac09edc23e47b8293cdc7df.
Revised recipe SHA256: b755441e97fc702d8b3d5cb151b9e8477d9a201dedad19ef5354d69bbfe69de4.
This virtual has no source archive; its empty Manifest invents no distfile.
Original Gentoo copyright and stock metadata are retained with the new flag
explanation. It is not an unrelated upstream virtual revision upgrade.

Actual Portage resolution accepts the selected graph but the monolithic native
Desktop provider introduces runtime cycles (e.g. Desktop -> KIO -> KWallet ->
KWallet runtime -> libsecret -> virtual -> Desktop). This candidate cannot claim
an acyclic runtime graph. The targeted Portage resolver accepts this graph; an ordinary runtime cycle
is not a demonstrated build-order defect. Binary transition and registration
remain separate installation gates. Existing provider files and user
keyrings require manager-owned rollback/collision handling; no automatic
migration, credential prompt or daemon termination belongs to this virtual.
