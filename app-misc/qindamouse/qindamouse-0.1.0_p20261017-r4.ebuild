# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
inherit desktop git-r3 python-single-r1 systemd udev xdg

DESCRIPTION="Gaming mouse configuration and optional host bindings with QindaTK"
HOMEPAGE="https://github.com/Es00bac"
EGIT_REPO_URI="file:///home/cabewse/git/QindaMouse.git
	file:///home/cabewse/work_SPaC3/QindaMouse
	file:///home/cabewse/work_space/QindaMouse"
EGIT_BRANCH="fix/hotplug-basilisk-20261018"
# Immutable source-verified Basilisk V3 and shared connection recovery snapshot.
EGIT_COMMIT="a183188157d8325ca465e4b452e89780a80c8782"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui input-service test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	virtual/udev
	input-service? ( sys-apps/kmod )
	gui? (
		$(python_gen_cond_dep 'dev-python/pyqt6[dbus,gui,qml,quick,svg,widgets,${PYTHON_USEDEP}]')
		>=dev-libs/qindatk-0.1.0
	)
"
BDEPEND="test? ( ${RDEPEND} )"

src_test() {
	local -x QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software
	local -x XDG_CONFIG_HOME="${T}/config" XDG_DATA_HOME="${T}/data"
	local suites=( tests.test_core tests.test_hidraw tests.test_udev
		tests.test_art tests.test_input_service tests.test_reference_trace tests.test_usbstrings
		tests.test_driver_areson tests.test_driver_areson_oem tests.test_driver_asus_rog
		tests.test_driver_beken tests.test_driver_compx tests.test_driver_corsair
		tests.test_driver_holtek tests.test_driver_holtek_redragon
		tests.test_driver_logitech tests.test_driver_razer tests.test_driver_razer_basilisk
		tests.test_driver_sinowealth tests.test_channel tests.test_discovery
		tests.test_registry_transport_pending )
	use gui && suites+=( tests.test_ui tests.test_ui_software )
	"${EPYTHON}" -m unittest -q "${suites[@]}" || die "offline checks failed"
}

src_install() {
	local path launcher
	# Include Python modules, device JSON, SVG art and all QML. Tests can leave
	# bytecode caches in the source; only Portage's selected Python creates these.
	while IFS= read -r -d '' path; do
		insinto "/usr/share/${PN}/$(dirname "${path}")"
		doins "${path}"
	done < <(find qindamouse -type d -name __pycache__ -prune -o -type f -print0)
	# The Areson and original Holtek adapters still share these legacy codecs.
	insinto "/usr/share/${PN}"
	doins venus_protocol.py holtek_protocol.py venus_keys.py \
		venus_qml_models.py venus_qml_globalmenu.py
	python_optimize "${ED}/usr/share/${PN}"
	for launcher in qindamouse-cli; do
		sed "s|@PYTHON@|${EPYTHON}|g" "packaging/linux/${launcher}" > "${T}/${launcher}" || die
		dobin "${T}/${launcher}"
	done
	if use gui; then
		sed "s|@PYTHON@|${EPYTHON}|g" packaging/linux/qindamouse > "${T}/qindamouse" || die
		dobin "${T}/qindamouse"
		newmenu packaging/linux/org.qinda.QindaMouse.desktop io.github.qindamouse.desktop
	fi
	udev_dorules packaging/linux/70-qindamouse.rules
	if use input-service; then
		sed "s|@PYTHON@|${EPYTHON}|g" packaging/linux/qindamouse-service \
			> "${T}/qindamouse-service" || die
		dobin "${T}/qindamouse-service"
		systemd_douserunit packaging/linux/qindamouse-service.service
		udev_dorules packaging/linux/70-qindamouse-input.rules
		insinto /usr/lib/modules-load.d
		newins packaging/linux/qindamouse-modules.conf qindamouse.conf
	fi
	dodoc README.md docs/INPUT_SERVICE.md docs/VERIFICATION.md docs/ART.md docs/ART_MODELS.md \
		docs/USB_CONNECTIONS.md
	docinto protocols
	dodoc docs/protocols/razer.md docs/protocols/razer-basilisk-v3.md
	docinto verification
	dodoc docs/verification/basilisk-v3-source.json docs/verification/razer-collections-20261018.json
}

pkg_postinst() {
	xdg_pkg_postinst
	udev_reload
	# EAPI 7+ uses an empty EROOT for the live system.
	if [[ -z ${EROOT%/} ]]; then
		local -a access_args=()
		if use input-service; then
			modprobe uinput || ewarn "The running kernel could not load uinput."
			access_args+=( --input-service )
		fi
		PYTHONPATH="${EROOT}/usr/share/${PN}" "${EPYTHON}" -m qindamouse.usb_access \
			"${access_args[@]}" || ewarn "Could not refresh all attached-device access rules."
	fi
	if use input-service; then
		elog "Enable host bindings in your graphical session with:"
		elog "systemctl --user enable --now qindamouse-service.service"
	fi
}

pkg_postrm() {
	xdg_pkg_postrm
	udev_reload
}
