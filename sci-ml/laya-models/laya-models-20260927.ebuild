# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# AGENT-NOTE: model data in the shape of app-accessibility/faster-whisper-models:
# a pinned upstream revision, one USE flag per checkpoint, installed below
# /usr/share where sci-ml/laya's laya-serve finds them by name
# (LAYA_MODEL_DIR=/usr/share/laya, files/serve.env there; the Gentoo patch
# adds that variable). The version is the date the revision was pinned; a
# new revision is a new version. Only the files Laya itself fetches from
# the Hub bundle are taken (its snapshot_download allow_patterns:
# rl_agent_config.json, model.safetensors, tokenizer/*, encoder/*), so
# nothing is downloaded at run time. The tokenizer configs at this revision
# are already in the form laya's _fix_tokenizer_config() wants, so it never
# rewrites a file under /usr/share.
LAYA_COMMIT="55cf4c4ebb4ebe31b2550e8bdf3bd21b99753851"

HF="https://huggingface.co/convaiinnovations/laya/resolve/${LAYA_COMMIT}"
FILES=( rl_agent_config.json model.safetensors tokenizer/tokenizer.json
	tokenizer/tokenizer_config.json encoder/config.json )

# <USE flag> <subfolder in the bundle ("" for the root)>
laya_src_uri() {
	local flag=${1} sub=${2} file
	echo "${flag}? ("
	for file in "${FILES[@]}"; do
		echo "${HF}/${sub:+${sub}/}${file} -> ${PN}-${flag}-${LAYA_COMMIT:0:8}-${file//\//-}"
	done
	echo ")"
}

DESCRIPTION="Laya System One decision model checkpoints (Jev-compatible, Apache-2.0)"
HOMEPAGE="https://huggingface.co/convaiinnovations/laya"
SRC_URI="
	$(laya_src_uri english "")
	$(laya_src_uri multilingual multilingual)
	$(laya_src_uri typed-decisions typed-decisions)
"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
# english (421M, ModernBERT-large, 512 tokens) is the default: live notes
# ask English questions, and on a CPU it answers the three gate questions
# in well under a second. multilingual (322M, 100+ languages) is what the
# router picks for non-English text; typed-decisions needs training data.
IUSE="+english multilingual typed-decisions"
REQUIRED_USE="|| ( english multilingual typed-decisions )"
# Weights: nothing to strip, nothing to build.
RESTRICT="strip"

src_unpack() {
	# Installed from DISTDIR as they are; none is an archive.
	:
}

# <USE flag / checkpoint name>
install_checkpoint() {
	local name=${1} file
	for file in "${FILES[@]}"; do
		insinto /usr/share/laya/${name}/$(dirname "${file}")
		newins "${DISTDIR}/${PN}-${name}-${LAYA_COMMIT:0:8}-${file//\//-}" "$(basename "${file}")"
	done
}

src_install() {
	local name
	for name in english multilingual typed-decisions; do
		use ${name} && install_checkpoint ${name}
	done
}
