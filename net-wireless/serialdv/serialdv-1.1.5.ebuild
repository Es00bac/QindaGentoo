# Copyright 2026 Sloom Software
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="217f322b8c51a0182a2bd83d27f4b1c913cfff26"

DESCRIPTION="Library to interface AMBE3000 based serial hardware for digital voice"
HOMEPAGE="https://github.com/f4exb/serialDV"
SRC_URI="https://github.com/f4exb/serialDV/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/serialDV-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
