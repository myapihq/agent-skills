# my-storage-api

Upload and host static assets — images, files, documents — and get back permanent public URLs. Use this to host images before embedding them in funnels or email templates.

## What it does

- Upload any static file (image, PDF, video, etc.)
- Returns a permanent public CDN URL
- Manage assets by organization

## Quickstart

```bash
# Upload a file
curl -sS -X POST https://mystorageapi.com/storage/upload \
  -H "Authorization: Bearer $MYAPI_KEY" \
  -F "org_id=<org_id>" \
  -F "file=@/path/to/image.png"
```

## Authentication

```
Authorization: Bearer <api_key>
```

Requires `org_id` from `my-api-hq`.

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyStorageAPI](https://mystorageapi.com)
