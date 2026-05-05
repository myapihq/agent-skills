---
name: my-webhook-api
description: Inbound webhook infrastructure for developers. Create unique endpoints, receive payloads, and fan out to workflow automations in real time.
---

# MyWebhookAPI

## Quick Start
1. `POST /webhook/orgs/{org_id}/endpoints` with a name — get back an `id` and inbound `slug`.
2. Give the inbound URL (`/webhook/in/{slug}`) to a third party or use it as an HTML form `action`.
3. Wire the endpoint to a workflow via `my-workflow-api` to act on incoming payloads.

## Authentication
`Authorization: Bearer <api_key>` (from `my-api-hq`).

## Endpoints

### Create Endpoint
```
POST /webhook/orgs/{org_id}/endpoints
{ "name": "Checkout webhooks", "description": "Optional" }
→ { "id": "...", "slug": "...", "name": "...", ... }
```
Errors: `400` invalid_json · `422` name_required.

### List Endpoints
```
GET /webhook/orgs/{org_id}/endpoints
→ [ { "id", "slug", "name", "description", "created_at" } ]
```

### Delete Endpoint
```
DELETE /webhook/orgs/{org_id}/endpoints/{id}
→ 204
```
Errors: `404` endpoint_not_found.

### Receive Payload (Public — no auth)
```
POST /webhook/in/{slug}
```
Supported `Content-Type`:
- `application/json` — standard JSON payload.
- `application/x-www-form-urlencoded` — form fields become direct properties of `payload`.
- `multipart/form-data` — field values parsed into `payload` object.

**Form example:**
```html
<form method="POST" action="https://api.mywebhookapi.com/webhook/in/your-slug">
  <input name="email" value="user@example.com">
  <input name="first_name" value="Riccardo">
</form>
```
Resulting workflow `payload`:
```json
{ "email": "user@example.com", "first_name": "Riccardo" }
```
Use `{{payload.email}}` — NOT `{{payload.body.email}}`.

Errors: `404` unknown slug.

### Get Delivery
```
GET /webhook/orgs/{org_id}/deliveries/{id}
→ { "id", "endpoint_id", "payload", "headers", "status", "created_at" }
```
Errors: `404` delivery_not_found.
