# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for a freedesktop.org Secret Service API provider"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~loong ~mips ppc ppc64 ~riscv ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"

IUSE="qindaqt"

# AGENT-CONTRACT: native Desktop-r2 exports the standard Secret Service API;
# generic stock provider choices remain available outside native profile mode.
RDEPEND="
	qindaqt? ( >=gui-wm/qindaqt-desktop-0.1.0_pre20261002-r2 )
	!qindaqt? (
		|| (
			gnome-base/gnome-keyring
			>=kde-frameworks/kwallet-runtime-6.18.0[keyring]
			app-admin/keepassxc
		)
	)
"
