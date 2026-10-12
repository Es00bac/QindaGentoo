# SPDX-License-Identifier: GPL-2.0-only
EAPI=8

DESCRIPTION="Agent-facing local reverse engineering toolkit"
HOMEPAGE="https://github.com/morluto/rea"
SRC_URI="
	https://registry.npmjs.org/rea-agents/-/rea-agents-${PV}.tgz
	https://registry.npmjs.org/@babel/helper-string-parser/-/helper-string-parser-8.0.0.tgz
		-> rea-babel_helper-string-parser-8.0.0.tgz
	https://registry.npmjs.org/@babel/helper-validator-identifier/-/helper-validator-identifier-8.0.4.tgz
		-> rea-babel_helper-validator-identifier-8.0.4.tgz
	https://registry.npmjs.org/@babel/parser/-/parser-8.0.4.tgz -> rea-babel_parser-8.0.4.tgz
	https://registry.npmjs.org/@babel/types/-/types-8.0.4.tgz -> rea-babel_types-8.0.4.tgz
	https://registry.npmjs.org/@cfworker/json-schema/-/json-schema-4.1.1.tgz -> rea-cfworker_json-schema-4.1.1.tgz
	https://registry.npmjs.org/@clack/core/-/core-1.4.3.tgz -> rea-clack_core-1.4.3.tgz
	https://registry.npmjs.org/@clack/prompts/-/prompts-1.7.0.tgz -> rea-clack_prompts-1.7.0.tgz
	https://registry.npmjs.org/@electron/asar/-/asar-4.2.0.tgz -> rea-electron_asar-4.2.0.tgz
	https://registry.npmjs.org/commander/-/commander-13.1.0.tgz -> rea-electron_asar__commander-13.1.0.tgz
	https://registry.npmjs.org/@jridgewell/resolve-uri/-/resolve-uri-3.1.2.tgz -> rea-jridgewell_resolve-uri-3.1.2.tgz
	https://registry.npmjs.org/@jridgewell/sourcemap-codec/-/sourcemap-codec-1.6.0.tgz
		-> rea-jridgewell_sourcemap-codec-1.6.0.tgz
	https://registry.npmjs.org/@jridgewell/trace-mapping/-/trace-mapping-0.3.31.tgz
		-> rea-jridgewell_trace-mapping-0.3.31.tgz
	https://registry.npmjs.org/@lydell/node-pty/-/node-pty-1.1.0.tgz -> rea-lydell_node-pty-1.1.0.tgz
	https://registry.npmjs.org/@lydell/node-pty-linux-x64/-/node-pty-linux-x64-1.1.0.tgz
		-> rea-lydell_node-pty-linux-x64-1.1.0.tgz
	https://registry.npmjs.org/@modelcontextprotocol/client/-/client-2.3.1.tgz -> rea-modelcontextprotocol_client-2.3.1.tgz
	https://registry.npmjs.org/@modelcontextprotocol/core/-/core-2.3.1.tgz -> rea-modelcontextprotocol_core-2.3.1.tgz
	https://registry.npmjs.org/@modelcontextprotocol/server/-/server-2.3.1.tgz -> rea-modelcontextprotocol_server-2.3.1.tgz
	https://registry.npmjs.org/@pinojs/redact/-/redact-0.4.0.tgz -> rea-pinojs_redact-0.4.0.tgz
	https://registry.npmjs.org/@scalar/openapi-types/-/openapi-types-0.8.0.tgz -> rea-scalar_openapi-types-0.8.0.tgz
	https://registry.npmjs.org/@toon-format/toon/-/toon-2.3.1.tgz -> rea-toon-format_toon-2.3.1.tgz
	https://registry.npmjs.org/@xmldom/xmldom/-/xmldom-0.9.12.tgz -> rea-xmldom_xmldom-0.9.12.tgz
	https://registry.npmjs.org/@xterm/addon-serialize/-/addon-serialize-0.14.0.tgz -> rea-xterm_addon-serialize-0.14.0.tgz
	https://registry.npmjs.org/@xterm/headless/-/headless-6.0.0.tgz -> rea-xterm_headless-6.0.0.tgz
	https://registry.npmjs.org/@zip.js/zip.js/-/zip.js-2.15.0.tgz -> rea-zip.js_zip.js-2.15.0.tgz
	https://registry.npmjs.org/abort-controller/-/abort-controller-3.0.0.tgz -> rea-abort-controller-3.0.0.tgz
	https://registry.npmjs.org/ajv/-/ajv-8.20.0.tgz -> rea-ajv-8.20.0.tgz
	https://registry.npmjs.org/ajv-formats/-/ajv-formats-3.0.1.tgz -> rea-ajv-formats-3.0.1.tgz
	https://registry.npmjs.org/async-lock/-/async-lock-1.4.1.tgz -> rea-async-lock-1.4.1.tgz
	https://registry.npmjs.org/atomic-sleep/-/atomic-sleep-1.0.0.tgz -> rea-atomic-sleep-1.0.0.tgz
	https://registry.npmjs.org/available-typed-arrays/-/available-typed-arrays-1.0.7.tgz
		-> rea-available-typed-arrays-1.0.7.tgz
	https://registry.npmjs.org/balanced-match/-/balanced-match-4.0.4.tgz -> rea-balanced-match-4.0.4.tgz
	https://registry.npmjs.org/base64-js/-/base64-js-1.5.1.tgz -> rea-base64-js-1.5.1.tgz
	https://registry.npmjs.org/brace-expansion/-/brace-expansion-5.0.12.tgz -> rea-brace-expansion-5.0.12.tgz
	https://registry.npmjs.org/buffer/-/buffer-6.0.3.tgz -> rea-buffer-6.0.3.tgz
	https://registry.npmjs.org/call-bind/-/call-bind-1.0.9.tgz -> rea-call-bind-1.0.9.tgz
	https://registry.npmjs.org/call-bind-apply-helpers/-/call-bind-apply-helpers-1.0.2.tgz
		-> rea-call-bind-apply-helpers-1.0.2.tgz
	https://registry.npmjs.org/call-bound/-/call-bound-1.0.4.tgz -> rea-call-bound-1.0.4.tgz
	https://registry.npmjs.org/canonicalize/-/canonicalize-3.0.0.tgz -> rea-canonicalize-3.0.0.tgz
	https://registry.npmjs.org/clean-git-ref/-/clean-git-ref-2.0.1.tgz -> rea-clean-git-ref-2.0.1.tgz
	https://registry.npmjs.org/crc-32/-/crc-32-1.2.2.tgz -> rea-crc-32-1.2.2.tgz
	https://registry.npmjs.org/cross-spawn/-/cross-spawn-7.0.6.tgz -> rea-cross-spawn-7.0.6.tgz
	https://registry.npmjs.org/decompress-response/-/decompress-response-6.0.0.tgz -> rea-decompress-response-6.0.0.tgz
	https://registry.npmjs.org/define-data-property/-/define-data-property-1.1.4.tgz -> rea-define-data-property-1.1.4.tgz
	https://registry.npmjs.org/detect-libc/-/detect-libc-2.1.2.tgz -> rea-detect-libc-2.1.2.tgz
	https://registry.npmjs.org/diff/-/diff-9.0.0.tgz -> rea-diff-9.0.0.tgz
	https://registry.npmjs.org/diff3/-/diff3-0.0.3.tgz -> rea-diff3-0.0.3.tgz
	https://registry.npmjs.org/dunder-proto/-/dunder-proto-1.0.1.tgz -> rea-dunder-proto-1.0.1.tgz
	https://registry.npmjs.org/es-define-property/-/es-define-property-1.0.1.tgz -> rea-es-define-property-1.0.1.tgz
	https://registry.npmjs.org/es-errors/-/es-errors-1.3.0.tgz -> rea-es-errors-1.3.0.tgz
	https://registry.npmjs.org/es-object-atoms/-/es-object-atoms-1.1.2.tgz -> rea-es-object-atoms-1.1.2.tgz
	https://registry.npmjs.org/event-target-shim/-/event-target-shim-5.0.1.tgz -> rea-event-target-shim-5.0.1.tgz
	https://registry.npmjs.org/events/-/events-3.3.0.tgz -> rea-events-3.3.0.tgz
	https://registry.npmjs.org/eventsource/-/eventsource-3.0.7.tgz -> rea-eventsource-3.0.7.tgz
	https://registry.npmjs.org/eventsource-parser/-/eventsource-parser-3.1.0.tgz -> rea-eventsource-parser-3.1.0.tgz
	https://registry.npmjs.org/evmole/-/evmole-0.9.3.tgz -> rea-evmole-0.9.3.tgz
	https://registry.npmjs.org/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz -> rea-fast-deep-equal-3.1.3.tgz
	https://registry.npmjs.org/fast-string-truncated-width/-/fast-string-truncated-width-3.0.3.tgz
		-> rea-fast-string-truncated-width-3.0.3.tgz
	https://registry.npmjs.org/fast-string-width/-/fast-string-width-3.0.2.tgz -> rea-fast-string-width-3.0.2.tgz
	https://registry.npmjs.org/fast-uri/-/fast-uri-3.1.8.tgz -> rea-fast-uri-3.1.8.tgz
	https://registry.npmjs.org/fast-wrap-ansi/-/fast-wrap-ansi-0.2.2.tgz -> rea-fast-wrap-ansi-0.2.2.tgz
	https://registry.npmjs.org/for-each/-/for-each-0.3.5.tgz -> rea-for-each-0.3.5.tgz
	https://registry.npmjs.org/function-bind/-/function-bind-1.1.2.tgz -> rea-function-bind-1.1.2.tgz
	https://registry.npmjs.org/get-intrinsic/-/get-intrinsic-1.3.0.tgz -> rea-get-intrinsic-1.3.0.tgz
	https://registry.npmjs.org/get-proto/-/get-proto-1.0.1.tgz -> rea-get-proto-1.0.1.tgz
	https://registry.npmjs.org/glob/-/glob-13.0.6.tgz -> rea-glob-13.0.6.tgz
	https://registry.npmjs.org/gopd/-/gopd-1.2.0.tgz -> rea-gopd-1.2.0.tgz
	https://registry.npmjs.org/har-schema/-/har-schema-2.0.0.tgz -> rea-har-schema-2.0.0.tgz
	https://registry.npmjs.org/has-property-descriptors/-/has-property-descriptors-1.0.2.tgz
		-> rea-has-property-descriptors-1.0.2.tgz
	https://registry.npmjs.org/has-symbols/-/has-symbols-1.1.0.tgz -> rea-has-symbols-1.1.0.tgz
	https://registry.npmjs.org/has-tostringtag/-/has-tostringtag-1.0.2.tgz -> rea-has-tostringtag-1.0.2.tgz
	https://registry.npmjs.org/hasown/-/hasown-2.0.4.tgz -> rea-hasown-2.0.4.tgz
	https://registry.npmjs.org/ieee754/-/ieee754-1.2.1.tgz -> rea-ieee754-1.2.1.tgz
	https://registry.npmjs.org/ignore/-/ignore-7.0.6.tgz -> rea-ignore-7.0.6.tgz
	https://registry.npmjs.org/imurmurhash/-/imurmurhash-0.1.4.tgz -> rea-imurmurhash-0.1.4.tgz
	https://registry.npmjs.org/incur/-/incur-0.6.1.tgz -> rea-incur-0.6.1.tgz
	https://registry.npmjs.org/@modelcontextprotocol/server/-/server-2.0.0-alpha.4.tgz
		-> rea-incur__modelcontextprotocol_server-2.0.0-alpha.4.tgz
	https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz -> rea-inherits-2.0.4.tgz
	https://registry.npmjs.org/is-callable/-/is-callable-1.2.7.tgz -> rea-is-callable-1.2.7.tgz
	https://registry.npmjs.org/is-typed-array/-/is-typed-array-1.1.15.tgz -> rea-is-typed-array-1.1.15.tgz
	https://registry.npmjs.org/isarray/-/isarray-2.0.5.tgz -> rea-isarray-2.0.5.tgz
	https://registry.npmjs.org/isexe/-/isexe-2.0.0.tgz -> rea-isexe-2.0.0.tgz
	https://registry.npmjs.org/isomorphic-git/-/isomorphic-git-1.38.7.tgz -> rea-isomorphic-git-1.38.7.tgz
	https://registry.npmjs.org/ignore/-/ignore-5.3.2.tgz -> rea-isomorphic-git__ignore-5.3.2.tgz
	https://registry.npmjs.org/jose/-/jose-6.2.3.tgz -> rea-jose-6.2.3.tgz
	https://registry.npmjs.org/json-schema-traverse/-/json-schema-traverse-1.0.0.tgz -> rea-json-schema-traverse-1.0.0.tgz
	https://registry.npmjs.org/jsonc-parser/-/jsonc-parser-3.3.1.tgz -> rea-jsonc-parser-3.3.1.tgz
	https://registry.npmjs.org/lossless-json/-/lossless-json-4.3.1.tgz -> rea-lossless-json-4.3.1.tgz
	https://registry.npmjs.org/lru-cache/-/lru-cache-11.5.2.tgz -> rea-lru-cache-11.5.2.tgz
	https://registry.npmjs.org/math-intrinsics/-/math-intrinsics-1.1.0.tgz -> rea-math-intrinsics-1.1.0.tgz
	https://registry.npmjs.org/mimic-response/-/mimic-response-3.1.0.tgz -> rea-mimic-response-3.1.0.tgz
	https://registry.npmjs.org/minimatch/-/minimatch-10.2.5.tgz -> rea-minimatch-10.2.5.tgz
	https://registry.npmjs.org/minimist/-/minimist-1.2.8.tgz -> rea-minimist-1.2.8.tgz
	https://registry.npmjs.org/minimisted/-/minimisted-2.0.1.tgz -> rea-minimisted-2.0.1.tgz
	https://registry.npmjs.org/minipass/-/minipass-7.1.3.tgz -> rea-minipass-7.1.3.tgz
	https://registry.npmjs.org/on-exit-leak-free/-/on-exit-leak-free-2.1.2.tgz -> rea-on-exit-leak-free-2.1.2.tgz
	https://registry.npmjs.org/once/-/once-1.4.0.tgz -> rea-once-1.4.0.tgz
	https://registry.npmjs.org/pako/-/pako-1.0.11.tgz -> rea-pako-1.0.11.tgz
	https://registry.npmjs.org/parse5/-/parse5-8.0.1.tgz -> rea-parse5-8.0.1.tgz
	https://registry.npmjs.org/entities/-/entities-8.1.0.tgz -> rea-parse5__entities-8.1.0.tgz
	https://registry.npmjs.org/path-key/-/path-key-3.1.1.tgz -> rea-path-key-3.1.1.tgz
	https://registry.npmjs.org/path-scurry/-/path-scurry-2.0.2.tgz -> rea-path-scurry-2.0.2.tgz
	https://registry.npmjs.org/pify/-/pify-4.0.1.tgz -> rea-pify-4.0.1.tgz
	https://registry.npmjs.org/pino/-/pino-10.4.0.tgz -> rea-pino-10.4.0.tgz
	https://registry.npmjs.org/pino-abstract-transport/-/pino-abstract-transport-3.0.0.tgz
		-> rea-pino-abstract-transport-3.0.0.tgz
	https://registry.npmjs.org/pino-std-serializers/-/pino-std-serializers-7.1.0.tgz -> rea-pino-std-serializers-7.1.0.tgz
	https://registry.npmjs.org/pkce-challenge/-/pkce-challenge-5.0.1.tgz -> rea-pkce-challenge-5.0.1.tgz
	https://registry.npmjs.org/playwright-core/-/playwright-core-1.58.2.tgz -> rea-playwright-core-1.58.2.tgz
	https://registry.npmjs.org/plist/-/plist-5.0.0.tgz -> rea-plist-5.0.0.tgz
	https://registry.npmjs.org/possible-typed-array-names/-/possible-typed-array-names-1.1.0.tgz
		-> rea-possible-typed-array-names-1.1.0.tgz
	https://registry.npmjs.org/process/-/process-0.11.10.tgz -> rea-process-0.11.10.tgz
	https://registry.npmjs.org/process-warning/-/process-warning-5.0.0.tgz -> rea-process-warning-5.0.0.tgz
	https://registry.npmjs.org/quick-format-unescaped/-/quick-format-unescaped-4.0.4.tgz
		-> rea-quick-format-unescaped-4.0.4.tgz
	https://registry.npmjs.org/readable-stream/-/readable-stream-4.7.0.tgz -> rea-readable-stream-4.7.0.tgz
	https://registry.npmjs.org/real-require/-/real-require-1.0.0.tgz -> rea-real-require-1.0.0.tgz
	https://registry.npmjs.org/require-from-string/-/require-from-string-2.0.2.tgz -> rea-require-from-string-2.0.2.tgz
	https://registry.npmjs.org/safe-buffer/-/safe-buffer-5.2.1.tgz -> rea-safe-buffer-5.2.1.tgz
	https://registry.npmjs.org/safe-stable-stringify/-/safe-stable-stringify-2.5.0.tgz
		-> rea-safe-stable-stringify-2.5.0.tgz
	https://registry.npmjs.org/semver/-/semver-7.8.5.tgz -> rea-semver-7.8.5.tgz
	https://registry.npmjs.org/set-function-length/-/set-function-length-1.2.2.tgz -> rea-set-function-length-1.2.2.tgz
	https://registry.npmjs.org/sha.js/-/sha.js-2.4.12.tgz -> rea-sha.js-2.4.12.tgz
	https://registry.npmjs.org/shebang-command/-/shebang-command-2.0.0.tgz -> rea-shebang-command-2.0.0.tgz
	https://registry.npmjs.org/shebang-regex/-/shebang-regex-3.0.0.tgz -> rea-shebang-regex-3.0.0.tgz
	https://registry.npmjs.org/signal-exit/-/signal-exit-4.1.0.tgz -> rea-signal-exit-4.1.0.tgz
	https://registry.npmjs.org/simple-concat/-/simple-concat-1.0.1.tgz -> rea-simple-concat-1.0.1.tgz
	https://registry.npmjs.org/simple-get/-/simple-get-4.0.1.tgz -> rea-simple-get-4.0.1.tgz
	https://registry.npmjs.org/sisteransi/-/sisteransi-1.0.5.tgz -> rea-sisteransi-1.0.5.tgz
	https://registry.npmjs.org/smol-toml/-/smol-toml-1.9.0.tgz -> rea-smol-toml-1.9.0.tgz
	https://registry.npmjs.org/sonic-boom/-/sonic-boom-4.2.1.tgz -> rea-sonic-boom-4.2.1.tgz
	https://registry.npmjs.org/split2/-/split2-4.2.0.tgz -> rea-split2-4.2.0.tgz
	https://registry.npmjs.org/stream-chain/-/stream-chain-4.2.6.tgz -> rea-stream-chain-4.2.6.tgz
	https://registry.npmjs.org/stream-json/-/stream-json-3.7.0.tgz -> rea-stream-json-3.7.0.tgz
	https://registry.npmjs.org/string_decoder/-/string_decoder-1.3.0.tgz -> rea-string_decoder-1.3.0.tgz
	https://registry.npmjs.org/thread-stream/-/thread-stream-4.2.0.tgz -> rea-thread-stream-4.2.0.tgz
	https://registry.npmjs.org/to-buffer/-/to-buffer-1.2.2.tgz -> rea-to-buffer-1.2.2.tgz
	https://registry.npmjs.org/tokenx/-/tokenx-1.3.0.tgz -> rea-tokenx-1.3.0.tgz
	https://registry.npmjs.org/typed-array-buffer/-/typed-array-buffer-1.0.3.tgz -> rea-typed-array-buffer-1.0.3.tgz
	https://registry.npmjs.org/which/-/which-2.0.2.tgz -> rea-which-2.0.2.tgz
	https://registry.npmjs.org/which-typed-array/-/which-typed-array-1.1.22.tgz -> rea-which-typed-array-1.1.22.tgz
	https://registry.npmjs.org/wrappy/-/wrappy-1.0.2.tgz -> rea-wrappy-1.0.2.tgz
	https://registry.npmjs.org/write-file-atomic/-/write-file-atomic-7.0.0.tgz -> rea-write-file-atomic-7.0.0.tgz
	https://registry.npmjs.org/ws/-/ws-8.21.0.tgz -> rea-ws-8.21.0.tgz
	https://registry.npmjs.org/xmlbuilder/-/xmlbuilder-15.1.1.tgz -> rea-xmlbuilder-15.1.1.tgz
	https://registry.npmjs.org/yaml/-/yaml-2.9.0.tgz -> rea-yaml-2.9.0.tgz
	https://registry.npmjs.org/zod/-/zod-4.4.3.tgz -> rea-zod-4.4.3.tgz
"

LICENSE="MIT ISC Apache-2.0 BSD BSD-2 BlueOak-1.0.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${P}"
RESTRICT="test"

RDEPEND=">=net-libs/nodejs-22.19.0"

src_unpack() {
	mkdir -p "${S}" || die
	tar -xzf "${DISTDIR}/${P}.tgz" -C "${S}" --strip-components=1 || die
	local module archive
	while IFS=$'\t' read -r module archive; do
		mkdir -p "${S}/${module}" || die
		tar -xzf "${DISTDIR}/${archive}" -C "${S}/${module}" --strip-components=1 || die "Failed to unpack ${archive}"
	done < "${FILESDIR}/production-dependencies.tsv"
}

src_install() {
	insinto /usr/lib/rea-agents
	doins -r "${S}/dist" "${S}/scripts" "${S}/bridge" "${S}/skills"
	doins -r "${S}/node_modules" "${S}/third_party" "${S}/licenses"
	doins "${S}/package.json" "${S}/README.md" "${S}/LICENSE"
	newbin "${FILESDIR}/rea-wrapper" rea
}
