# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
PYPI_PN="mkdocs_get_deps"

inherit distutils-r1 pypi

DESCRIPTION="Infer Python dependencies for a MkDocs configuration"
HOMEPAGE="https://github.com/mkdocs/get-deps https://pypi.org/project/mkdocs-get-deps/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/mergedeep[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
