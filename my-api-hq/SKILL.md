---
name: my-api-hq
description: >
  Core Identity and Billing hub. Manage auth, organizations (get org_id), and billing (checkout/topup).
---

# MyApiHQ Skill
Root entry point for the ecosystem. All other skills require an `api_key` and often an `org_id` from here.

## Platform Conventions

### Response Envelope
Every response across all services is wrapped in:
```json
{
  "success": true,
  "data": { ... },
  "error": null,
  "meta": { "request_id": "...", "latency_ms": 12, "service": "...", "version": "v1" }
}
```
On error, `success` is `false`, `data` is `null`, and `error` contains a string error code or object. Always check `success` before reading `data`.

### Pagination
List endpoints accept `?limit=` and `?offset=` and return `total`, `limit`, `offset` in the body.

## Authentication & Key Management

### Account Registration
**Register:**
```
POST /hq/account/register
{ "email": "...", "password": "..." }
```
Errors: `400` invalid_json · `422` invalid email format or password too short · `409` email already registered.

**Verify Email:**
```
GET /hq/account/verify-email?token=<token>
→ 302 redirect
```
Errors: `410` token already used.

**Login:**
```
POST /hq/account/login
{ "email": "...", "password": "..." }
→ { "data": { "token": "<JWT>" } }
```
Errors: `401` wrong password.

**Refresh Token:**
```
POST /hq/account/refresh
```

**Google OAuth:**
- `GET /hq/auth/google/redirect` — Initiates Google OAuth flow.
- `GET /hq/auth/google/callback` — OAuth callback.

### API Key Management
**Generate Persistent Key:**
```
POST /hq/account/create/key
Authorization: Bearer <JWT from login>
{ "name": "MyKey" }
→ { "data": { "api_key": "hq_live_...", "id": "...", "prefix": "..." } }
```
Errors: `401` no auth.

Use `Authorization: Bearer <api_key>` for all subsequent requests across the entire ecosystem.

**List Keys:** `GET /hq/account/keys`

**Revoke Key:** `DELETE /hq/account/delete/key/{id}`

**Free Tier Info:** `GET /hq/account/free-tier`

### Cross-Session Storage
**Always persist credentials immediately.** Write a `.env` file:
```
MYAPI_API_KEY=hq_live_...
MYAPI_ACCOUNT_ID=...
```
Also save to agent memory if your runtime supports it (e.g., Claude Code memory). On every new session, check for credentials before creating a new account.

## Organization Management
**You MUST create an org to get an `org_id` for other APIs.**

### Create Org (sync)
```
POST /hq/orgs
{ "name": "Acme Inc" (required), "tagline", "description", "business_sector",
  "logo_url", "favicon_url", "og_image_url",
  "color_palette": { "primary": "#hex", ... },
  "font_family", "imagery_style", "headline", "subheadline", "cta_text",
  "value_propositions": ["..."],
  "social_links": { "twitter": "url", ... },
  "canonical_url", "privacy_policy_url", "cookie_policy_url", "terms_url",
  "gdpr_enabled": false, "default_language": "en", "tracking": {} }
→ { "data": { "id": "<org_id>", ... } }
```
Errors: `400` invalid_json · `422` name_required, invalid_field:color_palette, invalid_field:value_propositions, invalid_field:social_links, invalid_field:tracking · `402` insufficient balance (org creation has a cost on paid plan).

### Async Brand Import
```
POST /hq/org-imports
{ "domain": "example.com" (required), "auto_accept": false }
→ { "data": { "job_id": "...", "status": "pending" } }

GET /hq/org-imports/{job_id}
→ Poll until status = "awaiting_confirm". Returns brand_preview.

POST /hq/org-imports/{job_id}/confirm
{ ...optional overrides matching POST /hq/orgs payload... }
→ { "data": { "id": "<org_id>", ... } }
```

### Manage Orgs
- `GET /hq/orgs` — list all orgs.
- `GET /hq/orgs/{id}` — get org details. Errors: `404` org_not_found.
- `PATCH /hq/orgs/{id}` — partial update, same fields as create. Errors: `400` invalid_json · `404` org_not_found · `422` invalid_field:*.
- `DELETE /hq/orgs/{id}` — delete org and cascade. Errors: `404` org_not_found.

### Org Assets
- **Ingest from URL:** `POST /hq/orgs/{org_id}/assets/ingest` — `{ "url": "https://..." }` · Errors: `422` url_required, https_required · `429` rate_limit_exceeded · `422` unsupported format (only JPEG/PNG).
- **Upload file:** `POST /hq/orgs/{org_id}/assets/upload` — multipart `file` field.
- **List:** `GET /hq/orgs/{org_id}/assets`
- **Delete:** `DELETE /hq/orgs/{org_id}/assets/{asset_id}` — Errors: `404` asset_not_found.

## Billing
- **Check Balance:** `GET /hq/billing/balance` → `{ "data": { "balance_cents": 1000, "balance_display": "$10.00", "has_payment_method": true } }`.
- **Billing History:** `GET /hq/billing/history`
- **Setup Payment Method:** `POST /hq/billing/setup-payment` → `{ "data": { "url": "https://checkout.stripe.com/..." } }` — Stripe Checkout URL to save a card.
- **Confirm Setup:** `POST /hq/billing/setup-payment/confirm`
- **Top Up:** `POST /hq/billing/topup` — `{ "amount_cents": 1000 }` → `{ "data": { "new_balance_cents": 2000, "new_balance_display": "$20.00" } }`.

**On 402 from any service:** check balance and top up here before retrying.
