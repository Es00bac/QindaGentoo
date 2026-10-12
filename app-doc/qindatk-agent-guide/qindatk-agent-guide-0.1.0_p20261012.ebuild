# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Offline interactive guide to QindaTK and QindaOffice agent interfaces"
HOMEPAGE="https://github.com/Es00bac/QindaTK-agent-guide"
QINDATK_GUIDE_COMMIT="3d515432d65fedffe8ce047c455e4316c092063b"
SRC_URI="https://github.com/Es00bac/QindaTK-agent-guide/archive/${QINDATK_GUIDE_COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/QindaTK-agent-guide-${QINDATK_GUIDE_COMMIT}"

# dist/sources.md grants LGPL-3+ for code/text and GPL-3+ for reused media.
LICENSE="LGPL-3+ GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
BDEPEND="test? ( net-libs/nodejs media-video/ffmpeg )"

src_compile() { :; }

src_test() {
	# Static references, local teaching simulations and existing media only.
	# Do not invoke the narration generator or publishing scripts.
	node scripts/check.mjs || die
}

src_install() {
	# AGENT-GUARD: no server/service or Sites configuration belongs in the
	# package. The guide's simulation cannot control live applications.
	insinto "/usr/share/doc/${PF}/html"
	doins -r dist/.
	docompress -x "/usr/share/doc/${PF}/html"
	dodoc README.md
	newdoc "${FILESDIR}/README.gentoo.md" README.gentoo.md
}
