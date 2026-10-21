# Copyright 2026 Sloom Software LLC
# Distributed under the terms of the GNU General Public License v2
EAPI=8
DESCRIPTION="WebAssembly bindings generator, official upstream binary"
HOMEPAGE="https://github.com/wasm-bindgen/wasm-bindgen"
SRC_URI="https://github.com/wasm-bindgen/wasm-bindgen/releases/download/${PV}/wasm-bindgen-${PV}-x86_64-unknown-linux-musl.tar.gz"
S="${WORKDIR}/wasm-bindgen-${PV}-x86_64-unknown-linux-musl"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"
QA_PREBUILT="usr/bin/wasm-bindgen.*"
src_install() {
 dobin wasm-bindgen wasm-bindgen-test-runner
 dodoc LICENSE-APACHE LICENSE-MIT
}
