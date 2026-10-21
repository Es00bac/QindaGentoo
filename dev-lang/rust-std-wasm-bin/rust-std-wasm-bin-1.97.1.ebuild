# Copyright 2026 Sloom Software LLC
# Distributed under the terms of the GNU General Public License v2
EAPI=8
DESCRIPTION="Rust standard library for the wasm32-unknown-unknown target"
HOMEPAGE="https://www.rust-lang.org/"
SRC_URI="https://static.rust-lang.org/dist/2026-07-16/rust-std-${PV}-wasm32-unknown-unknown.tar.xz"
S="${WORKDIR}/rust-std-${PV}-wasm32-unknown-unknown"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="~amd64"
RDEPEND="=dev-lang/rust-bin-${PV}"
RESTRICT="strip"
QA_PREBUILT="opt/rust-bin-${PV}/lib/rustlib/wasm32-unknown-unknown/lib/.*"
src_install() {
 insinto "/opt/rust-bin-${PV}/lib/rustlib"
 doins -r rust-std-wasm32-unknown-unknown/lib/rustlib/wasm32-unknown-unknown
 dodoc COPYRIGHT LICENSE-APACHE LICENSE-MIT
}
