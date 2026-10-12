# QindaDeck host tools on Gentoo

This optional package installs `deckctl`, the protocol JSON schema under
`/usr/share/qindadeck`, and protocol/hardware documentation. It does not build
or install the Android app or ESP32 firmware, flash a device, deploy udev rules,
start a daemon, discover hardware, or change desktop defaults.

Use an explicitly chosen device, for example `deckctl --host ADDRESS status`.
The optional `zeroconf` USE flag adds Python mDNS discovery when no address is
given. Without it, the helper can also use an already installed `avahi-browse`;
otherwise pass `--host`. Installing the package performs no discovery.
Commands can send input to a host, alter profiles, reboot the deck and modify
SD files. Run only the specific action you intend on the chosen device.

The pinned source licenses original code GPL-3.0-or-later. This host package
installs only original CLI/schema/documentation files. The source archive's
uninstalled Gradle wrappers retain Apache-2.0 terms and its Espressif HID GAP
implementation retains Unlicense OR CC0-1.0. The installed upstream README and
LICENSE preserve the full grant and third-party provenance; external Android
and ESP-IDF dependencies are not relicensed or installed by this package.
