# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

DESCRIPTION="QindaQt Office: documents, sheets, slides, notes, mail, books, databases, plans"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
SRC_URI="${PF}.tar.xz"
S="${WORKDIR}/${PF}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+charts +libreoffice"

# The QindaOffice repository is not published yet, so this is a local,
# immutable snapshot rather than a download. The operator produces the
# archive from the exact reviewed commit with the tree's own script:
#
#     tools/make-dist.sh 0.1.0_p20260925 /var/cache/distfiles
#
# That script refuses to run on a dirty tree and vendors the QXlsx
# submodule INTO the tarball, which is what makes the build work under
# FEATURES=network-sandbox: src_unpack fetches nothing. The archive also
# carries a .dist-commit file naming the commit it was cut from.
#
# The archive is named after PF, not P: a re-cut on the same day is a new
# revision with DIFFERENT contents, and ${P}.tar.xz would hand two of them
# the same distfile name and the same Manifest line.
RESTRICT="fetch"

# gui-wm/qindaqt-desktop owns the QindaQt global-menu static archives, the
# design-token and theme libraries and their headers, which office_quick
# links (no CMake package configs are installed for them, hence the
# find_library use in CMakeLists.txt). dev-libs/qindatk is the toolkit the
# whole suite's UI is built from (M31, D-031) and dev-qt/qtdeclarative the
# QtQuick it needs.
#
# qtbase[widgets] stays: nothing in the suite is a QWidget any more, but
# QtPrintSupport links QtWidgets and the suite prints through QPrinter.
#
# USE=charts drives QQO_WITH_CHARTS, QindaCalc's chart feature. The
# charts are drawn by the suite's own ChartItem (D-036), so the flag no
# longer pulls dev-qt/qtcharts. Qt Svg is required: the suite ships its
# icons as scalable SVG only.
#
# 0.1.0_p20260925 (M40-M51) adds QindaMail, QindaBooks, QindaBase, QindaDiagram
# and QindaPlan and moves every app to the QindaTK ribbon:
#   - dev-libs/qindatk-0.1.0-r7: Ribbon v2, the mail/calendar providers
#     (POP3, IMAP folders, CalDAV discovery, iCalendar feeds), the calendar
#     grid and the icons the new apps use;
#   - qtbase[sql,sqlite]: QindaBooks keeps its company file in SQLite
#     through QtSql; the QSQLITE driver is loaded at RUN time, so a Qt
#     without it builds, links and then fails on the first open;
#   - dev-db/sqlite: QindaBase talks to SQLite directly and needs the
#     session extension and column metadata; Gentoo's sqlite always builds
#     both (--enable-session, SQLITE_ENABLE_COLUMN_METADATA), and configure
#     fails with a clear message on a SQLite without them;
#   - qtbase[ssl]: mail, calendar, Mercury and Stripe talk TLS only (D-043,
#     D-048); dev-libs/qtkeychain holds every token and password (D-052),
#     through libsecret or KWallet;
#   - qtbase[concurrent]: QindaCalc loads workbooks on a worker thread.
# 0.1.0_p20260926 (QindaOffice d0a0b2c, D-053): recovered documents no
# longer re-journal under a fresh key (QindaWrite reopened every discarded
# untitled document, more each launch); QindaNote types dark ink on paper
# on dark themes and takes touch — one finger inks, two fingers zoom and
# pan — which needs dev-libs/qindatk-0.1.0-r8 (D-304).
RDEPEND="
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-libs/qindatk-0.1.0-r8
	>=dev-qt/qtbase-6.11:6=[concurrent,dbus,gui,network,sql,sqlite,ssl,widgets]
	>=dev-qt/qtdeclarative-6.11:6=
	>=dev-qt/qtsvg-6.11:6=
	>=kde-frameworks/karchive-6.0:6=
	>=kde-frameworks/sonnet-6.0:6=
	dev-libs/qtkeychain:=
	>=dev-db/sqlite-3.50:3
	app-text/poppler[qt6]
	libreoffice? ( app-office/libreoffice )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

pkg_nofetch() {
	einfo "QindaOffice is not published to a remote yet. Produce the archive"
	einfo "from the reviewed commit in a QindaOffice checkout:"
	einfo ""
	einfo "    tools/make-dist.sh ${PVR} \"${DISTDIR}\""
	einfo ""
	einfo "then re-run emerge. The script vendors third_party/QXlsx into the"
	einfo "tarball so the build needs no network."
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DQQO_WITH_CHARTS=$(usex charts ON OFF)
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "Access .mdb/.accdb import in QindaBase" app-office/mdbtools
}
