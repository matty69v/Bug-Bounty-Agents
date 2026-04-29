# Examples

End-to-end, sanitized walkthroughs showing how to chain agents in a real
engagement. All targets are fictional (`example.com`, RFC1918 ranges,
made-up vendors). Use these as templates for your own runs.

| Example | Agents used | Outcome |
|---|---|---|
| [`web-bug-bounty.md`](web-bug-bounty.md) | `recon-advisor` → `web-hunter` → `bizlogic-hunter` → `exploit-chainer` → `poc-validator` → `report-generator` | Auth-bypass + IDOR chain → triage-ready submission |
