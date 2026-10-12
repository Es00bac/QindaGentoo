# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
inherit python-single-r1 wrapper

DESCRIPTION="Optional Firefox and QindaFox native messaging bridge for local agents"
HOMEPAGE="https://github.com/Es00bac/QindaFoxAgent"
QINDAFOX_AGENT_COMMIT="9316a5aecf0eb75105cece809eb372eea27a859e"
SRC_URI="https://github.com/Es00bac/QindaFoxAgent/archive/${QINDAFOX_AGENT_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/QindaFoxAgent-${QINDAFOX_AGENT_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="launcher test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"
RDEPEND="
	${PYTHON_DEPS}
	net-misc/openssh
	|| ( >=www-client/qindafox-bin-142 >=www-client/firefox-142 >=www-client/firefox-bin-142 )
	launcher? ( net-misc/geckodriver )
"
BDEPEND="${PYTHON_DEPS}"

PATCHES=( "${FILESDIR}/${PN}-0.1.0-installed-remote.patch" )

src_prepare() {
	default
	# AGENT-CONTRACT: Portage owns software; the upstream per-user installer
	# must not replace packaged wrappers or mutate browser/Codex preferences.
	local plugin=plugins/qindafox-browser
	sed -i "s|~/.local/bin/|${EPREFIX}/usr/bin/|g" \
		"${plugin}/skills/qindafox-browser/SKILL.md" \
		"${plugin}/skills/qindafox-browser/references/operations.md" || die
	cp "${FILESDIR}/setup.md" "${plugin}/skills/qindafox-browser/references/setup.md" || die
	"${EPYTHON}" -c 'import json,sys; json.dump({"mcpServers":{"qindafox-browser":{"command":sys.argv[1],"args":[]}}},open(sys.argv[2],"w"),indent=2)' \
		"${EPREFIX}/usr/bin/qindafox-agent-mcp" "${plugin}/.mcp.json" || die
}

src_compile() {
	local plugin=plugins/qindafox-browser
	mkdir -p "${plugin}/dist" || die
	cd "${plugin}/extension" || die
	"${EPYTHON}" -m zipfile -c "../dist/qindafox-agent.xpi" \
		background.js content.js manifest.json || die
}

src_test() {
	# Only framing/payload/MCP fixtures: never a live browser or Jev request.
	"${EPYTHON}" -m unittest discover -s tests -p test_protocol.py -v || die
}

src_install() {
	local plugin=plugins/qindafox-browser
	insinto "/usr/share/${PN}"
	doins -r "${plugin}"/{.codex-plugin,.mcp.json,extension,skills,dist}
	insinto "/usr/share/${PN}/scripts"
	doins "${plugin}/scripts/"{browser,launch,native_host,jev_remote}.py

	local target="${EPREFIX}/usr/share/${PN}/scripts"
	make_wrapper qindafox-agent "${EPYTHON} \"${target}/browser.py\""
	make_wrapper qindafox-agent-mcp "${EPYTHON} \"${target}/browser.py\" mcp"
	make_wrapper qindafox-agent-host "${EPYTHON} \"${target}/native_host.py\""
	make_wrapper qindafox-agent-jev "${EPYTHON} \"${target}/jev_remote.py\""
	if use launcher; then
		make_wrapper qindafox-agent-launch "${EPYTHON} \"${target}/launch.py\""
	fi

	"${EPYTHON}" -c 'import json,sys; json.dump({"name":"org.qindafox.agent","description":"Local QindaFox Agent bridge","path":sys.argv[1],"type":"stdio","allowed_extensions":["agent@qindafox.local"]},open(sys.argv[2],"w"),indent=2)' \
		"${EPREFIX}/usr/bin/qindafox-agent-host" "${T}/org.qindafox.agent.json" || die
	# Gentoo Firefox uses libdir; prebuilt Firefox/QindaFox uses /usr/lib.
	local libdir
	for libdir in lib $(get_libdir); do
		insinto "/usr/${libdir}/mozilla/native-messaging-hosts"
		doins "${T}/org.qindafox.agent.json"
	done
	dodoc README.md LICENSE docs/validation.md
	newdoc "${FILESDIR}/setup.md" README.gentoo.md
}

pkg_postinst() {
	elog "Read /usr/share/doc/${PF}/README.gentoo.md before enabling the extension."
	elog "The unsigned extension and Codex skill are available under /usr/share/${PN}."
	elog "Browser profiles, MCP/skill registration, and credentials remain user-owned."
}
