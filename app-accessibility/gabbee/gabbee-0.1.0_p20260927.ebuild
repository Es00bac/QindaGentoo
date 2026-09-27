# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_SINGLE_IMPL=1

inherit desktop distutils-r1 xdg git-r3

DESCRIPTION="Push-to-talk dictation, QindaQt Voice1, and bounded desktop recovery"
HOMEPAGE="https://github.com/Es00bac/gabbee"
EGIT_REPO_URI="file:///home/cabewse/git/gabbee.git
	file:///home/cabewse/gabbee
	file:///home/cabewse/work_space/gabbee"
# AGENT-GUARD: this is an immutable pin. Bump the package version with it.
EGIT_COMMIT="141e044c4565354ed92da922675cc4c74bfc5b37"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+qindaqt +ibus sound +whisper"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pyqt6[dbus,gui,network,widgets,${PYTHON_USEDEP}]
		dev-python/python-dotenv[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/websockets[${PYTHON_USEDEP}]
		dev-python/secretstorage[${PYTHON_USEDEP}]
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
	app-accessibility/at-spi2-core[introspection]
	media-video/pipewire[extra]
	gui-apps/wl-clipboard
	ibus? ( app-i18n/ibus[introspection] )
	qindaqt? (
		net-misc/openssh
		sys-apps/systemd
	)
	sound? ( media-libs/libcanberra )
	whisper? (
		dev-python/faster-whisper[${PYTHON_SINGLE_USEDEP}]
		app-accessibility/faster-whisper-models
	)
"
BDEPEND="test? ( ${RDEPEND} )"

distutils_enable_tests pytest

python_test() {
	local -x DBUS_SESSION_BUS_ADDRESS="unix:path=/nonexistent"
	local -x QT_QPA_PLATFORM=offscreen
	local -x HOME="${T}"
	epytest
}

src_install() {
	distutils-r1_src_install

	newicon -s 256 gabbee.png gabbee.png
	if use ibus; then
		insinto /usr/share/ibus/component
		doins share/ibus/component/gabbee.xml
	fi
	domenu share/applications/gabbee-bar.desktop

	if use qindaqt; then
		insinto /usr/share/dbus-1/services
		doins share/dbus-1/services/org.qindaqt.Voice1.service

		# AGENT-CONTRACT: install recovery as a desktop facility for every user,
		# rather than relying on one account's ~/.config setup script. The timer
		# is statically enabled; the watchdog itself proves a physical QindaQt
		# session before it activates or restarts anything.
		insinto /usr/lib/systemd/user
		doins "${FILESDIR}"/gabbee-voice-watchdog.service
		doins share/systemd/user/gabbee-voice-watchdog.timer
		dodir /usr/lib/systemd/user/timers.target.wants
		dosym ../gabbee-voice-watchdog.timer \
			/usr/lib/systemd/user/timers.target.wants/gabbee-voice-watchdog.timer

		local unit
		for unit in qindaqt-audio-service.service qindaqt-clipboard-host.service \
			qindaqt-display-service.service qindaqt-network-service.service \
			qindaqt-bluetooth-service.service qindaqt-power-service.service \
			xdg-desktop-portal-qindaqt.service; do
			insinto "/usr/lib/systemd/user/${unit}.d"
			newins share/systemd/user/desktop-recovery.conf 90-gabbee-recovery.conf
		done
		for unit in xdg-desktop-portal.service plasma-xdg-desktop-portal-kde.service; do
			insinto "/usr/lib/systemd/user/${unit}.d"
			doins "share/systemd/user/${unit}.d/90-gabbee-physical-session.conf"
		done
	fi

	dodoc README.md HANDOFF.md docs/recovery-operations.md
}

pkg_postinst() {
	xdg_pkg_postinst
	if use qindaqt; then
		elog "The bounded QindaQt recovery timer is installed for every user."
		elog "It monitors Voice1, Audio1, Clipboard1, Display1, Network1, Bluetooth1,"
		elog "Power1, Settings1 and portals with bounded recovery and incident reports."
	fi
	if use ibus; then
		elog "Run 'gabbee-install-ibus --setup' once to register the IBus engine."
	fi
}
