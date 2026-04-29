<div align="center">

# Bug-Bounty-Agents

**A curated arsenal of specialized AI agent prompts for bug bounty hunting,
penetration testing, and offensive security workflows.**

[![License](https://img.shields.io/badge/license-MIT-black?style=flat-square)](LICENSE)
[![Agents](https://img.shields.io/badge/agents-38-black?style=flat-square)](#agent-catalog)
[![Platform](https://img.shields.io/badge/platform-Claude%20%7C%20Copilot%20%7C%20Cursor%20%7C%20ChatGPT-black?style=flat-square)](#per-tool-setup)
[![Status](https://img.shields.io/badge/status-active-black?style=flat-square)](#)

[Quick Start](#quick-start) · [Agent Catalog](#agent-catalog) · [Per-Tool Setup](#per-tool-setup) · [Workflows](#workflows) · [Disclaimer](#disclaimer)

</div>

---

## Overview

Each `.md` file in this repository defines a focused, production-ready agent
persona — recon, web hunting, exploit chaining, reporting, and more — that
you can drop into **Claude Code**, **GitHub Copilot Chat**, **Cursor**, or
any agent-capable LLM client.

No frameworks. No dependencies. Just disciplined prompts that turn a generic
LLM into a specialist.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Agent Catalog](#agent-catalog)
3. [Prerequisites](#prerequisites)
4. [Per-Tool Setup](#per-tool-setup)
   - [Claude Code](#claude-code)
   - [GitHub Copilot Chat](#github-copilot-chat-vs-code)
   - [Cursor](#cursor)
   - [ChatGPT / Gemini / Generic](#chatgpt--gemini--generic)
5. [Using an Agent](#using-an-agent)
6. [Workflows](#workflows)
7. [Updating](#updating)
8. [Contributing](#contributing)
9. [Disclaimer](#disclaimer)

---

## Quick Start

```bash
git clone https://github.com/matty69v/Bug-Bounty-Agents.git
cd Bug-Bounty-Agents
```

Then jump to the [setup guide](#per-tool-setup) for your LLM client.

---

## Agent Catalog

Agents are grouped by phase of an offensive engagement.

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

### Exploitation & Post-Ex

| Agent | Purpose |
|---|---|
| [`exploit-chainer`](exploit-chainer.md) | Combine findings into impactful chains |
| [`exploit-guide`](exploit-guide.md) | Step-by-step exploitation reference |
| [`payload-crafter`](payload-crafter.md) | Custom payload generation and tuning |
| [`credential-tester`](credential-tester.md) | Password spraying, stuffing, brute force |
| [`privesc-advisor`](privesc-advisor.md) | Linux / Windows privilege escalation paths |
| [`poc-validator`](poc-validator.md) | Verify, stabilize, and minimize PoCs |

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
| [`stig-analyst`](stig-analyst.md) | STIG / CIS / compliance hardening review |
| [`report-generator`](report-generator.md) | Triage-ready bug bounty reports |
| [`bug-bounty`](bug-bounty.md) | General-purpose bounty assistant |
| [`swarm-orchestrator`](swarm-orchestrator.md) | Coordinate multiple agents in parallel |
| [`_scope-guard`](_scope-guard.md) | Hard scope enforcement layered on any agent |

---

## Prerequisites

- `git` installed on your machine
- An LLM client that supports custom system prompts or instruction files:
  - [Claude Code](https://claude.com/claude-code)
  - [GitHub Copilot Chat](https://github.com/features/copilot) (VS Code)
  - [Cursor](https://cursor.sh/)
  - ChatGPT (Custom GPTs / Projects), Gemini, or any chat UI accepting a system prompt

---

## Per-Tool Setup

### Claude Code

Claude Code reads agent definitions from `~/.claude/agents/` (global) or
`.claude/agents/` (per-project).

**Global install** — available in every project:

```bash
mkdir -p ~/.claude/agents
cp ~/path/to/Bug-Bounty-Agents/*.md ~/.claude/agents/
```

**Per-project install:**

```bash
cd /your/project
mkdir -p .claude/agents
cp ~/path/to/Bug-Bounty-Agents/*.md .claude/agents/
```

List and invoke:

```text
/agents
> use the web-hunter agent to audit https://target.example.com
```

---

### GitHub Copilot Chat (VS Code)

Copilot Chat supports custom **chat modes** via `.chatmode.md` files, or
**workspace instructions** via `.instructions.md` / `copilot-instructions.md`.

**Option A — Chat modes (recommended):**

```bash
# macOS
PROMPTS_DIR="$HOME/Library/Application Support/Code/User/prompts"
# Linux:   PROMPTS_DIR="$HOME/.config/Code/User/prompts"
# Windows: %APPDATA%\Code\User\prompts

mkdir -p "$PROMPTS_DIR"
for f in ~/path/to/Bug-Bounty-Agents/*.md; do
  name=$(basename "$f" .md)
  cp "$f" "$PROMPTS_DIR/$name.chatmode.md"
done
```

Reload VS Code, then select the mode from the Copilot Chat dropdown.

**Option B — Workspace instructions:**

```bash
cd /your/project
mkdir -p .github
cp ~/path/to/Bug-Bounty-Agents/web-hunter.md .github/copilot-instructions.md
```

---

### Cursor

Cursor uses `.cursor/rules/` for per-project agent rules.

```bash
cd /your/project
mkdir -p .cursor/rules
cp ~/path/to/Bug-Bounty-Agents/*.md .cursor/rules/
```

Each file becomes a selectable rule in Cursor's chat panel.

---

### ChatGPT / Gemini / Generic

Any chat UI that lets you set a system prompt works:

1. Open the agent file (e.g. `web-hunter.md`)
2. Copy the entire contents
3. Paste into:
   - **ChatGPT** — Custom GPT → Instructions, or Project → Instructions
   - **Gemini** — Gem instructions
   - **Open WebUI / LM Studio** — System prompt field
   - **API clients** — `system` role message

---

## Using an Agent

Once installed, give the agent a concrete target and scope:

```text
Target: https://staging.acme.com
Scope:  *.acme.com (in scope), *.thirdparty.com (out of scope)
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
  recon-advisor   ──▶   enumerate attack surface
                            │
                            ▼
  web-hunter / api-security ──▶  find vulnerabilities
                            │
                            ▼
  exploit-chainer  ──▶  escalate impact
                            │
                            ▼
  poc-validator    ──▶  confirm and stabilize
                            │
                            ▼
  report-generator ──▶  write the submission
```

Layer `_scope-guard` on top of any agent to enforce hard scope boundaries
during long-running sessions.

---

## Updating

```bash
cd ~/path/to/Bug-Bounty-Agents
git pull
# then re-copy the files into your tool's agent folder
```

---

## Contributing

Contributions are welcome. New agents should:

- Be self-contained in a single `.md` file
- Define a clear role, output format, and scope-handling rules
- Avoid tool-specific syntax so they remain portable across LLM clients

Open a pull request with the new agent and a one-line entry in the
[Agent Catalog](#agent-catalog).

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
