c<div align="center">

# Bug-Bounty-Agents

**A curated arsenal of specialized AI agent prompts for bug bounty hunting,
penetration testing, and offensive security workflows.**

[![License: MIT](https://img.shields.io/badge/license-MIT-black?style=flat-square)](LICENSE)
[![Agents](https://img.shields.io/badge/agents-43-black?style=flat-square)](AGENTS.md)
[![Platform](https://img.shields.io/badge/platform-Claude%20%7C%20Copilot%20%7C%20Cursor%20%7C%20ChatGPT-black?style=flat-square)](#per-tool-setup)
[![CI](https://img.shields.io/badge/CI-link--check%20%2B%20shellcheck-black?style=flat-square)](.github/workflows/lint.yml)
[![Status](https://img.shields.io/badge/status-active-black?style=flat-square)](#)

[Quick Start](#quick-start) · [Catalog](#agent-catalog) · [Setup](#per-tool-setup) · [Workflows](#workflows) · [Examples](examples/) · [Contributing](CONTRIBUTING.md) · [Disclaimer](#disclaimer)

</div>

---

## Overview

Each `.md` file in this repository defines a focused, production-ready agent
persona — recon, web hunting, exploit chaining, reporting, and more — that
you can drop into **Claude Code**, **GitHub Copilot Chat**, **Cursor**, or
any agent-capable LLM client.

No frameworks. No dependencies. Just disciplined prompts that turn a generic
LLM into a specialist, with strict scope enforcement built in.

> **These are prompts, not scanners.** They make an LLM act like a
> specialist; they do not bring their own tooling. You still drive the
> engagement.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Agent Catalog](#agent-catalog)
3. [Prerequisites](#prerequisites)
4. [Per-Tool Setup](#per-tool-setup)
   - [One-line installer](#one-line-installer)
   - [Claude Code](#claude-code-manual)
   - [GitHub Copilot Chat](#github-copilot-chat-vs-code-manual)
   - [Cursor](#cursor-manual)
   - [ChatGPT / Gemini / Generic](#chatgpt--gemini--generic)
5. [Using an Agent](#using-an-agent)
6. [Workflows](#workflows)
7. [Examples](#examples)
8. [Burp Suite MCP Integration](#burp-suite-mcp-integration)
9. [Updating](#updating)
10. [Project Files](#project-files)
11. [Contributing](#contributing)
12. [Security](#security)
13. [Disclaimer](#disclaimer)

---

## Quick Start

```bash
git clone https://github.com/matty69v/Bug-Bounty-Agents.git
cd Bug-Bounty-Agents
./install.sh                     # auto-detects your client(s)
```

Or pick a specific target:

```bash
./install.sh --target claude         # Claude Code (global)
./install.sh --target claude-local   # Claude Code (this project)
./install.sh --target copilot        # Copilot Chat (VS Code)
./install.sh --target cursor         # Cursor (this project)
./install.sh --target all            # everything detected
./install.sh --dry-run --target claude
./install.sh --uninstall --target claude
```

---

## Agent Catalog

Agents are grouped by phase of an offensive engagement. The full
machine-readable index lives in [AGENTS.md](AGENTS.md).

### Reconnaissance & Intelligence

| Agent | Purpose |
|---|---|
| [`recon-advisor`](recon-advisor.md) | Surface enumeration and asset discovery |
| [`osint-collector`](osint-collector.md) | Open-source intelligence gathering |
| [`subdomain-takeover`](subdomain-takeover.md) | Dangling DNS and subdomain takeover validation |
| [`threat-modeler`](threat-modeler.md) | STRIDE / attack-surface modeling |
| [`engagement-planner`](engagement-planner.md) | Scope, rules of engagement, test plans |
| [`attack-planner`](attack-planner.md) | Multi-stage attack path planning |

### Web, API & Application

| Agent | Purpose |
|---|---|
| [`web-hunter`](web-hunter.md) | Web application vulnerability hunting |
| [`api-security`](api-security.md) | REST and GraphQL API testing |
| [`graphql-hunter`](graphql-hunter.md) | Schema introspection, authz, complexity attacks |
| [`bizlogic-hunter`](bizlogic-hunter.md) | Business logic flaws and abuse cases |
| [`ssrf-hunter`](ssrf-hunter.md) | SSRF discovery, filter bypass, cloud-metadata abuse |
| [`jwt-cracker`](jwt-cracker.md) | JWT / OIDC token attacks (alg confusion, kid/jku, weak HMAC) |
| [`vuln-scanner`](vuln-scanner.md) | Automated scanning orchestration and triage |

### Infrastructure, Cloud & Network

| Agent | Purpose |
|---|---|
| [`cloud-security`](cloud-security.md) | AWS / GCP / Azure misconfiguration hunting |
| [`container-escape`](container-escape.md) | Docker / Kubernetes pod-to-node-to-cluster breakout |
| [`cicd-redteam`](cicd-redteam.md) | CI/CD pipeline and supply-chain attacks |
| [`ad-attacker`](ad-attacker.md) | Active Directory enumeration and abuse |
| [`wireless-pentester`](wireless-pentester.md) | Wi-Fi, Bluetooth, and RF assessments |
| [`mobile-pentester`](mobile-pentester.md) | iOS / Android application testing |
| [`hardware-hacker`](hardware-hacker.md) | Embedded, JTAG, firmware extraction |

### Exploitation & Post-Ex

| Agent | Purpose |
|---|---|
| [`exploit-chainer`](exploit-chainer.md) | Combine findings into impactful chains |
| [`exploit-guide`](exploit-guide.md) | Step-by-step exploitation reference |
| [`payload-crafter`](payload-crafter.md) | Custom payload generation and tuning |
| [`binary-exploit`](binary-exploit.md) | Memory corruption, ROP, pwn |
| [`crypto-analyst`](crypto-analyst.md) | Crypto primitive and protocol analysis |
| [`credential-tester`](credential-tester.md) | Password spraying, stuffing, brute force |
| [`privesc-advisor`](privesc-advisor.md) | Linux / Windows privilege escalation paths |
| [`poc-validator`](poc-validator.md) | Verify, stabilize, and minimize PoCs |
| [`red-team-operator`](red-team-operator.md) | C2, OPSEC, long-haul operations |

### Specialized & Adversarial

| Agent | Purpose |
|---|---|
| [`llm-redteam`](llm-redteam.md) | Prompt injection, tool abuse, RAG poisoning, agent loops |
| [`phishing-operator`](phishing-operator.md) | Phishing infrastructure and campaign design |
| [`social-engineer`](social-engineer.md) | Pretexting, vishing, human-layer attacks |
| [`malware-analyst`](malware-analyst.md) | Static and dynamic malware analysis |
| [`reverse-engineer`](reverse-engineer.md) | Binary RE, decompilation, patching |
| [`forensics-analyst`](forensics-analyst.md) | DFIR, artifact analysis, timeline building |
| [`ctf-solver`](ctf-solver.md) | CTF challenge solver across categories |

### Defense, Reporting & Orchestration

| Agent | Purpose |
|---|---|
| [`detection-engineer`](detection-engineer.md) | Detection and response engineering |
| [`purple-team`](purple-team.md) | Detection-as-you-attack collaboration |
| [`stig-analyst`](stig-analyst.md) | STIG / CIS / compliance hardening review |
| [`report-generator`](report-generator.md) | Triage-ready bug bounty reports |
| [`bug-bounty`](bug-bounty.md) | General-purpose bounty assistant |
| [`swarm-orchestrator`](swarm-orchestrator.md) | Coordinate multiple agents in parallel |
| [`_scope-guard`](_scope-guard.md) | Hard scope enforcement layered on any agent |

---

## Prerequisites

- `git` and `bash` installed on your machine
- An LLM client that supports custom system prompts or instruction files:
  - [Claude Code](https://claude.com/claude-code)
  - [GitHub Copilot Chat](https://github.com/features/copilot) (VS Code)
  - [Cursor](https://cursor.sh/)
  - ChatGPT (Custom GPTs / Projects), Gemini, or any chat UI accepting a system prompt

---

## Per-Tool Setup

### One-line installer

```bash
./install.sh           # interactive — detects what you have
./install.sh --help    # see all options
```

The installer auto-detects `claude`, `code`, and `cursor` on your `PATH`,
copies agents to the correct directory for each, and renames files
appropriately (e.g. `.chatmode.md` for Copilot). Use `--dry-run` to
preview, `--uninstall` to remove.

### Claude Code (manual)

Claude Code reads agent definitions from `~/.claude/agents/` (global) or
`.claude/agents/` (per-project).

```bash
# Global
mkdir -p ~/.claude/agents && cp *.md ~/.claude/agents/

# Per-project
mkdir -p .claude/agents && cp /path/to/Bug-Bounty-Agents/*.md .claude/agents/
```

```text
/agents
> use the web-hunter agent to audit https://target.example.com
```

### GitHub Copilot Chat VS Code (manual)

Copilot Chat supports custom **chat modes** via `.chatmode.md` files.

```bash
# macOS
PROMPTS_DIR="$HOME/Library/Application Support/Code/User/prompts"
# Linux:   PROMPTS_DIR="$HOME/.config/Code/User/prompts"
# Windows: %APPDATA%\Code\User\prompts

mkdir -p "$PROMPTS_DIR"
for f in *.md; do
  cp "$f" "$PROMPTS_DIR/$(basename "$f" .md).chatmode.md"
done
```

Reload VS Code, then select the mode from the Copilot Chat dropdown.

### Cursor (manual)

```bash
cd /your/project
mkdir -p .cursor/rules
cp /path/to/Bug-Bounty-Agents/*.md .cursor/rules/
```

Each file becomes a selectable rule in Cursor's chat panel.

### ChatGPT / Gemini / Generic

Open the agent file, copy its full contents, and paste into:

- **ChatGPT** — Custom GPT → Instructions, or Project → Instructions
- **Gemini** — Gem instructions
- **Open WebUI / LM Studio** — System prompt field
- **API clients** — `system` role message

---

## Using an Agent

Once installed, give the agent a concrete target and scope:

```text
Target: https://staging.acme.example.com
Scope:  *.acme.example.com (in scope), *.thirdparty.example.com (out)
Goal:   Find auth bypass and IDOR on /api/v2/users endpoints.
```

Well-behaved agents will:

- Ask clarifying questions before acting
- Stay strictly within scope
- Produce reproducible PoCs
- Output triage-ready findings with severity and impact

---

## Workflows

Use `swarm-orchestrator` or `attack-planner` to coordinate a full engagement:

```text
  recon-advisor      ──▶  enumerate attack surface
                              │
                              ▼
  web-hunter / api-security  ──▶  find vulnerabilities
                              │
                              ▼
  exploit-chainer    ──▶  escalate impact
                              │
                              ▼
  poc-validator      ──▶  confirm and stabilize
                              │
                              ▼
  report-generator   ──▶  write the submission
```

Layer `_scope-guard` on top of any agent to enforce hard scope boundaries
during long-running sessions. For purple-team work, run `red-team-operator`
and `purple-team` side by side.

---

## Examples

End-to-end engagement walkthroughs (sanitized) live in [`examples/`](examples/):

- [`web-bug-bounty.md`](examples/web-bug-bounty.md) — recon → web-hunter →
  bizlogic → chain → validate → report, ending in a Critical-tier
  HackerOne submission.

---

## Burp Suite MCP Integration

[PortSwigger's MCP Server](https://github.com/PortSwigger/mcp-server) lets
your LLM client drive Burp Suite directly — issue requests through the
proxy, query Repeater/Intruder, read site maps, and pivot off live traffic
while an agent in this repo provides the methodology.

> **Pairing tip:** load `web-hunter`, `api-security`, `ssrf-hunter`, or
> `bizlogic-hunter` alongside the Burp MCP so the agent can both *think*
> like a specialist and *act* through Burp.

### Prerequisites

- Burp Suite (Community or Professional) installed and running
- Java available on `PATH` (`java --version`)
- `jar` available on `PATH` (`jar --version`) — required to build
- An MCP-capable client (Claude Desktop, Claude Code, Cursor, etc.)

### Build the extension

```bash
git clone https://github.com/PortSwigger/mcp-server.git
cd mcp-server
./gradlew embedProxyJar
# output: build/libs/burp-mcp-all.jar
```

### Load into Burp Suite

1. Launch Burp Suite.
2. Go to **Extensions → Add**.
3. Set **Extension Type** to `Java`.
4. Select `build/libs/burp-mcp-all.jar` and click **Next**.
5. Open the new **MCP** tab and tick **Enabled**.
   - Optional: enable *tools that can edit your config* if you trust the client.
   - Default listener: `http://127.0.0.1:9876`.

### Wire up your MCP client

**Claude Desktop (auto):** in the Burp MCP tab, click the installer button —
it writes the config for you. Restart Claude Desktop.

**Claude Desktop (manual):** edit
`~/Library/Application Support/Claude/claude_desktop_config.json` (macOS) or
`%APPDATA%\Claude\claude_desktop_config.json` (Windows):

```json
{
  "mcpServers": {
    "burp": {
      "command": "/path/to/burp/jre/bin/java",
      "args": [
        "-jar",
        "/path/to/mcp-proxy-all.jar",
        "--sse-url",
        "http://127.0.0.1:9876"
      ]
    }
  }
}
```

Use the Burp MCP tab's installer to extract `mcp-proxy-all.jar` if you
don't already have it.

**SSE-capable clients (Cursor, Claude Code, custom):** point them straight
at the SSE endpoint — no proxy needed:

```text
http://127.0.0.1:9876/sse
```

### Smoke test

With Burp running, the extension loaded, and your client restarted, ask:

```text
Use the burp MCP to list the last 10 requests in the proxy history,
then pick anything that looks like an authenticated API call.
```

If the client returns live traffic from your Burp session, you're wired up.

---

## Updating

```bash
cd ~/path/to/Bug-Bounty-Agents
git pull
./install.sh         # re-runs install with the latest agents
```

---

## Project Files

| File | Purpose |
|---|---|
| [`README.md`](README.md) | This file |
| [`AGENTS.md`](AGENTS.md) | Machine-readable index (phase, ATT&CK tactic, risk tier) |
| [`CHANGELOG.md`](CHANGELOG.md) | Version history |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | How to add or update agents |
| [`SECURITY.md`](SECURITY.md) | How to report prompt-safety issues |
| [`LICENSE`](LICENSE) | MIT |
| [`install.sh`](install.sh) | Auto-detecting installer |
| [`templates/AGENT_TEMPLATE.md`](templates/AGENT_TEMPLATE.md) | Boilerplate for new agents |
| [`examples/`](examples/) | Sanitized engagement walkthroughs |
| [`.github/`](.github/) | Issue / PR templates and CI |

---

## Contributing

PRs and issues are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for the
contribution workflow, agent template, and style guide. Use the issue
templates for bug reports and new-agent proposals.

---

## Security

Found a prompt-safety or supply-chain issue? See [SECURITY.md](SECURITY.md)
and report privately via GitHub Security Advisories.

---

## Disclaimer

> These agents are intended for **authorized security testing only** —
> bug bounty programs you are enrolled in, systems you own, or environments
> where you have explicit written permission to test.
>
> Unauthorized testing is illegal in most jurisdictions. You alone are
> responsible for how you use these prompts.

---

<div align="center">

**Repository** · [github.com/matty69v/Bug-Bounty-Agents](https://github.com/matty69v/Bug-Bounty-Agents)

</div>
