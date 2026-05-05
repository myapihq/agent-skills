---
name: my-email-api
description: >
  Email infrastructure. Mailbox creation, sending, reading, email verification,
  and AI-powered email template generation with open/click/page tracking.
---

# MyEmailAPI Skill

## Quick Start
1. Register a domain via `my-domain-api`, then `POST /email/orgs/{org_id}/mailboxes/create`.
2. `POST /email/orgs/{org_id}/sending/activate` to unlock outbound sending.
3. Generate a template (`POST /email/orgs/{org_id}/templates/generate`), poll until `completed`, then `POST /email/orgs/{org_id}/send`.

## Dependencies & Backlinks
- **Auth & Billing:** 401/402 → `my-api-hq`.
- **Domain Prerequisite:** You MUST own a domain before creating a mailbox.
- **Next Steps:** For lead capture, use `my-funnel-api` for the landing page.

## Authentication
`Authorization: Bearer <api_key>` (from `my-api-hq`).

## 1. Mailbox & Sending

### Create Mailbox ($0.50)
```
POST /email/orgs/{org_id}/mailboxes/create
{ "domain": "example.com", "username": "hello", "display_name": "Hello Team" }
→ { "address": "hello@example.com", ... }
```
Errors: `400` INVALID_DOMAIN, INVALID_USERNAME · `403` DOMAIN_NOT_OWNED · `409` MAILBOX_ALREADY_EXISTS · `402` INSUFFICIENT_BALANCE.

### List Mailboxes
```
GET /email/orgs/{org_id}/mailboxes
→ [ { "address", "domain", "created_at", ... } ]
```

### Activate Sending ($2.50)
```
POST /email/orgs/{org_id}/sending/activate
{ "address": "hello@example.com" }
```
Errors: `400` INVALID_ADDRESS, INVALID_REQUEST · `403` MAILBOX_NOT_OWNED · `409` ALREADY_ACTIVATED · `402` INSUFFICIENT_BALANCE.

### Send Email
```
POST /email/orgs/{org_id}/send
{ "from": "hello@example.com", "to": ["user@example.com"], "subject": "Hello", "html": "<p>...</p>", "text": "..." }
→ { "message_id": "..." }
```
At least one of `html` or `text` is required.
Errors: `403` MAILBOX_NOT_OWNED · `502` mail server error.

### Monitor
- `GET /email/orgs/{org_id}/status/{message_id}` — sent message delivery status.
- `GET /email/orgs/{org_id}/sent` — all sent messages for the org.
- `GET /email/orgs/{org_id}/inbox/{address}` — received messages.
- `GET /email/orgs/{org_id}/outbox/{address}` — outbox for a specific address.
- `GET /email/orgs/{org_id}/message/{message_id}` — full content of a received message.

Errors: `400` MISSING_ADDRESS · `403` MAILBOX_NOT_OWNED · `404` MESSAGE_NOT_FOUND · `502` mail server error.

## 2. Email Warmup
Requires sending to be activated first.

```
POST /email/orgs/{org_id}/warmup/start
{ "address": "hello@example.com" }
```
Costs $5.00 one-time. Configures IMAP/SMTP in Instantly.ai. Returns `warmup_status: "active"`.

Errors: `400` INVALID_REQUEST · `403` MAILBOX_NOT_OWNED · `409` SENDING_NOT_ACTIVATED, WARMUP_ALREADY_ACTIVE · `402` INSUFFICIENT_BALANCE · `502` warmup provider error.

```
POST /email/orgs/{org_id}/warmup/pause    { "address": "..." }
POST /email/orgs/{org_id}/warmup/resume   { "address": "..." }
POST /email/orgs/{org_id}/warmup/stop     { "address": "..." }
GET  /email/orgs/{org_id}/warmup/stats/{address}
→ { "sent", "landed_inbox", "landed_spam", "health_score", ... }
```

## 3. Email Templates (AI-powered)
Templates are org-scoped and inherit brand config (colors, logo, font).

### Generate (async)
```
POST /email/orgs/{org_id}/templates/generate
{ "org_id": "<org_id>", "prompt": "Welcome email for SaaS trial users, dark bg, CTA to dashboard", "name": "Welcome — Trial" }
→ { "job_id": "...", "template_id": "...", "status": "processing", "preview_url": "..." }
```
Poll (5s interval, up to ~90s):
```
GET /email/orgs/{org_id}/template-jobs/{job_id}
→ { "status": "processing"|"completed"|"failed", "template_id": "...", "result": { "template_id", "subject", "preview_url" } }
```
The `preview_url` is public — no auth needed, auto-refreshes while generating.

### Edit
```
POST /email/orgs/{org_id}/templates/{id}/edit
{ "prompt": "Make the CTA button red and add an unsubscribe link in the footer" }
→ { "template_id": "...", "preview_url": "..." }
```

### Preview (public — no auth)
```
GET /email/templates/{id}/preview?viewport=desktop|mobile
→ HTML page with Gmail chrome
```

### Send Test
```
POST /email/orgs/{org_id}/templates/{id}/send-test
{ "to": "you@example.com" }
→ { "ok": true, "message_id": "..." }
```

### List / Get / Delete
```
GET    /email/orgs/{org_id}/templates
GET    /email/orgs/{org_id}/templates/{id}
DELETE /email/orgs/{org_id}/templates/{id}  → 204
```

## 4. Tracking
Injected automatically when sending via template.

- **Open pixel:** `GET /t/o?lid=<lead_id>` — logs `open` event.
- **Click redirect:** `GET /t/c?lid=<lead_id>&url=<dest>` — logs `click`, 302-redirects with `lid` appended.
- **Cookie bridge:** `GET /t/p?lid=<lead_id>&page=<path>` — sets `_hspx` cookie, stitching email identity to visitor pixel.

Query all tracking data via `my-pixel-api`.

## 5. Campaigns

### Create
```
POST /email/orgs/{org_id}/campaigns
{ "name": "My Campaign", "from_address": "hello@example.com", "template_id": "<id>",
  "rate_per_minute": 3, "per_hour_limit": 100 }
→ { "id": "...", "status": "draft", ... }
```
Errors: `400` name and from_address are required, template not found.

### Upload Contacts
Option A — JSON array:
```
POST /email/orgs/{org_id}/campaigns/{id}/contacts/upload-list
{ "emails": ["a@example.com", "b@example.com"] }
→ { "list_id": "...", "total": 2, "status": "validating" }
```
Errors: `400` emails array is required · `409` cannot upload to active/completed campaign.

Option B — CSV/TXT file:
```
POST /email/orgs/{org_id}/campaigns/{id}/contacts/upload-file
Content-Type: multipart/form-data  (field: "file")
```
CSV: column named `email` (case-insensitive) is used; otherwise first column assumed. Duplicates removed automatically.
Errors: `400` field 'file' required, could not parse file, no emails found · `409` cannot upload to active/completed campaign.

### Poll Validation
```
GET /email/orgs/{org_id}/campaigns/{id}/contacts/status
→ { "upload_status": "ready"|"validating"|"failed", "total": N, "valid_count": N, "invalid_count": N }
```
Wait for `upload_status: "ready"` before starting.

### Controls
```
POST /email/orgs/{org_id}/campaigns/{id}/start   → { "status": "active" }
POST /email/orgs/{org_id}/campaigns/{id}/pause
POST /email/orgs/{org_id}/campaigns/{id}/resume
```
Start errors: `404` campaign not found · `409` still validating, already completed, already active, no valid contacts.
Pause errors: `409` campaign is not active.
Resume errors: `409` campaign is not paused.

**Rate limits (enforced):** max 3 emails/min, max 100 emails/hour per campaign.

### Stats
```
GET /email/orgs/{org_id}/campaigns/{id}/stats
→ {
    "campaign": { "id", "name", "status", "rate_per_minute", "per_hour_limit", ... },
    "validation": { "total", "valid", "invalid", "pending", "list_status" },
    "dispatch": { "sent", "remaining", "sent_this_hour", "hour_limit", "last_dispatch_at" },
    "engagement": { "sent", "opens", "clicks", "page_visits" }
  }
```

### List / Get / Update
```
GET   /email/orgs/{org_id}/campaigns
GET   /email/orgs/{org_id}/campaigns/{id}
PATCH /email/orgs/{org_id}/campaigns/{id}   { "name": "...", "per_day_limit": 250 }
```

**Template placeholder:** Only `{{domain}}` is supported (contact's email domain).
