# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

ZOO_COMMIT="47534e27c9851bb1128ccc0102f1145e27f23f98"
MODEL="face_detection_yunet_2023mar.onnx"
ZOO="https://media.githubusercontent.com/media/opencv/opencv_zoo/${ZOO_COMMIT}/models/face_detection_yunet"
RAW="https://raw.githubusercontent.com/opencv/opencv_zoo/${ZOO_COMMIT}/models/face_detection_yunet"
DESCRIPTION="Pinned MIT YuNet five-landmark CPU face detector and optional NASA test data"
HOMEPAGE="https://github.com/opencv/opencv_zoo/tree/main/models/face_detection_yunet"
SRC_URI="
	${ZOO}/${MODEL} -> ${PN}-${ZOO_COMMIT}-${MODEL}
	${RAW}/LICENSE -> ${PN}-${ZOO_COMMIT}-LICENSE
	test-fixtures? (
		https://images-assets.nasa.gov/image/KSC-99pp0310/KSC-99pp0310~small.jpg -> ${PN}-${PV}-portrait.jpg
		https://images-assets.nasa.gov/image/KSC-04pd1239/KSC-04pd1239~small.jpg -> ${PN}-${PV}-crew.jpg
	)
"
S="${WORKDIR}"
LICENSE="MIT test-fixtures? ( public-domain )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test-fixtures"
RESTRICT="strip"

src_unpack() { :; }

src_install() {
	insinto /usr/share/opencv-face-liquify
	newins "${DISTDIR}/${PN}-${ZOO_COMMIT}-${MODEL}" "${MODEL}"
	newins "${DISTDIR}/${PN}-${ZOO_COMMIT}-LICENSE" MODEL-LICENSE
	dodoc "${FILESDIR}/PROVENANCE.md"
	if use test-fixtures; then
		insinto /usr/share/opencv-face-liquify/tests
		newins "${DISTDIR}/${PN}-${PV}-portrait.jpg" portrait.jpg
		newins "${DISTDIR}/${PN}-${PV}-crew.jpg" crew.jpg
		newins "${FILESDIR}/PROVENANCE.md" PROVENANCE.md
	fi
}
