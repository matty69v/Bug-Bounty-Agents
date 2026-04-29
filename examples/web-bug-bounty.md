# Example: Web Bug Bounty Engagement

A sanitized walkthrough of a public bug bounty engagement against the
fictional `acme.example.com`. Demonstrates how five agents chain into a
single triage-ready submission.

> **Scope (declared by user):**
> - In scope: `*.acme.example.com`
> - Out of scope: `marketing.acme.example.com`, third-party SSO providers
> - Allowed: standard web testing, no DoS, no social engineering
> - Reporting: HackerOne program `acme`

---

## Stage 1 — Recon

**Agent:** `recon-advisor`

**Prompt:**

```text
Use the recon-advisor agent.
Scope: *.acme.example.com (in), marketing.acme.example.com (out).
Goal: enumerate live web assets and tech stack.
```

**Outcome (excerpt):**

```text
Discovered 14 in-scope subdomains:
  - app.acme.example.com       (Next.js, Vercel)
  - api.acme.example.com       (Express, Node 20, behind Cloudflare)
  - admin.acme.example.com     (HTTP 403 to public, 200 from app cookie)
  - billing.acme.example.com   (Stripe-hosted, out of testing interest)
  ...

Recommend handing off (api.acme.example.com, admin.acme.example.com)
to web-hunter and bizlogic-hunter.
```

---

## Stage 2 — Web Hunting

**Agent:** `web-hunter`

**Prompt:**

```text
Use the web-hunter agent.
Target: https://api.acme.example.com
Authenticated as: user_a@example.com (cookie attached, low-priv).
Goal: find auth bypass and access-control issues on /api/v2/*.
```

**Finding:**

```text
[H] Authentication bypass on /api/v2/internal/users
  - Reproduction:
      curl -i https://api.acme.example.com/api/v2/internal/users \
           -H 'X-Forwarded-For: 127.0.0.1'
  - Returns full user list (200 OK) without session cookie.
  - Root cause: server treats X-Forwarded-For: 127.0.0.1 as
    "trusted internal caller".
  - Severity: High (information disclosure of all user emails + roles).
```

---

## Stage 3 — Business Logic

**Agent:** `bizlogic-hunter`

**Prompt:**

```text
Use the bizlogic-hunter agent.
Context: we have a list of all user IDs from the previous finding.
Target: https://api.acme.example.com/api/v2/orders/{id}
Goal: test for IDOR.
```

**Finding:**

```text
[H] IDOR on /api/v2/orders/{id}
  - As user_a (id=42), GET /api/v2/orders/100 returns user_b's order
    including shipping address and last-4 of card.
  - No authorization check on order ownership.
  - Severity: High (PII disclosure across tenant boundary).
```

---

## Stage 4 — Chain

**Agent:** `exploit-chainer`

**Prompt:**

```text
Use the exploit-chainer agent.
Inputs:
  1. Auth bypass via X-Forwarded-For (gives full user list with IDs).
  2. IDOR on /api/v2/orders/{id} (gives PII for any order ID).
Goal: assess combined impact.
```

**Outcome:**

```text
Combined impact: unauthenticated mass PII harvest.
  - Step 1: bypass auth, dump all user IDs (~120k).
  - Step 2: enumerate orders (sequential integer IDs observed).
  - Step 3: harvest name, email, shipping address, last-4 for every
    order ever placed.
Severity: Critical (was: 2x High individually).
Estimated triage payout tier: Critical bracket.
```

---

## Stage 5 — Validate

**Agent:** `poc-validator`

Confirms reproduction on a fresh session, minimizes the PoC to two `curl`
commands, captures HAR and screenshots, and verifies the issue is not
already known (no duplicate in HackerOne hacktivity).

---

## Stage 6 — Report

**Agent:** `report-generator`

Produces a HackerOne-ready submission with:

- Title: `Unauthenticated PII harvest via X-Forwarded-For trust + IDOR`
- Severity: `Critical (CVSS 9.1)`
- Asset: `api.acme.example.com`
- Reproduction: numbered steps with `curl` commands
- Impact: ~120k user records exposed
- Remediation:
  1. Never trust `X-Forwarded-For` for authentication
  2. Add ownership check to `/api/v2/orders/{id}`
  3. Audit other `/internal/*` endpoints
- References: OWASP A01 (Broken Access Control), CWE-639, CWE-290

---

## Lessons

- Independent findings often combine into a higher-severity chain.
  Always run `exploit-chainer` before submitting.
- Declaring scope up front and re-confirming at each stage prevents
  out-of-scope drift.
- `poc-validator` reduces duplicate-closure risk by checking public
  hacktivity before submission.
