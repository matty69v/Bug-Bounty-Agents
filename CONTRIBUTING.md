# Contributing

Thanks for your interest in improving Bug-Bounty-Agents. This guide covers
how to add a new agent, update an existing one, or improve the project's
tooling.

## Ground Rules

- **Authorized testing only.** Agents must require the user to declare scope
  before executing anything that touches a target. Add or extend a scope
  guard if your agent is execution-capable.
- **Portable prompts.** Agents must be usable across Claude Code, Copilot
  Chat, Cursor, and generic chat UIs. Avoid tool-specific syntax that breaks
  outside one client (e.g. raw `@tool` directives).
- **No emojis.** Keep prose clean and professional.
- **No real targets.** Examples must use `example.com`, RFC1918 ranges, or
  obviously fictional names.

## Adding a New Agent

1. Copy `templates/AGENT_TEMPLATE.md` to `<your-agent>.md` in the repo root.
2. Fill in the YAML frontmatter (`name`, `description`, `tools`, `model`).
3. Write the prompt body following the template's section structure.
4. Add a row to [AGENTS.md](AGENTS.md) using the controlled vocabulary.
5. Add a row to the appropriate table in [README.md](README.md).
6. Add a `### Added` line to the `[Unreleased]` section of [CHANGELOG.md](CHANGELOG.md).
7. Open a PR using the template.

## Updating an Existing Agent

- Keep frontmatter `name` stable — it's the public identifier.
- Bump the prompt's behavior section if you change scope rules or output format.
- Note breaking changes in `CHANGELOG.md` under `### Changed` or `### Removed`.

## Local Validation

```bash
# Lint markdown links across the repo
npx --yes markdown-link-check README.md AGENTS.md CHANGELOG.md SECURITY.md

# Smoke test the installer
./install.sh --target claude --dry-run
```

CI runs the same link check on every PR.

## Style

- Headings: sentence case (`## Adding a new agent`, not `## Adding A New Agent`).
- Code blocks: always specify a language.
- Tables: keep columns aligned in the source for readability.
- Line length: soft wrap; don't hard-wrap at 80 unless the file already does.

## Code of Conduct

Be respectful, assume good faith, and focus on the work. Harassment of any
kind is not tolerated.
