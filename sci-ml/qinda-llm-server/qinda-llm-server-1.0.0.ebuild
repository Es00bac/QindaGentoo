# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit git-r3 python-single-r1 systemd

# AGENT-NOTE: qinda's local coding-model service (source: QindaLLM). The
# llama.cpp runtime comes from ::guru (sci-misc/llama-cpp, Vulkan backend for
# the RX 5700 XT) and the weights from sci-ml/gguf-coding-models. The API key
# is a per-host secret, so pkg_postinst generates it and Portage does not own
# it. qinda only: not in metadata/qinda-delivery.

DESCRIPTION="LLM Server mode for QindaQt: llama.cpp router service and qinda-llm-top console"
HOMEPAGE="https://github.com/Es00bac/QindaGentoo"
# AGENT-CONTRACT: build this exact commit of qinda's QindaLLM hub.
EGIT_REPO_URI="file:///home/cabewse/git/QindaLLM.git"
EGIT_COMMIT="0f38b9153c1bb87057c556b3ea5fec8df3add168"

# No license grant has been made for this source yet; the owner chooses one.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="bindist mirror"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_impl_dep 'ncurses')
	media-fonts/terminus-font[psf]
	sci-misc/llama-cpp[vulkan]
	sci-ml/gguf-coding-models
	sys-apps/kbd
"

src_compile() {
	:
}

src_test() {
	emake test
}

src_install() {
	emake DESTDIR="${D}" UNITDIR="$(systemd_get_systemunitdir)" install
	python_fix_shebang "${ED}"/usr/bin/qinda-llm-top
	einstalldocs
}

pkg_postinst() {
	local key="${EROOT}"/etc/qinda-llm/api-key
	if [[ ! -e ${key} ]]; then
		( umask 077 && od -An -tx1 -N32 /dev/urandom | tr -d ' \n' > "${key}" ) \
			|| die "could not create ${key}"
		elog "Generated the API key clients must send: ${key}"
	fi
	elog "Set QINDA_LLM_HOST in /etc/qinda-llm/server.env (127.0.0.1 by default)."
	elog "LLM Server mode: the boot menu's \"LLM Server\" row (sys-boot/qinda-boot),"
	elog "or 'systemctl isolate qinda-llm-server.target'. Alongside the desktop:"
	elog "'systemctl start qinda-llm.service'. Watch it with 'qinda-llm-top'."
	if [[ -x ${EROOT}/usr/sbin/qinda-boot-sync ]] && [[ -z ${ROOT} ]]; then
		qinda-boot-sync --quiet 2>/dev/null || true
	fi
}
