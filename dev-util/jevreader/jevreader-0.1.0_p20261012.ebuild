# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
inherit python-single-r1 wrapper

DESCRIPTION="Optional selective source reader and stdio MCP companion for coding agents"
HOMEPAGE="https://github.com/Es00bac/JevReader"
JEVREADER_COMMIT="843cae73e43a31d084edc809d9c67ae58ddf358c"
SRC_URI="https://github.com/Es00bac/JevReader/archive/${JEVREADER_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/JevReader-${JEVREADER_COMMIT}"

# The source modules and tests carry GPL-3.0-or-later SPDX declarations.
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"
RDEPEND="${PYTHON_DEPS} net-misc/openssh"
BDEPEND="${PYTHON_DEPS}"

src_compile() { :; }

src_test() {
	# AGENT-GUARD: the deterministic word-overlap fixture never calls a model
	# or uses credentials; do not remove FAKE when expanding package checks.
	JEV_READER_FAKE=1 "${EPYTHON}" -m unittest discover -s tests -v || die
}

src_install() {
	python_domodule jevreader
	make_wrapper jevreader "${EPYTHON} -m jevreader"
	make_wrapper jevreader-mcp "${EPYTHON} -m jevreader.mcp_server"
	dodoc README.md
	newdoc "${FILESDIR}/README.gentoo.md" README.gentoo.md
}

pkg_postinst() {
	elog "Use jevreader outline for local reading without a model."
	elog "Register /usr/bin/jevreader-mcp explicitly in your agent's configuration."
	elog "No agent configuration, credential, model or service is installed."
}
