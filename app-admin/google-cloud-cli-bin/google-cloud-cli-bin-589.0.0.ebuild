# Copyright 2026 Sloom Software LLC
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Google Cloud CLI (gcloud, gsutil, bq) from Google's versioned Linux archive"
HOMEPAGE="https://cloud.google.com/sdk"
# The versioned archive never changes once published (the unversioned
# "latest" one does), so the Manifest pins it.
SRC_URI="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${PV}-linux-x86_64.tar.gz"
S="${WORKDIR}/google-cloud-sdk"

LICENSE="Apache-2.0 BSD MIT PSF-2"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror strip test"
QA_PREBUILT="opt/google-cloud-sdk/*"

RDEPEND="
	>=sys-libs/glibc-2.31
	app-misc/ca-certificates
"

src_compile() { :; }

src_install() {
	# Portage owns this tree: gcloud's own component updater and update
	# check are off (`gcloud components install` is refused). Extra
	# components need a new revision that unpacks them here.
	cat > properties <<-EOT || die
	[component_manager]
	disable_update_check = true

	[core]
	disable_usage_reporting = true
	EOT
	rm -f install.sh install.bat || die
	dodir /opt/google-cloud-sdk
	cp -a . "${ED}/opt/google-cloud-sdk/" || die
	local tool
	for tool in gcloud gsutil bq; do
		dosym ../../opt/google-cloud-sdk/bin/${tool} /usr/bin/${tool}
	done
}

pkg_postinst() {
	einfo "Sign in with: gcloud auth login"
	einfo "Updates come from Portage; gcloud's own updater is disabled."
}
