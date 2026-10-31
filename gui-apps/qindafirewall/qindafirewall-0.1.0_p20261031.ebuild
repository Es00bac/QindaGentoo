# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg git-r3

DESCRIPTION="QindaFirewall - firewall settings and break-in alerts in plain English"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# The hub on qinda is read first; the laptop keeps a bare mirror at the same
# path, fast-forwarded from qinda before an emerge.
EGIT_REPO_URI="file:///home/cabewse/git/QindaFirewall.git
	file:///home/cabewse/work_SPaC3/QindaFirewall
	file:///home/cabewse/work_space/QindaFirewall"
# AGENT-NOTE: pin the reviewed commit here and bump the revision with it;
# an unpinned git-r3 ebuild builds whatever the hub holds.
# 08c7064: first release; 9 test suites pass on both hosts (real nft loads
# under unshare -rn), security-reviewed helper, run live against both journals.
EGIT_COMMIT="08c7064a11cc7fa009c6ff001a259edfccebff5d"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# gui-wm/qindaqt-desktop owns the AppShell and global-menu archives and
# headers this app links (no CMake package configs, hence find_library in
# CMakeLists.txt). dev-libs/qindatk is a runtime QML import only.
# sys-auth/polkit: pkexec starts the helper. sys-apps/iproute2: `ss` lists
# open ports. sys-apps/systemd: the journal is the default log source and the
# boot/expiry units. A firewall program is needed to change anything.
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-qt/qtbase-6.11:6=[dbus,gui,network,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
	>=dev-libs/qindatk-0.1.0-r12
	sys-auth/polkit
	sys-apps/iproute2
	sys-apps/systemd
	|| ( net-firewall/nftables net-firewall/ufw )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "QindaFirewall reads login attempts from the system journal. Your account"
	elog "must be in the wheel, systemd-journal or adm group to see them."
	elog
	elog "Members of wheel can view the firewall without a password; changes ask"
	elog "for the administrator password (polkit action org.qindaqt.firewall.helper)."
	elog
	elog "Turning the firewall on in the app enables qindafirewall.service (nftables)"
	elog "or ufw.service, so it survives a restart. Timed blocks on ufw are lifted by:"
	elog "  systemctl enable --now qindafirewall-expire.timer"
}
