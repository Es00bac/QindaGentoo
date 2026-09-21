# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

# AGENT-NOTE: same shape as app-misc/venusprolinux. Upstream is published
# (HOMEPAGE), but the overlay's rule is that a pin stays local until a revision
# has actually been built from a GitHub archive URL and its Manifest verified
# on both machines; this is the first revision, so it has not. The bare
# repository on qinda comes first, then either machine's working tree, and
# git-r3 takes the first URI that exists.
inherit distutils-r1 xdg git-r3

DESCRIPTION="Push-to-talk dictation and desktop control, and QindaQt's org.qindaqt.Voice1 provider"
HOMEPAGE="https://github.com/Es00bac/gabbee"
EGIT_REPO_URI="file:///home/cabewse/git/gabbee.git
	file:///home/cabewse/gabbee
	file:///home/cabewse/work_space/gabbee"
# AGENT-NOTE: an immutable pin, not a branch — a package built twice must be
# the same package. Bump it together with the version.
EGIT_COMMIT="f2eefbea5f9c27595b210b59c71e5141b0b8a2d2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
# AGENT-NOTE: distutils_enable_tests adds IUSE=test, the pytest BDEPEND and
# the RESTRICT guard, so none of those are repeated here.
IUSE="+qindaqt +ibus sound"

# The bar is a Qt application that owns two D-Bus names, streams over a
# WebSocket, reads credentials from the Secret Service, and speaks to IBus and
# AT-SPI through GObject introspection. dbus-python and pygobject are runtime
# imports of src/gabbee/ui/global_shortcuts.py and src/gabbee/ibus_engine.py;
# they are deliberately not in pyproject.toml, because pip would then try to
# build pygobject inside a virtualenv instead of using the system typelib.
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
	sound? ( media-libs/libcanberra )
"
# The suite imports the whole package, so it needs the runtime set, not just
# a test runner.
BDEPEND="test? ( ${RDEPEND} )"

# A desktop that consumes org.qindaqt.Voice1 wants this package's activation
# file; this dependency is the other direction, and deliberately absent. The
# desktop must stay installable with no voice provider at all.

distutils_enable_tests pytest

python_test() {
	# AGENT-NOTE: tests/test_config.py reaches for the Secret Service over the
	# session bus. In a sandbox nothing is listening and the call blocks
	# indefinitely rather than failing, so the address is pointed at nothing:
	# the code path then takes its documented "no keyring" branch.
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

	if use qindaqt; then
		# D-Bus activation for QindaQt's voice contract. The panel applet asks
		# for this name the first time it is composed, which is what lets voice
		# work in a fresh session without an autostart race.
		insinto /usr/share/dbus-1/services
		doins share/dbus-1/services/org.qindaqt.Voice1.service
	fi

	dodoc README.md HANDOFF.md
}

pkg_postinst() {
	xdg_pkg_postinst
	if use qindaqt; then
		elog "QindaQt's Voice applet, its Settings Voice route and qindaqt-voice"
		elog "reach this package through org.qindaqt.Voice1. Turn voice input on"
		elog "in Settings > Voice; the provider is started on demand."
	fi
	if use ibus; then
		elog
		elog "Run 'gabbee-install-ibus --setup' once, in your own desktop session,"
		elog "to register the IBus engine and choose the dictation shortcuts. It is"
		elog "an interactive wizard and it rewrites your global shortcut file."
	fi
	elog
	elog "Insertion into an unfocusable or inaccessible surface falls back to"
	elog "'dotool', which is not in the Gentoo tree. The three routes ahead of it"
	elog "(input method, accessibility, clipboard paste) cover ordinary windows."
}
