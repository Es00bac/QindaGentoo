#!/bin/sh
# Portage-owned launcher for the Claude desktop application.
# GTK can unload settings-selected modules during Chromium startup while their
# GIO callbacks remain queued (seen with app-misc/chatgpt-desktop on this
# desktop). Holding them in GTK_MODULES for the process lifetime prevents it.
for module in colorreload-gtk-module window-decorations-gtk-module appmenu-gtk-module; do
    if [ -f "/usr/lib64/gtk-3.0/modules/lib${module}.so" ]; then
        case ":${GTK_MODULES-}:" in
            *":${module}:"*) ;;
            *) GTK_MODULES="${GTK_MODULES:+${GTK_MODULES}:}${module}" ;;
        esac
    fi
done
export GTK_MODULES
# Native Wayland when available (needed for the GlobalShortcuts portal); X11 otherwise.
if [ -n "${WAYLAND_DISPLAY-}" ] && [ -z "${ELECTRON_OZONE_PLATFORM_HINT-}" ]; then
    export ELECTRON_OZONE_PLATFORM_HINT=auto
fi
# Chromium picks its credential store from XDG_CURRENT_DESKTOP and falls back to an
# unencrypted "basic" store on desktops it does not recognise, which disables Electron
# safeStorage (sign-in state and caches). Use the freedesktop Secret Service instead
# unless the caller chose a store explicitly.
store_given=no
for arg in "$@"; do
    case "$arg" in --password-store=*) store_given=yes ;; esac
done
if [ "$store_given" = no ]; then
    set -- --password-store=gnome-libsecret "$@"
fi
exec /opt/claude-desktop/claude-desktop "$@"
