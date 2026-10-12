# QindaFox Agent on Gentoo

Portage owns the CLI, native messaging host, extension assets and plugin under
`/usr/share/qindafox-agent`. Do not run the upstream `scripts/install.py`:
it would install a second copy outside Portage. No service, browser profile,
Codex registration, credential file or model is created by this package.

To use an existing browser, open `about:debugging#/runtime/this-firefox`, choose
**Load Temporary Add-on**, and select
`/usr/share/qindafox-agent/extension/manifest.json`. This explicitly grants the
loaded extension access to this package's native host. Ordinary Firefox needs
Mozilla signing for permanent extension installation; the supplied XPI is an
unsigned development build. Keep browser signing policy intact.

Then run `qindafox-agent sessions` and select the intended session/tab. Enabling
the optional `launcher` USE flag adds `qindafox-agent-launch` and the Portage
geckodriver dependency for an isolated temporary browser. It uses the QindaFox
engine directly or Firefox; it does not inherit an everyday profile's logins.
The native host manifest is installed for both Gentoo and prebuilt Firefox.
The host starts only when the explicitly loaded extension requests it.

MCP clients can explicitly register `/usr/bin/qindafox-agent-mcp` as a stdio
server. The complete plugin manifest and skill are under
`/usr/share/qindafox-agent`; registering them is user configuration. Existing
per-user wrappers, native manifests, and plugin registrations are preserved.
A prior user native manifest takes precedence; remove or update that personal
registration deliberately if it still points at a checkout.

Direct browser operations do not call a model. Optional Jev decisions require
an existing key on the selected host and `qindafox-agent-jev` from this same
Portage package on that host. `QINDAFOX_JEV_HOST` selects the SSH host (`local`
skips SSH); the default is local on qinda and SSH to qinda elsewhere. Credential
configuration remains upstream's `~/Adulting/api-keys.env`; never include it in
an archive or copy it to a client. Jev sends observed text and the caller's goal
to TypeSafe. No Jev connection or credential lookup is performed at install.

Package checks exercise framing and MCP fixtures only. Browser behavior and
optional external-model behavior require separately chosen live sessions.
