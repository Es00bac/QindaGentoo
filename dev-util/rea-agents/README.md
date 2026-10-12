# REA package provenance

Version 6.4.0 is assembled from the published npm package and the 144
production tarballs listed in `files/production-dependencies.tsv`. The list
comes from upstream `package-lock.json` at commit
`fdd8f826023c568937d237c2f97d855de283a9b8`. Each downloaded dependency
archive was checked against that lockfile's integrity digest before the
Portage Manifest was committed. The optional Linux x64 node-pty binary is
included; Frida is omitted because native binary analysis uses Ghidra.

No npm install step runs during the package build or on the host. Portage owns
all files under `/usr/lib/rea-agents` and `/usr/bin/rea`.
