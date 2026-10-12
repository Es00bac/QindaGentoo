# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit python-single-r1 systemd

# AGENT-NOTE: qinda's local coding-model service (source: QindaLLM). The
# llama.cpp runtime comes from ::guru (sci-misc/llama-cpp, Vulkan backend for
# the RX 5700 XT) and the weights from sci-ml/gguf-coding-models. The API key
# is a per-host secret, so pkg_postinst generates it and Portage does not own
# it. qinda only: not in metadata/qinda-delivery.

DESCRIPTION="LLM Server mode for QindaQt: llama.cpp router service and qinda-llm-top console"
HOMEPAGE="https://github.com/Es00bac/QindaLLM"
# r1 (977f93f): ubatch-size 512 in models.ini; 2048-token micro-batches ran
# past amdgpu's 10 s compute timeout at ~90k context (vk::DeviceLostError).
# AGENT-CONTRACT: this license-only source successor retains runtime bytes.
QINDA_LLM_COMMIT="91a294cd967f0331bbef13f95b74920a27cd2d7e"
SRC_URI="${PF}.tar.gz"
S="${WORKDIR}/QindaLLM-${QINDA_LLM_COMMIT}"

# Original service/configuration code only; external model/runtime licenses remain separate.
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="fetch"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_impl_dep 'ncurses')
	media-fonts/terminus-font[psf]
	sci-misc/llama-cpp[vulkan]
	sci-ml/gguf-coding-models[ornith-1-5-35b-a3b]
	sys-apps/kbd
"

pkg_nofetch() {
	einfo "Create the exact source-only archive from the QindaLLM Git hub:"
	einfo "git archive --format=tar --prefix=QindaLLM-${QINDA_LLM_COMMIT}/ ${QINDA_LLM_COMMIT} | gzip -n > ${PF}.tar.gz"
	einfo "Place it in DISTDIR. No model weights or llama.cpp binary are included."
}

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
	dodoc LICENSE
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
