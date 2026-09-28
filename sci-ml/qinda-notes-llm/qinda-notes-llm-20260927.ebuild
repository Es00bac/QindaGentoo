# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

# AGENT-NOTE: the offline notes model for the laptop (qinda-top: Ryzen 7
# 5825U, 13 GiB RAM, Radeon Barcelo iGPU). QindaNote's live notes need a model
# that runs beside local Whisper and the desktop; a 4B dense model at Q4 on the
# iGPU through Vulkan is what fits. The runtime is ::guru's llama.cpp (the same
# Vulkan build as qinda's sci-ml/qinda-llm-server); the weights are pinned like
# sci-ml/gguf-coding-models and live beside them in /usr/share/gguf. The
# version is the date the revision was pinned. Measurements: QindaOffice
# docs/live-notes.md ("Offline notes").
QWEN_COMMIT="e87f176479d0855a907a41277aca2f8ee7a09523"
QWEN_FILE="Qwen3.5-4B-UD-Q4_K_XL.gguf"
MMPROJ_FILE="mmproj-F16.gguf"
HF="https://huggingface.co/unsloth/Qwen3.5-4B-GGUF/resolve/${QWEN_COMMIT}"

DESCRIPTION="On-demand local notes model (Qwen3.5-4B on llama.cpp) for QindaNote"
HOMEPAGE="https://huggingface.co/Qwen/Qwen3.5-4B"
SRC_URI="
	${HF}/${QWEN_FILE} -> ${PN}-${QWEN_COMMIT:0:8}-${QWEN_FILE}
	vision? ( ${HF}/${MMPROJ_FILE} -> ${PN}-${QWEN_COMMIT:0:8}-Qwen3.5-4B-${MMPROJ_FILE} )
"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="vision"
# Weights: nothing to strip, no ELF files to check, nothing to build.
RESTRICT="binchecks strip"

RDEPEND="
	net-misc/curl
	sci-misc/llama-cpp[vulkan]
	sys-apps/systemd
"

src_unpack() {
	# The weights are installed from DISTDIR as they are.
	:
}

# Hard-link the verified distfile into the image when DISTDIR shares a
# filesystem with it (see sci-ml/gguf-coding-models), else copy.
install_model() {
	local src dst="${ED}/usr/share/gguf/${2}"
	src=$(readlink -f "${DISTDIR}/${1}") || die
	mkdir -p "${ED}/usr/share/gguf" || die
	addwrite "${src%/*}"
	if ! ln "${src}" "${dst}" 2>/dev/null; then
		cp "${src}" "${dst}" || die "cannot install ${2}"
	fi
	fowners root:root "/usr/share/gguf/${2}"
	fperms 0644 "/usr/share/gguf/${2}"
}

src_install() {
	install_model "${PN}-${QWEN_COMMIT:0:8}-${QWEN_FILE}" "${QWEN_FILE}"
	local mmproj=
	if use vision; then
		install_model "${PN}-${QWEN_COMMIT:0:8}-Qwen3.5-4B-${MMPROJ_FILE}" "Qwen3.5-4B-${MMPROJ_FILE}"
		mmproj="--mmproj /usr/share/gguf/Qwen3.5-4B-${MMPROJ_FILE}"
	fi

	systemd_dounit "${FILESDIR}"/qinda-notes-llm.socket
	systemd_dounit "${FILESDIR}"/qinda-notes-llm.service
	systemd_dounit "${FILESDIR}"/qinda-notes-llm-server.service
	exeinto /usr/libexec/qinda-notes-llm
	doexe "${FILESDIR}"/wait-ready

	sed -e "s|@MMPROJ@|${mmproj}|" "${FILESDIR}"/serve.env > serve.env || die
	insinto /etc/qinda-notes-llm
	doins serve.env
}

pkg_postinst() {
	elog "Start the on-demand socket (the model loads on first use and unloads"
	elog "after NOTES_IDLE_EXIT, 15 minutes by default):"
	elog "  systemctl enable --now qinda-notes-llm.socket"
	elog "QindaNote: Live ▸ Settings ▸ model provider \"llama.cpp server\","
	elog "model \"qwen3.5-4b\" (http://127.0.0.1:8080/v1)."
}
