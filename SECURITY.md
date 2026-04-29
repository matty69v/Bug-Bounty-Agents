# Security Policy

## Scope

This repository contains **prompt files** (Markdown) intended to be loaded
into LLM clients as system instructions. The agents themselves are not
executable software, but they instruct LLMs to perform offensive-security
tasks. Two classes of issue are in scope:

1. **Prompt safety** — wording that could cause an agent to act outside the
   user-declared scope, ignore authorization checks, exfiltrate user data,
   or assist with clearly illegal activity (CSAM, non-consensual targeting,
   weapons of mass destruction, etc.).
2. **Supply-chain integrity** — tampering with `install.sh`, CI workflows,
   templates, or shipped fixtures that could compromise users who clone
   this repo.

Out of scope: vulnerabilities in third-party LLM clients (Claude Code,
Copilot, Cursor, ChatGPT) — please report those upstream.

## Reporting

Please report vulnerabilities **privately** via GitHub Security Advisories:

> https://github.com/matty69v/Bug-Bounty-Agents/security/advisories/new

Include:

- Affected file(s) and line(s)
- Reproduction (the prompt input and the unsafe agent output, if applicable)
- Proposed fix or mitigation
- Your preferred attribution (or request anonymity)

Please do **not** open a public issue for security reports.

## Response Timeline

- Acknowledgement: within 72 hours
- Initial triage: within 7 days
- Fix or mitigation: best-effort, prioritized by severity

## Safe Harbor

Good-faith research into prompt safety issues in this repository is welcomed.
We will not pursue legal action against researchers who:

- Test only against their own LLM accounts
- Avoid privacy violations and disruption of others
- Report findings privately and give us reasonable time to respond
