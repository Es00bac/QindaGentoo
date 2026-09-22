# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# AGENT-NOTE: speech data in the shape of ::gentoo's
# app-accessibility/mbrola-voices: pinned upstream revisions, one USE flag per
# model, installed below /usr/share where every faster-whisper user can find
# them by name -- /usr/share/faster-whisper/<name>/ is the layout Gabbee's
# offline dictation searches (with ~/.local/share first). The version is the
# date the revisions were pinned; a new revision of any model is a new
# version. Distfile names carry the revision so unchanged models are reused.
DISTIL_SMALL_EN_COMMIT="ef77d90526ccd62cde3808ee70626a01e5cf83e4"
BASE_EN_COMMIT="3d3d5dee26484f91867d81cb899cfcf72b96be6c"
LARGE_V3_TURBO_COMMIT="0a363e9161cbc7ed1431c9597a8ceaf0c4f78fcf"

HF="https://huggingface.co"

DESCRIPTION="Whisper speech recognition models converted for faster-whisper (CTranslate2)"
HOMEPAGE="
	https://huggingface.co/Systran
	https://huggingface.co/dropbox-dash/faster-whisper-large-v3-turbo
"
SRC_URI="
	distil-small-en? (
		${HF}/Systran/faster-distil-whisper-small.en/resolve/${DISTIL_SMALL_EN_COMMIT}/config.json
			-> ${PN}-distil-small.en-${DISTIL_SMALL_EN_COMMIT:0:8}-config.json
		${HF}/Systran/faster-distil-whisper-small.en/resolve/${DISTIL_SMALL_EN_COMMIT}/model.bin
			-> ${PN}-distil-small.en-${DISTIL_SMALL_EN_COMMIT:0:8}-model.bin
		${HF}/Systran/faster-distil-whisper-small.en/resolve/${DISTIL_SMALL_EN_COMMIT}/preprocessor_config.json
			-> ${PN}-distil-small.en-${DISTIL_SMALL_EN_COMMIT:0:8}-preprocessor_config.json
		${HF}/Systran/faster-distil-whisper-small.en/resolve/${DISTIL_SMALL_EN_COMMIT}/tokenizer.json
			-> ${PN}-distil-small.en-${DISTIL_SMALL_EN_COMMIT:0:8}-tokenizer.json
		${HF}/Systran/faster-distil-whisper-small.en/resolve/${DISTIL_SMALL_EN_COMMIT}/vocabulary.json
			-> ${PN}-distil-small.en-${DISTIL_SMALL_EN_COMMIT:0:8}-vocabulary.json
	)
	base-en? (
		${HF}/Systran/faster-whisper-base.en/resolve/${BASE_EN_COMMIT}/config.json
			-> ${PN}-base.en-${BASE_EN_COMMIT:0:8}-config.json
		${HF}/Systran/faster-whisper-base.en/resolve/${BASE_EN_COMMIT}/model.bin
			-> ${PN}-base.en-${BASE_EN_COMMIT:0:8}-model.bin
		${HF}/Systran/faster-whisper-base.en/resolve/${BASE_EN_COMMIT}/tokenizer.json
			-> ${PN}-base.en-${BASE_EN_COMMIT:0:8}-tokenizer.json
		${HF}/Systran/faster-whisper-base.en/resolve/${BASE_EN_COMMIT}/vocabulary.txt
			-> ${PN}-base.en-${BASE_EN_COMMIT:0:8}-vocabulary.txt
	)
	large-v3-turbo? (
		${HF}/dropbox-dash/faster-whisper-large-v3-turbo/resolve/${LARGE_V3_TURBO_COMMIT}/config.json
			-> ${PN}-large-v3-turbo-${LARGE_V3_TURBO_COMMIT:0:8}-config.json
		${HF}/dropbox-dash/faster-whisper-large-v3-turbo/resolve/${LARGE_V3_TURBO_COMMIT}/model.bin
			-> ${PN}-large-v3-turbo-${LARGE_V3_TURBO_COMMIT:0:8}-model.bin
		${HF}/dropbox-dash/faster-whisper-large-v3-turbo/resolve/${LARGE_V3_TURBO_COMMIT}/preprocessor_config.json
			-> ${PN}-large-v3-turbo-${LARGE_V3_TURBO_COMMIT:0:8}-preprocessor_config.json
		${HF}/dropbox-dash/faster-whisper-large-v3-turbo/resolve/${LARGE_V3_TURBO_COMMIT}/tokenizer.json
			-> ${PN}-large-v3-turbo-${LARGE_V3_TURBO_COMMIT:0:8}-tokenizer.json
		${HF}/dropbox-dash/faster-whisper-large-v3-turbo/resolve/${LARGE_V3_TURBO_COMMIT}/vocabulary.json
			-> ${PN}-large-v3-turbo-${LARGE_V3_TURBO_COMMIT:0:8}-vocabulary.json
	)
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# AGENT-NOTE: distil-small.en is the default because it was measured to be:
# on a Ryzen 9 3900X and a Ryzen 7 5825U, CPU only, it is the most accurate
# model that still finalizes a 5-8 s utterance in well under two seconds.
# large-v3-turbo is exact but took 5.5-7 s there; it is for a GPU.
IUSE="+distil-small-en base-en large-v3-turbo"
REQUIRED_USE="|| ( distil-small-en base-en large-v3-turbo )"
# Weights: nothing to strip, nothing to build.
RESTRICT="strip"

src_unpack() {
	# Models are installed from DISTDIR as they are; none is an archive.
	:
}

# <model name> <commit> <file>...
install_model() {
	local name=${1} commit=${2}
	shift 2
	insinto /usr/share/faster-whisper/${name}
	local file
	for file; do
		newins "${DISTDIR}/${PN}-${name}-${commit:0:8}-${file}" "${file}"
	done
}

src_install() {
	if use distil-small-en; then
		install_model distil-small.en "${DISTIL_SMALL_EN_COMMIT}" \
			config.json model.bin preprocessor_config.json tokenizer.json vocabulary.json
	fi
	if use base-en; then
		install_model base.en "${BASE_EN_COMMIT}" \
			config.json model.bin tokenizer.json vocabulary.txt
	fi
	if use large-v3-turbo; then
		install_model large-v3-turbo "${LARGE_V3_TURBO_COMMIT}" \
			config.json model.bin preprocessor_config.json tokenizer.json vocabulary.json
	fi
}
