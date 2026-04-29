# AGENTS Index

Machine-readable catalog of every agent in this repository. Used by
`swarm-orchestrator` and `attack-planner` to route tasks. Keep one row per
agent. Tags should be lowercase, hyphenated, and from the controlled
vocabulary below.

## Controlled Vocabulary

**Phase**: `recon`, `intel`, `web`, `api`, `infra`, `cloud`, `network`, `mobile`, `wireless`, `exploit`, `postex`, `defense`, `report`, `meta`

**MITRE ATT&CK Tactic** (when applicable): `reconnaissance`, `resource-development`, `initial-access`, `execution`, `persistence`, `privilege-escalation`, `defense-evasion`, `credential-access`, `discovery`, `lateral-movement`, `collection`, `command-and-control`, `exfiltration`, `impact`

**Risk Tier** (operational impact if misused): `safe` (read-only/passive), `active` (touches target), `intrusive` (likely to alert/disrupt)

---

## Index

| Agent | Phase | ATT&CK Tactic | Risk | Description |
|---|---|---|---|---|
| `recon-advisor` | recon | reconnaissance | safe | Surface enumeration and asset discovery |
| `osint-collector` | intel | reconnaissance | safe | Open-source intelligence gathering |
| `subdomain-takeover` | recon | reconnaissance | active | Dangling DNS and takeover validation |
| `threat-modeler` | meta | — | safe | STRIDE / attack-surface modeling |
| `engagement-planner` | meta | — | safe | Scope, RoE, test plan authoring |
| `attack-planner` | meta | — | safe | Multi-stage attack path planning |
| `web-hunter` | web | initial-access | active | Web application vulnerability hunting |
| `api-security` | api | initial-access | active | REST and GraphQL API testing |
| `graphql-hunter` | api | initial-access | active | GraphQL schema, authz, complexity |
| `bizlogic-hunter` | web | initial-access | active | Business logic flaws and abuse cases |
| `ssrf-hunter` | web | initial-access | active | SSRF discovery and filter bypass |
| `jwt-cracker` | web | credential-access | active | JWT/OIDC token attacks |
| `vuln-scanner` | recon | discovery | intrusive | Automated scanning orchestration |
| `cloud-security` | cloud | discovery | active | AWS/GCP/Azure misconfiguration hunting |
| `container-escape` | infra | privilege-escalation | intrusive | Docker/K8s breakout |
| `cicd-redteam` | infra | initial-access | intrusive | CI/CD and supply-chain attacks |
| `ad-attacker` | infra | lateral-movement | intrusive | Active Directory enum and abuse |
| `wireless-pentester` | wireless | initial-access | intrusive | Wi-Fi, Bluetooth, RF assessments |
| `mobile-pentester` | mobile | initial-access | active | iOS/Android application testing |
| `binary-exploit` | exploit | execution | intrusive | Memory corruption, ROP, pwn |
| `crypto-analyst` | exploit | credential-access | safe | Crypto primitive and protocol analysis |
| `hardware-hacker` | exploit | initial-access | intrusive | Embedded, JTAG, firmware extraction |
| `red-team-operator` | postex | command-and-control | intrusive | C2, OPSEC, long-haul operations |
| `purple-team` | defense | — | safe | Detection-as-you-attack collaboration |
| `exploit-chainer` | exploit | execution | active | Combine findings into chains |
| `exploit-guide` | exploit | execution | active | Step-by-step exploitation reference |
| `payload-crafter` | exploit | execution | active | Custom payload generation |
| `credential-tester` | exploit | credential-access | intrusive | Spraying, stuffing, brute force |
| `privesc-advisor` | postex | privilege-escalation | active | Linux/Windows privesc paths |
| `poc-validator` | exploit | — | active | Verify, stabilize, minimize PoCs |
| `llm-redteam` | exploit | initial-access | active | Prompt injection, RAG poisoning |
| `phishing-operator` | exploit | initial-access | intrusive | Phishing infra and campaigns |
| `social-engineer` | exploit | initial-access | intrusive | Pretexting, vishing |
| `malware-analyst` | defense | — | safe | Static and dynamic malware analysis |
| `reverse-engineer` | defense | — | safe | Binary RE, decompilation |
| `forensics-analyst` | defense | — | safe | DFIR, artifact analysis, timelines |
| `ctf-solver` | meta | — | safe | CTF challenge solver |
| `detection-engineer` | defense | — | safe | Detection and response engineering |
| `stig-analyst` | defense | — | safe | STIG/CIS compliance hardening |
| `report-generator` | report | — | safe | Triage-ready bug reports |
| `bug-bounty` | meta | — | active | General-purpose bounty assistant |
| `swarm-orchestrator` | meta | — | safe | Coordinate multiple agents |
| `_scope-guard` | meta | — | safe | Shared scope enforcement block |
