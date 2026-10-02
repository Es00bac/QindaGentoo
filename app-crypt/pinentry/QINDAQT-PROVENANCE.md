# Generic Secret Service dependency for Pinentry

This revision copies installed 1.3.2-r1 and changes only the GTK runtime's
hardcoded gnome-keyring dependency to virtual/secret-service. GTK/GCR, Qt6,
ncurses, optional libsecret caching, configure choices, patches and licenses
remain unchanged. The installed profile has keyring USE disabled; this revision
does not enable caching or access a user's credentials. The upstream GTK source
uses GCR's system prompt; optional caching is via libsecret. The existing GCR
prompt implementation is retained, not replaced by a fabricated native API.

Original recipe SHA256: f17f2cedec7a556e8b4d4d084ea3faa39ece4b3318978443f0aedc3220254536.
Revised recipe SHA256: 71f8de00d7df06e53adc65f1f2c0bc3bd5049349d98e6886b1f41babb15a8727.
Unmodified official archive `pinentry-1.3.2.tar.bz2`: 612858 bytes, SHA256
`8e986ed88561b4da6e9efe0c54fa4ca8923035c99264df0b0464497c5fb94e9e`.
BLAKE2B/SHA512 match original Gentoo Manifest; original optional signature row
is retained. verify-sig is not enabled in the observed preparation and its
signature was not separately qualified.

Preserved upstream patch SHA256:
- pinentry-1.0.0-AR.patch: `b0a121fb117a73475ed9df8c9298bb9567dcb1a4c9521f6ae2dac6e587e57515`
- pinentry-1.3.0-automagic.patch: `64a62f9dfc4f040abaf7a22d4585a253963bca60c4f1f4a350dd8d2584c90adf`

The native profile's provider is the packaged Desktop. Actual dependency
selection and a metadata pass do not prove GUI prompting, native Secret Service
registration or credential migration. Desktop/virtual ordinary runtime provider cycles
remain explicitly recorded; no host installation or credential operation is
part of this source candidate.

## Matching laptop revision

Laptop installed1.3.3 is preserved by a separate1.3.3-r1 recipe with the same
one generic GTK provider substitution; do not downgrade it to qinda's1.3.2-r2.
Original installed1.3.3 recipe SHA256: `3ee9339480d997443a1ab5a742c7025f624c3054881588e784a8de22119d716d`.
Candidate1.3.3-r1 SHA256: `3c4b552e5b50a40f622879b039174f3b3b463db5db8ec3cca4fda6f4b7ff5cbe`.
Official unchanged archive1.3.3: 620687bytes,
SHA256 `c2970f16d6afb66ecddfca767d743936c86239bff936eed7fd7597a678414b63`; original Gentoo BLAKE2B/SHA512 match.
The existing1.3.0-automagic patch is identical; newer upstream choices including
selinux USE and installed Qt/GCR configurations remain intact. Optional source
signature row is preserved; observed verify-sig remains OFF.
