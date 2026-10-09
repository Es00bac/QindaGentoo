# Copyright 2026 QindaPhotoCraft contributors
# SPDX-License-Identifier: GPL-2.0-only
EAPI=8

inherit cmake xdg

DESCRIPTION="Native QindaTK image editing powered by the PhotoCraft Rust engine"
HOMEPAGE="https://github.com/storytold/photocraft"
SRC_URI="${PF}.tar.gz"
S="${WORKDIR}/${PF}"
LICENSE="MIT Apache-2.0 BSD-2 BSD IJG Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="fetch !test? ( test )"

RDEPEND="
    >=dev-libs/qindatk-0.1.0
    >=dev-libs/qindatk-raster-0.1.0
    >=dev-qt/qtbase-6.8:6[gui]
    >=dev-qt/qtdeclarative-6.8:6
    >=dev-qt/qtsvg-6.8:6
"
DEPEND="${RDEPEND}"
BDEPEND="
    || ( >=dev-lang/rust-bin-1.95 >=dev-lang/rust-1.95 )
    app-alternatives/ninja
    virtual/pkgconfig
    test? ( >=dev-lang/python-3.11 )
"

pkg_nofetch() {
    einfo "Create the locked source archive from the QindaPhotocraft checkout:"
    einfo "python3 tools/make-dist.py ${PVR} /var/cache/distfiles"
    einfo "Publish the matching Manifest and archive through qinda-sync."
}

src_configure() {
    local mycmakeargs=(
        -DBUILD_TESTING=$(usex test)
        -DPHOTOCRAFT_ENGINE_BINARY="${BUILD_DIR}/cargo/desktop/qindaphotocraft-engine"
    )
    cmake_src_configure
}

src_compile() {
    # Crates are locked and vendored in the immutable distribution archive.
    # Cargo and CMake keep host parallelism; no builds run on qinda here.
    CARGO_NET_OFFLINE=true CARGO_HOME="${T}/cargo-home" cargo build --offline --frozen \
        --profile desktop --manifest-path native/engine/Cargo.toml \
        --target-dir "${BUILD_DIR}/cargo" || die "Rust engine build failed"
    cmake_src_compile
}

src_test() {
    QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software cmake_src_test
}

src_install() {
    cmake_src_install
    dodoc README.md THIRD_PARTY_NOTICES.json
    docinto licenses
    dodoc LICENSE third_party/photocraft/{LICENSE-APACHE,LICENSE-MIT,NOTICE,ATTRIBUTION.md}
    local crate file
    for crate in native/engine/vendor/*; do
        docinto "licenses/$(basename "${crate}")"
        for file in "${crate}"/{LICENSE*,COPYING*,NOTICE*}; do
            [[ -f ${file} ]] && dodoc "${file}"
        done
    done
}
