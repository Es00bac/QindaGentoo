# Copyright 2026 QindaQt contributors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
# store.py keeps the studio in SQLite; hi3d.py talks to its service over HTTPS.
PYTHON_REQ_USE="sqlite,ssl"
inherit desktop git-r3 python-single-r1 xdg

DESCRIPTION="Agent-operated animation studio with an Electron desktop app"
HOMEPAGE="https://github.com/Es00bac"
# Live ebuild: it builds the head of main. qinda reads the hub itself; the laptop
# reads a bare mirror and must refresh it before every emerge:
#   git clone --mirror qinda:git/Animator.git ~/git/Animator.git   (once)
#   git -C ~/git/Animator.git fetch origin                          (each time)
EGIT_REPO_URI="file:///home/cabewse/git/Animator.git
	file:///home/cabewse/work_SPaC3/Animator
	file:///home/cabewse/work_space/Animator"
EGIT_BRANCH="main"

# The Electron major the desktop shell runs on: the dev-util/electron-bin slot
# and the /usr/bin/electron-<slot> launcher it provides.
ELECTRON_SLOT=44

# The project states no licence; this stays private source until it does.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS=""
RESTRICT="bindist mirror"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# compose.py exports mp4 through ffmpeg's libx264; preview.py writes JPEG and
# vector.py draws text with Pillow, so PNG (zlib), JPEG and TrueType are needed.
RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pillow[jpeg,truetype,zlib,${PYTHON_USEDEP}]
	')
	dev-util/electron-bin:${ELECTRON_SLOT}
	media-video/ffmpeg[x264]
"
BDEPEND="${PYTHON_DEPS}"

# Everything src_install takes from electron/ (the desktop shell lives in the
# Animator repository and is added there separately from this recipe).
ANIMATOR_SHELL_FILES=(
	main.cjs preload.cjs package.json animator.desktop icons/animator.svg
	icons/animator-{16,32,48,64,128,256,512}.png
)

src_unpack() {
	git-r3_src_unpack

	local file missing=()
	if [[ ! -d ${S}/electron ]]; then
		eerror "Animator commit ${EGIT_VERSION} has no electron/ directory."
		eerror "This package installs the desktop shell from electron/ (main.cjs,"
		eerror "preload.cjs, package.json, animator.desktop and icons/)."
		eerror "Push it to the main branch of the Animator hub, refresh the mirror"
		eerror "(git -C ~/git/Animator.git fetch origin) and emerge again."
		die "electron/ is missing from the Animator source"
	fi
	for file in "${ANIMATOR_SHELL_FILES[@]}"; do
		[[ -f ${S}/electron/${file} ]] || missing+=( "electron/${file}" )
	done
	if (( ${#missing[@]} )); then
		eerror "Animator commit ${EGIT_VERSION} lacks files this package installs:"
		for file in "${missing[@]}"; do
			eerror "    ${file}"
		done
		die "electron/ is incomplete in the Animator source"
	fi
}

src_install() {
	local file root=/usr/share/animator size

	# animator/ is the Python package (with director_prompt.md), web/ the browser
	# interface it serves, electron/ the desktop shell. config.ROOT is the directory
	# that holds animator/ and web/, so the three stay together.
	insinto "${root}"
	doins -r animator web electron
	# doins drops the executable bit git tracks (electron/run.sh, for one).
	while IFS= read -r -d '' file; do
		fperms 0755 "${root}/${file}"
	done < <(find animator web electron -type f -perm -u+x -print0)
	python_optimize "${ED}${root}"

	newbin - animator <<-EOF
		#!/bin/sh
		ANIMATOR_ROOT=${root} exec /usr/bin/electron-${ELECTRON_SLOT} ${root}/electron "\$@"
	EOF

	domenu electron/animator.desktop
	newicon -s scalable electron/icons/animator.svg animator.svg
	for size in 16 32 48 64 128 256 512; do
		newicon -s ${size} electron/icons/animator-${size}.png animator.png
	done

	dodoc README.md
	dodoc -r docs
}

pkg_postinst() {
	xdg_pkg_postinst

	[[ -n ${EGIT_VERSION} ]] && elog "Installed Animator commit ${EGIT_VERSION}."
	elog "Start it from the application menu or with 'animator'. Studio data lives in"
	elog "~/.local/share/animator (or \$ANIMATOR_HOME)."
	elog "Directing the studio needs the Codex CLI (draws the images) and the Claude"
	elog "Code CLI (the director); dev-util/codex-bin and dev-util/claude-code package"
	elog "them in this overlay. They are not dependencies: install the ones you use."
}
