# my-image-api

AI image generation with automatic cloud storage. Pass a prompt, get back a permanent hosted public URL. Async job-based workflow powered by Gemini.

## What it does

- Generate images from text prompts via AI
- Automatic upload to cloud storage
- Returns a permanent public URL ready to embed anywhere

## Quickstart

```bash
# Submit a generation job
curl -sS -X POST https://myimageapi.com/image/generate \
  -H "Authorization: Bearer $MYAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{"org_id": "<org_id>", "prompt": "A futuristic city at sunset"}'

# Poll for the result
curl -sS https://myimageapi.com/image/job/<job_id> \
  -H "Authorization: Bearer $MYAPI_KEY"
```

## Authentication

```
Authorization: Bearer <api_key>
```

Requires `org_id` from `my-api-hq`.

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyImageAPI](https://myimageapi.com)
