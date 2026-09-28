# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi systemd

# AGENT-NOTE: Laya, the open-source, TypeSafe-Jev-compatible "System One"
# decision model (Convai Innovations). QindaNote's live notes (QindaOffice
# D-057) use it as the gate in front of the notes model: POST
# /v1/systemone with typed noul/choice/score questions, ~0.2-0.5 s per
# request on a CPU. Upstream installs with `pip install laya[serve]`; here the
# library comes from the PyPI sdist, every dependency from ::gentoo, and the
# checkpoints from sci-ml/laya-models (never a run-time download).
#
# files/laya-0.3.21-local-model-dir.patch adds LAYA_MODEL_DIR to laya-serve:
# upstream's server only knows Hugging Face repo ids. With it set, the
# installed checkpoints are served and preloaded, a missing one falls back to
# an installed one with a warning, and the unit adds HF_HUB_OFFLINE=1 so a
# stray Hub id fails instead of downloading.

DESCRIPTION="Non-autoregressive System 1 decision engine (Jev-compatible /v1/systemone server)"
HOMEPAGE="
	https://huggingface.co/convaiinnovations/laya
	https://github.com/NandhaKishorM/laya
	https://pypi.org/project/laya/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+serve"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# The upstream suite downloads checkpoints and exercises optional
# integrations (LangChain, MCP, ONNX) that are not packaged here.
RESTRICT="test"

RDEPEND="
	sci-ml/pytorch[${PYTHON_SINGLE_USEDEP}]
	>=sci-ml/transformers-4.48.0[torch,${PYTHON_SINGLE_USEDEP}]
	>=sci-ml/huggingface_hub-0.20.0[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/numpy-1.20.0[${PYTHON_USEDEP}]
		>=sci-ml/safetensors-0.4.0[${PYTHON_USEDEP}]
		serve? (
			>=dev-python/fastapi-0.110.0[${PYTHON_USEDEP}]
			>=dev-python/python-multipart-0.0.9[${PYTHON_USEDEP}]
			>=dev-python/uvicorn-0.27.0[${PYTHON_USEDEP}]
		)
	')
	serve? ( sci-ml/laya-models )
"

PATCHES=(
	"${FILESDIR}"/${P}-local-model-dir.patch
)

src_install() {
	distutils-r1_src_install
	# The MCP server needs the `mcp` extra, which is not packaged.
	rm "${ED}"/usr/bin/laya-mcp-server || die
	if use serve; then
		systemd_dounit "${FILESDIR}"/laya-serve.service
		insinto /etc/laya
		newins "${FILESDIR}"/serve.env serve.env
		# May carry LAYA_API_KEY; systemd reads it as root.
		fperms 0600 /etc/laya/serve.env
	else
		rm "${ED}"/usr/bin/laya-serve || die
	fi
}

pkg_postinst() {
	if use serve; then
		elog "Start the server with 'systemctl enable --now laya-serve.service'."
		elog "It listens on 127.0.0.1:8000 (/etc/laya/serve.env) and serves the"
		elog "checkpoints sci-ml/laya-models installed under /usr/share/laya."
		elog "QindaNote: Live Notes ▸ Settings ▸ Gate ▸ Laya (http://127.0.0.1:8000,"
		elog "model 'english')."
	fi
}
