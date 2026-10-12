# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

HF_COMMIT="a57397bd3d351599d9729fc144b3f87c3f87d65b"
HF_SHORT="${HF_COMMIT:0:8}"
HF_BASE="https://huggingface.co/ilintar/trellis2-gguf/resolve/${HF_COMMIT}/q4"
MODEL_FILES="birefnet dinov3 shape_dec shape_flow_512 ss_dec ss_flow tex_dec tex_flow_512"

DESCRIPTION="Q4 TRELLIS.2 image-to-3D weights for 512-resolution Vulkan inference"
HOMEPAGE="https://huggingface.co/ilintar/trellis2-gguf https://github.com/microsoft/TRELLIS.2"
SRC_URI="
	${HF_BASE}/birefnet.gguf -> ${PN}-${HF_SHORT}-birefnet.gguf
	${HF_BASE}/dinov3.gguf -> ${PN}-${HF_SHORT}-dinov3.gguf
	${HF_BASE}/shape_dec.gguf -> ${PN}-${HF_SHORT}-shape_dec.gguf
	${HF_BASE}/shape_flow_512.gguf -> ${PN}-${HF_SHORT}-shape_flow_512.gguf
	${HF_BASE}/ss_dec.gguf -> ${PN}-${HF_SHORT}-ss_dec.gguf
	${HF_BASE}/ss_flow.gguf -> ${PN}-${HF_SHORT}-ss_flow.gguf
	${HF_BASE}/tex_dec.gguf -> ${PN}-${HF_SHORT}-tex_dec.gguf
	${HF_BASE}/tex_flow_512.gguf -> ${PN}-${HF_SHORT}-tex_flow_512.gguf
"
S="${WORKDIR}"

# The bundle includes TRELLIS.2, DINOv3 and BiRefNet components.
LICENSE="MIT Apache-2.0 all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror strip"

src_unpack() { :; }

src_install() {
	local model
	insinto /mnt/void/ai-models/trellis2-q4
	for model in ${MODEL_FILES}; do
		newins "${DISTDIR}/${PN}-${HF_SHORT}-${model}.gguf" "${model}.gguf" || die
	done
}

pkg_preinst() {
	mountpoint -q /mnt/void || die "/mnt/void must be mounted before installing TRELLIS.2 weights"
}

pkg_postinst() {
	elog "TRELLIS.2 Q4 weights are installed on qinda's HDD at /mnt/void/ai-models/trellis2-q4."
}
