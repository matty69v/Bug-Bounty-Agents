# Bug-Bounty-Agents

A collection of specialized AI agent prompts for bug bounty hunting, penetration testing, and offensive security workflows. Each `.md` file in this repo defines a focused agent persona (recon, web hunting, exploit chaining, reporting, etc.) you can drop into Claude Code, GitHub Copilot Chat, Cursor, or any agent-capable LLM client.

> Repo: https://github.com/matty69v/Bug-Bounty-Agents.git

---

## Table of Contents

- [What's in here](#whats-in-here)
- [Prerequisites](#prerequisites)
- [Quick Setup](#quick-setup)
- [Per-Tool Setup](#per-tool-setup)
  - [Claude Code](#1-claude-code)
  - [GitHub Copilot Chat (VS Code)](#2-github-copilot-chat-vs-code)
  - [Cursor](#3-cursor)
  - [Generic / ChatGPT / Other LLMs](#4-generic--chatgpt--other-llms)
- [Using an Agent](#using-an-agent)
- [Chaining Agents](#chaining-agents)
- [Updating](#updating)
- [Disclaimer](#disclaimer)

---

## What's in here

Each markdown file is a self-contained system prompt for a specialized role:

| Agent | Purpose |
|---|---|
| `recon-advisor.md` | Surface enumeration, asset discovery |
| `osint-collector.md` | Open-source intel gathering |
| `web-hunter.md` | Web app vulnerability hunting |
| `api-security.md` | REST/GraphQL API testing |
| `bizlogic-hunter.md` | Business logic flaws |
| `exploit-chainer.md` | Combine findings into impactful chains |
| `payload-crafter.md` | Custom payload generation |
| `poc-validator.md` | Verify and stabilize PoCs |
| `report-generator.md` | Write triage-ready bug reports |
| `swarm-orchestrator.md` | Coordinate multiple agents |
| `graphql-hunter.md` | GraphQL schema, authz, and complexity attacks |
| `jwt-cracker.md` | JWT/OIDC token attacks (alg confusion, kid/jku abuse, weak HMAC) |
| `ssrf-hunter.md` | SSRF discovery, filter bypass, cloud-metadata abuse |
| `subdomain-takeover.md` | Dangling DNS / subdomain takeover validation |
| `llm-redteam.md` | Prompt injection, tool abuse, RAG poisoning, agent loops |
| `container-escape.md` | Docker / Kubernetes pod-to-node-to-cluster breakout |
| ...and more | See the file list in the repo root |

---

## Prerequisites

- `git` installed
- An LLM client that supports custom system prompts or agent/instruction files:
  - [Claude Code](https://claude.com/claude-code)
  - [GitHub Copilot Chat](https://github.com/features/copilot) in VS Code
  - [Cursor](https://cursor.sh/)
  - ChatGPT (Custom GPTs / Projects), Gemini, or any chat UI that accepts a system prompt

---

## Quick Setup

Clone the repo anywhere on your machine:

```bash
git clone https://github.com/matty69v/Bug-Bounty-Agents.git
cd Bug-Bounty-Agents
```

That's it for the files. Now wire them into your tool of choice below.

---

## Per-Tool Setup

### 1. Claude Code

Claude Code reads agent definitions from `~/.claude/agents/` (global) or `.claude/agents/` (per-project).

**Global install (available in every project):**

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

Then in Claude Code, list available agents:

```
/agents
```

Invoke one with:

```
> use the web-hunter agent to audit https://target.example.com
```

---

### 2. GitHub Copilot Chat (VS Code)

Copilot Chat supports custom **chat modes** via `.chatmode.md` files, or **instructions** via `.instructions.md` / `copilot-instructions.md`.

**Option A — As chat modes (recommended):**

```bash
# macOS
PROMPTS_DIR="$HOME/Library/Application Support/Code/User/prompts"
# Linux: PROMPTS_DIR="$HOME/.config/Code/User/prompts"
# Windows: %APPDATA%\Code\User\prompts

mkdir -p "$PROMPTS_DIR"
for f in ~/path/to/Bug-Bounty-Agents/*.md; do
  name=$(basename "$f" .md)
  cp "$f" "$PROMPTS_DIR/$name.chatmode.md"
done
```

Reload VS Code, then pick the mode from the Copilot Chat mode dropdown.

**Option B — As workspace instructions:**

```bash
cd /your/project
mkdir -p .github
cp ~/path/to/Bug-Bounty-Agents/web-hunter.md .github/copilot-instructions.md
```

---

### 3. Cursor

Cursor uses `.cursor/rules/` for per-project agent rules.

```bash
cd /your/project
mkdir -p .cursor/rules
cp ~/path/to/Bug-Bounty-Agents/*.md .cursor/rules/
```

Each file becomes a selectable rule in Cursor's chat panel.

---

### 4. Generic / ChatGPT / Other LLMs

Any chat UI that lets you set a system prompt works:

1. Open the agent file (e.g. `web-hunter.md`)
2. Copy the entire contents
3. Paste into:
   - **ChatGPT**: Custom GPT → Instructions, or Project → Instructions
   - **Gemini**: Gem instructions
   - **Open WebUI / LM Studio**: System prompt field
   - **API clients**: `system` role message

---

## Using an Agent

Once installed, give the agent a concrete target and scope. Example:

```
Target: https://staging.acme.com
Scope:  *.acme.com (in scope), *.thirdparty.com (out)
Goal:   Find auth bypass and IDOR on the /api/v2/users endpoints.
```

Good agents will:
- Ask clarifying questions before acting
- Stay within scope
- Produce reproducible PoCs
- Output triage-ready findings

---

## Chaining Agents

Use `swarm-orchestrator.md` or `attack-planner.md` to coordinate a full workflow:

1. `recon-advisor` → enumerate attack surface
2. `web-hunter` / `api-security` → find bugs
3. `exploit-chainer` → escalate impact
4. `poc-validator` → confirm and stabilize
5. `report-generator` → write the submission

---

## Updating

```bash
cd ~/path/to/Bug-Bounty-Agents
git pull
# then re-copy the files into your tool's agent folder
```

---

## Disclaimer

These agents are for **authorized security testing only** — bug bounty programs you're enrolled in, your own systems, or environments where you have explicit written permission. Unauthorized testing is illegal. You are solely responsible for how you use these prompts.

---

Repo: **https://github.com/matty69v/Bug-Bounty-Agents.git**
