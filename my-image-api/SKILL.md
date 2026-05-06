---
name: my-image-api
description: >
  AI image generation with automatic cloud storage. Pass a prompt, get a
  hosted public URL. Async job-based workflow powered by Gemini.
---

# MyImageAPI Skill

## Quick Start
1. `POST /image/orgs/{org_id}/generate` with a `prompt`.
2. Poll `GET /image/orgs/{org_id}/jobs/{job_id}` every 3–5 seconds until `status` is `completed` (give up after ~60s / 15 attempts).
3. Use the returned `url` directly in funnels or email templates.

## Dependencies & Backlinks
- **Auth & Billing:** 401/402 → `my-api-hq`.
- **Next Steps:** Pass the returned `url` into `my-funnel-api` or `my-email-api` templates.

## Authentication
`Authorization: Bearer <api_key>` (from `my-api-hq`).

## Pricing
**$0.05 per image** (5 credits). Charged at job creation. Refunded if generation fails.

## Endpoints

### Generate Image (async)
```
POST /image/orgs/{org_id}/generate
{
  "prompt": "minimalist hero background, dark blue gradient, no text",
  "aspect_ratio": "16:9",
  "style": "photorealistic",
  "colors": "#1a1a2e, #e94560",
  "has_text": false
}
→ { "job_id": "a3f1c2d4-...", "status": "pending" }
```
Errors: `400` invalid_json, org_id_required · `422` prompt_required, invalid aspect_ratio · `402` insufficient_balance.

Valid `aspect_ratio` values: `1:1` (default), `16:9`, `9:16`, `4:3`, `3:4`.

### Poll Job
```
GET /image/orgs/{org_id}/jobs/{job_id}
→ { "job_id": "...", "status": "completed", "url": "https://api.myapihq.com/storage/img_...", "prompt": "...", "aspect_ratio": "...", "created_at": "..." }
```
Poll every 3–5 seconds until `status` is `completed` or `failed`.
Errors: `404` job_not_found.

### List Images
```
GET /image/orgs/{org_id}/list
→ [ { "job_id", "status", "url", "prompt", "aspect_ratio", "created_at" } ]
```

### Delete Image
```
DELETE /image/orgs/{org_id}/images/{id}
→ 204
```
Deletes the physical image file from storage and removes it from the internal `asset_ingestions` table. The `{id}` corresponds to the `job_id`. The `image_jobs` record is kept (so history of the prompt isn't lost in `/list`), but its `asset_id` is set to `NULL`, which will safely make the `url` return as `null`.

## Job Statuses
| Status | Meaning |
|---|---|
| `pending` | Queued, not yet started. |
| `processing` | Gemini generation in progress. |
| `completed` | Done — `url` contains the public image link. |
| `failed` | Generation failed — `error` field has the reason. Credits refunded. |
