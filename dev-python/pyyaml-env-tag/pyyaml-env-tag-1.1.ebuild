# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_PN="pyyaml_env_tag"

inherit distutils-r1 pypi

DESCRIPTION="A YAML tag for referencing environment variables"
HOMEPAGE="https://github.com/waylan/pyyaml-env-tag https://pypi.org/project/pyyaml-env-tag/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
