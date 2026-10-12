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

The pinned source commit contains no project-wide license grant. Its public
GitHub location does not make it open source. The recipe conservatively uses
`all-rights-reserved` and restricts fetching, mirroring and binary distribution
until the owner explicitly supplies licensing terms. The host package does
not infer licenses from unrelated vendored Gradle or Espressif files.
