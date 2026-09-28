# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit cmake python-single-r1 xdg git-r3

DESCRIPTION="QindaPortage - see, plan and repair Portage with a local LLM (QindaTK)"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# The hub on qinda is read first; the laptop keeps a bare mirror at the same
# path, fast-forwarded from qinda before an emerge.
EGIT_REPO_URI="file:///home/cabewse/git/LocalAiPortage.git
	file:///home/cabewse/work_SPaC3/LocalAiPortage
	file:///home/cabewse/LocalAiPortage"
# AGENT-NOTE: pin the reviewed commit here and bump the revision with it;
# an unpinned git-r3 ebuild builds whatever the hub holds.
# 7a353cd1: first release; 17 test suites; assistant verified end to end with
# qportage-ask on the local Qwen3.5-4B and on qinda's tier.
# r1 (c576c7e4): approving in the chat or with the dock's Apply button runs
# the plan; the helper's snapshot works when started outside / (found on
# the first live root run; apply + revert verified as root).
# r2 (7ee4285c): the assistant acts: apply_plan (re-preview, risk rules, act
# switch), revert_transaction, list_transactions, read_news; USE
# wheel-nopasswd installs a polkit rule so wheel applies without a prompt.
# r3 (eb75853c): root helper sessions (one pkexec, kept until idle, default
# 15 min); Settings dialog.
# r4 (835f6046): the assistant applies its verified plans itself (verified live:
# apply + revert of its own transaction through pkexec).
EGIT_COMMIT="835f6046e6293261666d24b4865fea810bedab35"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test wheel-nopasswd"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

# gui-wm/qindaqt-desktop owns the AppShell and global-menu archives this app
# links (find_library in CMakeLists.txt); dev-libs/qindatk is a runtime QML
# import. The helper (python, stdlib only) runs as root through pkexec and
# snapshots state with git. The 4B model comes with sci-ml/qinda-notes-llm;
# the optional 9B planner (packaging/gentoo/sci-ml/qindaportage-models in the
# source tree) joins the overlay once its 6 GB distfile is in the Manifest.
RDEPEND="
	${PYTHON_DEPS}
	>=gui-wm/qindaqt-desktop-0.1.0_pre20260907-r1
	>=dev-qt/qtbase-6.11:6=[concurrent,dbus,gui,network,wayland]
	>=dev-qt/qtdeclarative-6.11:6=
	>=dev-libs/qindatk-0.1.0-r12
	dev-vcs/git
	sci-misc/llama-cpp[vulkan]
	sci-ml/qinda-notes-llm
	sys-apps/portage
	sys-auth/polkit
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DQINDAPORTAGE_POLKIT_WHEEL_NOPASSWD=$(usex wheel-nopasswd)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	python_fix_shebang "${ED}"/usr/libexec/qindaportage/qindaportage-apply
	keepdir /var/lib/qindaportage/journal
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Changes are applied by /usr/libexec/qindaportage/qindaportage-apply through"
	elog "pkexec (polkit action org.qindaqt.portage.apply). Transactions and"
	elog "snapshots live in /var/lib/qindaportage; software installed from URLs is"
	elog "packaged in the qinda-local overlay (/var/db/repos/qinda-local)."
}
