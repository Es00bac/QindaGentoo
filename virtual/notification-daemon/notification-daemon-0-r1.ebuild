# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for notification daemon dbus service"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~loong ~mips ppc ppc64 ~riscv ~sparc x86"
IUSE="gnome kde qindaqt"

# AGENT-CONTRACT: the QindaQt session's notification host owns
# org.freedesktop.Notifications. With USE=qindaqt no other daemon is pulled
# in. A second, D-Bus-activatable daemon would claim the name whenever the
# QindaQt host was not on the bus, as GNOME's notification-daemon did and then
# crashed on 2026-10-02 and 2026-10-14. Without the flag, the stock alternatives
# are unchanged.
RDEPEND="
	qindaqt? ( gui-wm/qindaqt-desktop )
	!qindaqt? (
		gnome? ( || ( x11-misc/notification-daemon
			gnome-base/gnome-shell ) )
		kde? ( kde-plasma/plasma-workspace )
		!gnome? ( !kde? ( || (
			x11-misc/notification-daemon
			gnome-extra/cinnamon
			gui-apps/mako
			xfce-extra/xfce4-notifyd
			x11-misc/notify-osd
			x11-misc/dunst
			>=x11-wm/awesome-3.4.4[dbus]
			x11-wm/enlightenment
			x11-misc/mate-notification-daemon
			lxqt-base/lxqt-notificationd
			net-misc/eventd[notification] ) ) )
	)
"
