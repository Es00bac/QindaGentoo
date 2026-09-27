# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# AGENT-NOTE: model data in the shape of app-accessibility/faster-whisper-models:
# pinned Hugging Face revisions, one USE flag per model, installed below
# /usr/share/gguf where sci-ml/qinda-llm-server (llama.cpp's llama-server)
# finds them. The version is the date the revisions were pinned; a new
# revision or quantization of any model is a new version.
#
# Both are 35B-total / ~3B-active mixture-of-experts coding models, the only
# class that runs at interactive speed on qinda (Ryzen 9 3900X, 32 GB DDR4,
# 8 GB RX 5700 XT): the experts live in system RAM, the rest on the GPU.
# Q5_K_M-class quantizations: Q4 degrades long agentic tool calling, Q6 does
# not leave headroom in 32 GB + 8 GB.
ORNITH_COMMIT="12393612fd4f730ff5aadc23e9b8f9648aa49ceb"
QWEN36_COMMIT="a483e9e6cbd595906af30beda3187c2663a1118c"

ORNITH_FILE="Ornith-1.5-35B-Q5_K_M.gguf"
QWEN36_FILE="Qwen3.6-35B-A3B-UD-Q5_K_XL.gguf"

HF="https://huggingface.co"

DESCRIPTION="Local agentic coding LLMs in GGUF format for llama.cpp"
HOMEPAGE="
	https://huggingface.co/ornith-ai/Ornith-1.5-35B-A3B-GGUF
	https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF
"
SRC_URI="
	ornith-1-5-35b-a3b? (
		${HF}/ornith-ai/Ornith-1.5-35B-A3B-GGUF/resolve/${ORNITH_COMMIT}/${ORNITH_FILE}
			-> ${PN}-${ORNITH_COMMIT:0:8}-${ORNITH_FILE}
	)
	qwen3-6-35b-a3b? (
		${HF}/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/${QWEN36_COMMIT}/${QWEN36_FILE}
			-> ${PN}-${QWEN36_COMMIT:0:8}-${QWEN36_FILE}
	)
"
S="${WORKDIR}"

LICENSE="
	ornith-1-5-35b-a3b? ( MIT )
	qwen3-6-35b-a3b? ( Apache-2.0 )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ornith-1-5-35b-a3b qwen3-6-35b-a3b"
REQUIRED_USE="|| ( ornith-1-5-35b-a3b qwen3-6-35b-a3b )"
# Weights: nothing to strip, no ELF files to check, nothing to build.
RESTRICT="binchecks strip"

src_unpack() {
	# Models are installed from DISTDIR as they are; none is an archive.
	:
}

# AGENT-NOTE: each model is 25+ GB. Copying one into the image took 20+
# minutes on qinda's QLC NVMe and evicted a running model from the page
# cache, so the verified distfile is hard-linked into the image instead; the
# merge renames it into place on the same filesystem. Installing then costs
# no time and no second copy (the distfile and /usr/share/gguf share one
# inode, which eclean-dist may later unlink safely). A copy is the fallback
# when DISTDIR is on another filesystem.
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
	if use ornith-1-5-35b-a3b; then
		install_model "${PN}-${ORNITH_COMMIT:0:8}-${ORNITH_FILE}" Ornith-1.5-35B-A3B-Q5_K_M.gguf
	fi
	if use qwen3-6-35b-a3b; then
		install_model "${PN}-${QWEN36_COMMIT:0:8}-${QWEN36_FILE}" Qwen3.6-35B-A3B-UD-Q5_K_XL.gguf
	fi
}
