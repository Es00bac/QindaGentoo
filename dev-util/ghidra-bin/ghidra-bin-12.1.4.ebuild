# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GHIDRA_DATE="20260921"

DESCRIPTION="NSA software reverse engineering framework (official release build)"
HOMEPAGE="https://ghidra-sre.org https://github.com/NationalSecurityAgency/ghidra"
SRC_URI="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${PV}_build/ghidra_${PV}_PUBLIC_${GHIDRA_DATE}.zip"
S="${WORKDIR}/ghidra_${PV}_PUBLIC"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND=">=virtual/jdk-21:*"
BDEPEND="app-arch/unzip"

QA_PREBUILT="opt/ghidra/*"

src_prepare() {
	default
	# Native helpers for other platforms are dead weight and trip QA.
	find . -type d -path '*/os/*' \
		\( -name 'win_*' -o -name 'mac_*' -o -name 'linux_arm_64' \) \
		-prune -exec rm -r {} + || die
}

src_install() {
	insinto /opt/ghidra
	doins -r .
	# doins drops the mode bits the release archive carries.
	local f
	while IFS= read -r -d '' f; do
		fperms 0755 "/opt/ghidra/${f#./}"
	done < <(find . -type f \( -name '*.sh' -o -perm -u+x -o -path '*/os/linux_x86_64/*' \
		-o -name ghidraRun -o -name analyzeHeadless -o -name launch.sh \
		-o -name pyghidraRun -o -name svrAdmin -o -name svrInstall -o -name svrUninstall \
		-o -name ghidraSvr -o -name ghidraDebug -o -name bsim -o -name bsim_ctl \) -print0)
	dosym ../../opt/ghidra/ghidraRun /usr/bin/ghidra
	dosym ../../opt/ghidra/support/analyzeHeadless /usr/bin/ghidra-analyzeHeadless
}

pkg_postinst() {
	elog "Ghidra is installed in ${EROOT}/opt/ghidra; set GHIDRA_INSTALL_DIR to that path"
	elog "for tools such as REA that drive it headlessly."
}
