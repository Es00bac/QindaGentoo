# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..15} )
inherit python-any-r1 xdg

QINDA_ICON_ART_COMMIT="2efd8795ce9a124106a541f39766cd95c8c0ef54"
QINDA_THEME_ID="QindaQt-Breeze-Painted"
DESCRIPTION="QindaQt Painted gouache and ink raster icon family"
HOMEPAGE="https://github.com/Es00bac/QindaQt"
# AGENT-CONTRACT: both sibling packages consume the same immutable reviewed
# source release; its commit-qualified name prevents either recipe recutting it.
SRC_URI="QindaIconArt-${QINDA_ICON_ART_COMMIT}.tar.xz"
S="${WORKDIR}/QindaIconArt-${QINDA_ICON_ART_COMMIT}"
LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch"

# AGENT-GUARD: this data-only family must not add a Plasma runtime dependency.
RDEPEND="x11-themes/hicolor-icon-theme"
BDEPEND="${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/pillow[${PYTHON_USEDEP}]')"

python_check_deps() {
	python_has_version "dev-python/pillow[${PYTHON_USEDEP}]"
}

pkg_nofetch() {
	eerror "Obtain the exact reviewed shared ${A} from the qinda distfile hub."
	eerror "Source is pinned to QindaIconArt ${QINDA_ICON_ART_COMMIT}."
	eerror "The archive retains original editable sources, complete original"
	eerror "and override provenance, independent reviews and legal notices."
	eerror "Do not substitute a partial checkpoint or run a supplied installer."
}

src_prepare() {
	default
	# Original drawing/atlas release tools rewrite original records and reject
	# approved overrides. Compose into build/ with the reviewed overlay contract.
	"${PYTHON}" tools/qindaqt_icon_release.py compose --root . \
		--manifest provenance/qindaqt-20261002/manifest.json \
		--output build/qindaqt-release || die "Source-bound artwork composition failed"
	"${PYTHON}" tools/qindaqt_icon_release.py verify-output --root . \
		--manifest provenance/qindaqt-20261002/manifest.json \
		--output build/qindaqt-release || die "Complete reviewed artwork release verification failed"
}

src_install() {
	# AGENT-CONTRACT: preserve saved runtime identity and verified raster bytes;
	# icon selection belongs to Settings and never package hooks.
	insinto "/usr/share/icons/${QINDA_THEME_ID}"
	doins -r "build/qindaqt-release/${QINDA_THEME_ID}/."

	dodoc README.md sources/QINDAQT-DEBRAND.md sources/QINDAQT-MODIFICATIONS.txt
	docinto source
	dodoc -r sources/painted-original
	dodoc -r sources/native
	docinto provenance
	dodoc provenance/README.md provenance/source-contract.json provenance/inventory-check.json \
		provenance/release-manifest.csv provenance/release-summary.json
	docinto provenance/qindaqt-20261002
	dodoc provenance/qindaqt-20261002/manifest.json
	dodoc -r provenance/qindaqt-20261002/qa
	dodoc build/qindaqt-release/release-inventory.json
	# Full original/generated raster provenance remains in the pinned archive.
	# Editable painted originals and all retained notices stay uncompressed.
	docompress -x "/usr/share/doc/${PF}"

	"${PYTHON}" "${FILESDIR}/verify-image-20261002.py" "${S}" "${ED}" \
		|| die "Staged runtime image differs from the reviewed source release"
}
