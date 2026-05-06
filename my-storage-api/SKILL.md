---
name: my-storage-api
description: >
  Upload and host static assets (images, files) and get back permanent public URLs. Use this to host images before embedding them in funnels or email templates.
---

# MyStorageAPI Skill

## Quick Start
1. `POST /storage/orgs/{org_id}/assets/ingest` with a public image URL, or `POST /storage/orgs/{org_id}/assets/upload` with a file.
2. Capture the `asset_id` and `url` from the response.
3. Pass the `url` into `my-funnel-api` pages or `my-email-api` templates.

## Dependencies & Backlinks
- **Auth & Billing:** 401/402 → `my-api-hq`.
- **Next Steps:** Pass returned URLs as `asset_urls` into `my-funnel-api` when building pages.

## Authentication
`Authorization: Bearer <api_key>` (from `my-api-hq`).

## Endpoints

### Ingest from URL
```
POST /storage/orgs/{org_id}/assets/ingest
{ "url": "https://example.com/image.jpg", "name": "optional", "description": "optional" }
→ { "asset_id": "img_...", "url": "https://api.myapihq.com/storage/img_...", "name": "...", "created_at": "..." }
```
- Only `image/jpeg` and `image/png` are supported. WebP is rejected.
- For Unsplash URLs, append `&fm=jpg` to force JPEG.

Errors: `422` url_required, https_required (URL must be HTTPS), unsupported format · `429` rate_limit_exceeded.

### Upload File

**Multipart form:**
```
POST /storage/orgs/{org_id}/assets/upload
Content-Type: multipart/form-data
(fields: file (required), name, description)
```

**Raw bytes:**
```
POST /storage/orgs/{org_id}/assets/upload
Content-Type: image/jpeg  (or image/png)
?name=...&description=...
```
Use `-k` with curl to bypass local dev SSL mismatches.

Errors: `400` invalid_form, file_required · `429` rate_limit_exceeded.

### List Assets
```
GET /storage/orgs/{org_id}/assets
→ [ { "asset_id", "url", "name", "created_at" } ]
```

### Delete Asset
```
DELETE /storage/orgs/{org_id}/assets/{asset_id}
→ 204
```
Errors: `404` asset_not_found.

### Serve Asset (Public — no auth)
```
GET /storage/{asset_id}
→ raw file bytes
```
Errors: `404` not found.
