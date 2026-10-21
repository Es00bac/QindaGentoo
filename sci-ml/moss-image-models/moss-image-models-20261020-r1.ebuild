# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
DESCRIPTION="MOSS Image Base and SFT Q4 models, Qwen 3.5 encoder and FLUX.2 VAE on SSD"
HOMEPAGE="https://github.com/OpenMOSS/MOSS-Image"
SRC_URI="
	https://huggingface.co/leejet/MOSS-Image-SFT-GGUF/resolve/238daf423f0de65316207453591f275407aac9a7/MOSS-Image-SFT-Q4_0.gguf -> moss-sft-238daf42-Q4_0.gguf
	https://huggingface.co/leejet/MOSS-Image-Base-GGUF/resolve/3a2df431a5bc8460783c4fcdf4912b57e865e9bb/MOSS-Image-Base-Q4_0.gguf -> moss-base-3a2df431-Q4_0.gguf
	https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/3885219b6810b007914f3a7950a8d1b469d598a5/Qwen3.5-9B-Q4_K_M.gguf -> moss-qwen-3885219b-Q4_K_M.gguf
	https://huggingface.co/Comfy-Org/MOSS-Image/resolve/ee64003102c8470ee32501cf883419235db81884/vae/flux2-vae.safetensors -> moss-vae-ee640031.safetensors
	https://huggingface.co/OpenMOSS-Team/MOSS-Image-Base/resolve/85975793d8b3d432f1b6e27f352abaa4c2a4c0d3/tokenizer/tokenizer.json -> moss-tokenizer-85975793.json
"
S="${WORKDIR}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"
src_unpack() { :; }
src_install() {
	insinto /usr/share/moss-image
	newins "${DISTDIR}/moss-sft-238daf42-Q4_0.gguf" MOSS-Image-SFT-Q4_0.gguf
	newins "${DISTDIR}/moss-base-3a2df431-Q4_0.gguf" MOSS-Image-Base-Q4_0.gguf
	newins "${DISTDIR}/moss-qwen-3885219b-Q4_K_M.gguf" Qwen3.5-9B-Q4_K_M.gguf
	newins "${DISTDIR}/moss-vae-ee640031.safetensors" flux2-vae.safetensors
	newins "${DISTDIR}/moss-tokenizer-85975793.json" tokenizer.json
	# Preserve the original release's configured file paths without duplicate weights.
	local name
	for name in MOSS-Image-SFT-Q4_0.gguf MOSS-Image-Base-Q4_0.gguf \
		Qwen3.5-9B-Q4_K_M.gguf flux2-vae.safetensors tokenizer.json; do
		dosym -r "/usr/share/moss-image/${name}" "/mnt/void/ai-models/moss-image/${name}"
	done
}
pkg_preinst() {
	mountpoint -q /mnt/void || die "/mnt/void must be mounted for the original MOSS path compatibility links"
}
