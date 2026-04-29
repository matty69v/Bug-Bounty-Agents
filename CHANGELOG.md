# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `LICENSE` (MIT).
- `AGENTS.md` machine-readable agent index with phase, ATT&CK tactic, and risk tags.
- `CONTRIBUTING.md` and `templates/AGENT_TEMPLATE.md` for new-agent submissions.
- `SECURITY.md` describing how to report issues responsibly.
- `install.sh` auto-detecting installer for Claude Code, Copilot Chat, and Cursor.
- `.github/` issue templates, PR template, and a markdown link-check workflow.
- New agents: `binary-exploit`, `crypto-analyst`, `hardware-hacker`, `red-team-operator`, `purple-team`.
- `examples/` directory with a sanitized end-to-end engagement walkthrough.

### Changed
- `README.md` redesigned: centered hero, monochrome badges, categorized agent
  catalog, ASCII workflow diagram, contributor section.

## [1.0.0] - 2026-04-01

### Added
- Initial public release with 38 agent prompts spanning recon, web/API hunting,
  cloud, mobile, wireless, exploitation, reporting, and orchestration.

[Unreleased]: https://github.com/matty69v/Bug-Bounty-Agents/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/matty69v/Bug-Bounty-Agents/releases/tag/v1.0.0
