# Native locker PAM policy candidate

- Timestamp: 2026-10-07T14:43:39.161711+00:00
- Base: `62d4ca4415e73bab95ae53abe6855dc305ecf693`
- Outcome: existing native locker reaches the site's mandatory authentication conversation instead of missing-service deny-all fallback.
- Both hosts lack the fixed named PAM service. Laptop default `other` requires pam_deny for every group; compositor NoNewPrivs is zero and unix_chkpwd is root:shadow 02755.
- Ownership: new sys-auth/qindaqt-lock-pam package, categories/profile/delivery and primary overlay README. Historical desktop recipes and binaries remain immutable.
- Review/acceptance next: independent exact recipe/PAM stack review; private missing-service reproduction and positive conversation gates from Unlock Repair Codex; Portage build-only signed artifact and image inspection before only-policy installation.
