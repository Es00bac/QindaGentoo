# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
# ::gentoo builds sci-ml/huggingface_hub and sci-ml/tokenizers for one Python
# implementation only, and a package that imports them can only be the same.
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Whisper speech recognition reimplemented on CTranslate2"
HOMEPAGE="
	https://github.com/SYSTRAN/faster-whisper
	https://pypi.org/project/faster-whisper/
"
# PyPI carries only the wheel for this release.
SRC_URI="https://github.com/SYSTRAN/faster-whisper/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# The suite downloads models from the Hugging Face hub.
RESTRICT="test"

# AGENT-NOTE: requirements.txt also lists onnxruntime, but it is imported
# lazily and only by the Silero VAD filter (faster_whisper/vad.py), which
# push-to-talk dictation does not use; asking for it without the package
# raises a clear error. Leaving it out keeps ::guru's sci-libs/onnxruntime and
# its protobuf/abseil stack off the desktop. Models are data, not
# dependencies: see app-accessibility/faster-whisper-models.
RDEPEND="
	$(python_gen_cond_dep '
		>=sci-ml/ctranslate2-4.0[${PYTHON_USEDEP}]
		<sci-ml/ctranslate2-5
		>=dev-python/av-11[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
	')
	>=sci-ml/huggingface_hub-0.21[${PYTHON_SINGLE_USEDEP}]
	>=sci-ml/tokenizers-0.13[${PYTHON_SINGLE_USEDEP}]
	<sci-ml/tokenizers-1
"
