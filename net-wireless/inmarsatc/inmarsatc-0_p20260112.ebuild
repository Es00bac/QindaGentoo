# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="a8e5797c09b992499f9968effe1ca0d9ce5db566"

DESCRIPTION="Inmarsat-C STD-C demodulator, decoder and parser library for SDRangel"
HOMEPAGE="https://github.com/srcejon/inmarsatc"
SRC_URI="https://github.com/srcejon/inmarsatc/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-libs/boost:="
DEPEND="${RDEPEND}"
