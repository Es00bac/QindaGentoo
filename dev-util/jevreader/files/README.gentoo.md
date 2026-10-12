# JevReader on Gentoo

Portage owns the Python modules and `jevreader` / `jevreader-mcp` wrappers.
This optional developer package does not edit opencode/Codex configuration,
start a service, install weights or retrieve credentials. To use MCP, explicitly
register `/usr/bin/jevreader-mcp` as a stdio server in your chosen client.

`jevreader outline ROOT` is local and does not contact a model. The `files`,
`find` and `read` operations can send task text and source previews to TypeSafe
through the configured SSH host. Upstream defaults to SSH host `qinda` with
its existing `~/Adulting/api-keys.env`; `JEV_READER_HOST` chooses another host.
A remote Python interpreter, SSH/key setup and consent for the supplied data
remain user configuration, outside the package. The API key is read remotely
and is never installed or copied to this machine.

`JEV_READER_FAKE=1` selects an offline word-overlap fixture, not model inference.
It is mandatory for package tests. Package staging and metadata checks do not
qualify external-model accuracy, availability or a live agent workflow.
