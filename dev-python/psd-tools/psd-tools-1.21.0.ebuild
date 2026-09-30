# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Maintained parser for Photoshop PSD records and cached image data"
HOMEPAGE="
	https://github.com/psd-tools/psd-tools
	https://psd-tools.readthedocs.io/
	https://pypi.org/project/psd-tools/
"
# PyPI release metadata has no sdist. Pin the matching upstream release archive.
# v1.21.0 -> 97adebeb0c1f3e4f0b3998a898388190b9d6bbdd (2026-09-28).
SRC_URI="https://github.com/psd-tools/psd-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# The upstream image/compositing suite requires additional rendering packages.
# This parser-only package is qualified by Studio's independent fixture gate;
# it does not install aggdraw/scipy/scikit-image just to inspect native records.
RESTRICT="test"

RDEPEND="
	>=dev-python/attrs-23.0.0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.3.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"
