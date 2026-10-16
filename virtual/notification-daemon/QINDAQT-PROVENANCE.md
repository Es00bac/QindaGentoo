# Native notification-daemon virtual provider

This copies ::gentoo `virtual/notification-daemon-0` as a new revision, with a
default-OFF `qindaqt` USE flag that the QindaQt profile enables. When the flag
is on, the virtual is satisfied by `gui-wm/qindaqt-desktop`, whose session
notification host owns `org.freedesktop.Notifications`. Without the flag, the
stock alternatives are unchanged.

Why: GNOME's `x11-misc/notification-daemon` was installed only to satisfy this
virtual, for libnotify and waydroid. Its D-Bus activation file claimed the name
whenever the QindaQt host was absent: at login, or during a host restart. It
then segfaulted, which lost notifications such as the "new package installed"
notice on 2026-10-02. With the flag set, `emerge --depclean` can remove it.

The virtual has no source archive. The repository uses thin Manifests, so there
is no distfile entry.
