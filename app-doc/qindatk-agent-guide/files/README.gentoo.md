# QindaTK agent guide on Gentoo

This optional package installs the reviewed static website below
`/usr/share/doc/qindatk-agent-guide-0.1.0_p20261012/html`. Existing interfaces
and proposed interfaces retain their labels; the demonstrations use fictional
local data and cannot operate a running application.

ES modules need an HTTP origin. Use an already installed local web server, or
an installed Python interpreter, when you choose to read the guide:

```sh
python3 -m http.server --bind 127.0.0.1 --directory /usr/share/doc/qindatk-agent-guide-0.1.0_p20261012/html 8088
```

Then visit `http://127.0.0.1:8088/` and stop the server when finished. Portage
installs no server, daemon, auto-start entry or hosting configuration. The
existing narration and film are packaged data; reading the guide needs no
model/API key and never regenerates speech. `html/sources.md` preserves the
LGPL-3+ code/text and GPL-3+ reused media provenance.
