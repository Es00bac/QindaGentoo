# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )

inherit cmake distutils-r1

# AGENT-NOTE: third-party, kept here for the same reason as net-wireless/*:
# faster-whisper's inference engine is in neither ::gentoo nor ::guru. The
# shape is ::gentoo's sci-ml/sentencepiece -- a CMake library with a Python
# binding in python/. Upstream publishes wheels only, and its tag archive
# leaves the git submodules empty. The CPU build compiles in two of them,
# cpu_features (x86 ISA dispatch) and spdlog (header-only logging), so they
# are fetched at the commits v4.8.2's tree records. Both stay private to the
# library: no installed header includes either.
CPU_FEATURES_COMMIT="8a494eb1e158ec2050e5f699a504fbc9b896a43b"
SPDLOG_COMMIT="76fb40d95455f249bd70824ecfcae7a8f0930fa3"

DESCRIPTION="Fast inference engine for Transformer models, the runtime of faster-whisper"
HOMEPAGE="
	https://opennmt.net/CTranslate2/
	https://github.com/OpenNMT/CTranslate2
"
SRC_URI="
	https://github.com/OpenNMT/CTranslate2/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
	https://github.com/google/cpu_features/archive/${CPU_FEATURES_COMMIT}.tar.gz
		-> ${P}-cpu_features-${CPU_FEATURES_COMMIT:0:12}.gh.tar.gz
	https://github.com/gabime/spdlog/archive/${SPDLOG_COMMIT}.tar.gz
		-> ${P}-spdlog-${SPDLOG_COMMIT:0:12}.gh.tar.gz
"
S="${WORKDIR}/CTranslate2-${PV}"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
# The binding's suite converts models with torch, transformers, TensorFlow
# and fairseq, none of which this package exists for.
RESTRICT="test"

# AGENT-NOTE: oneDNN, not Intel MKL. CTranslate2 uses MKL only on
# GenuineIntel CPUs (src/cpu/backend.cc), so on the AMD machines this overlay
# builds for, upstream's own wheels already run every float32 and int8 GEMM
# through oneDNN; this is the same path without a proprietary library.
# OpenMP comes from the compiler (OPENMP_RUNTIME=COMP), matching the runtime
# oneDNN is built with under USE=openmp.
RDEPEND="
	sci-ml/oneDNN[openmp]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/pybind11[${PYTHON_USEDEP}]
"

src_unpack() {
	default
	local name
	for name in cpu_features spdlog; do
		rmdir "${S}/third_party/${name}" || die
	done
	mv "${WORKDIR}/cpu_features-${CPU_FEATURES_COMMIT}" "${S}"/third_party/cpu_features || die
	mv "${WORKDIR}/spdlog-${SPDLOG_COMMIT}" "${S}"/third_party/spdlog || die
}

src_prepare() {
	# The extension would otherwise carry /usr/local in its RUNPATH.
	sed -i -e '/-Wl,-rpath,\/usr\/local/d' python/setup.py || die
	distutils-r1_src_prepare
	# After the submodules are in place: cpu_features still declares CMake
	# 3.0, and the eclass only adds its CMake 4 policy floor for the files it
	# has seen here.
	cmake_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_CLI=OFF
		-DBUILD_TESTS=OFF
		-DENABLE_CPU_DISPATCH=ON
		-DOPENMP_RUNTIME=COMP
		-DWITH_DNNL=ON
		-DWITH_MKL=OFF
		-DWITH_OPENBLAS=OFF
		-DWITH_RUY=OFF
		-DWITH_CUDA=OFF
		-DWITH_CUDNN=OFF
		-DWITH_HIP=OFF
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	# The binding links the library just built rather than an installed one.
	# setup.py takes both halves from CTRANSLATE2_ROOT.
	mkdir -p "${T}"/ct2 || die
	ln -s "${S}"/include "${T}"/ct2/include || die
	ln -s "${BUILD_DIR}" "${T}"/ct2/lib || die
	local -x CTRANSLATE2_ROOT="${T}"/ct2
	cd python || die
	distutils-r1_src_compile
}

src_install() {
	cmake_src_install
	distutils-r1_src_install
}
