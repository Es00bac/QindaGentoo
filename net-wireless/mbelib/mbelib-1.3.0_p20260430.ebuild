# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="0cf0604433d1409576073d0656926a13287d0de5"

DESCRIPTION="P25 Phase 1 and ProVoice vocoder library (SDRangel fork, shared-library branch)"
HOMEPAGE="https://github.com/srcejon/mbelib"
SRC_URI="https://github.com/srcejon/mbelib/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

# The sources carry an ISC-style permission notice; there is no LICENSE file.
LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
