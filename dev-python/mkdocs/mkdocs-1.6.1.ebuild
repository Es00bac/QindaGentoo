# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Project documentation with Markdown"
HOMEPAGE="https://www.mkdocs.org/ https://pypi.org/project/mkdocs/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/ghp-import[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/mergedeep[${PYTHON_USEDEP}]
	dev-python/mkdocs-get-deps[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/pyyaml-env-tag[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/watchdog[${PYTHON_USEDEP}]
"

# The upstream Hatch hook compiles the bundled translation catalogs.
BDEPEND="dev-python/babel[${PYTHON_USEDEP}]"
