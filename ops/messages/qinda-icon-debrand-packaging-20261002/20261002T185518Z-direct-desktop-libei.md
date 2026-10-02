# Direct desktop libei dependency

2026-10-02T18:55:18Z

Manager requested the only product addition `dev-libs/libei:=` in desktop RDEPEND; inherited DEPEND covers compilation. Exact source `738340091c6816c7355eb93d9471a2ba93799ac5` has `src/services/portal/remote_input/CMakeLists.txt` requiring pkg-config `libei-1.0` and linking `PkgConfig::QINDAQT_LIBEI`. Desktop therefore declares its own direct library dependency even though the fork already depends on libei. No source pins changed; final qualified manager source remains pending.

`bash -n gui-wm/qindaqt-desktop/qindaqt-desktop-0.1.0_pre20261002.ebuild` exit0; working diff-check exit0. Product change is exactly one dependency line; own board/thread updated. Laptop lock absent at preflight; manager now authorizes its read-only solver replay only, still no install/build/host configuration change. The exact new candidate will be committed before replay and the actual result recorded separately.
