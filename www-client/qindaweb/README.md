# Native browser package candidate

`qindaweb-0.1.0_alpha1.ebuild.in` is deliberately unready. The desktop manager
holds consolidated packaging until source qualification and an external installed
SDK consumer pass. Replace `@DESKTOP_SDK_ATOM@` with the manager's exact qualified
minimum dependency, then rename to `.ebuild`, generate its Manifest and qualify
the installed package before publishing a delivery entry.

The candidate pins QindaWeb code `82b091aa2f32570a1226ee135233d364242fa28b`, requires
QindaTK r13 and **exact QtWayland 6.11.1-r2**, and enables strict public SDK discovery.
The Qt patch is in `dev-qt/qtwayland/files/6.11.1-compositor-keyboard-resources-v2.patch`.
Portage built and installed r2 on qinda with the configured 24/24 build policy.
No public Qt ABI or object layout changed. The original recipe and r1 candidate
remain preserved; r2 includes explicit public modifier publication.

The source passed navigation/launch IPC/raw keyboard CTest gates and full private
QindaQt native browser suites at actual 100% and 150% scales. These cover ordinary
scan-code Gecko typing, exact same-client GTK/Mozilla listeners, web popups,
dismissible controls, global-menu wire activation and accepted tabs/splits with
actual desktop scene membership/geometry. See QindaWeb `docs/acceptance.md` for
binary identity and direct evidence.

The final native package must consume Portage-owned public headers, CMake config,
client SONAME 1 and protocol files from the desktop. Do not copy home/staged SDK
libraries into an installed browser or turn strict discovery off to deliver it.
The compositor's shared interactive selector is still pending; the tested local
four-side picker remains explicit. No new default-browser or desktop-session
configuration is part of this package.

Keep heavy compilation and native QA on qinda at low priority. The laptop is
reserved for media playback. Fetch its bare QindaWeb mirror from qinda before a
later laptop Portage install; a qinda-built binpkg is preferred.
