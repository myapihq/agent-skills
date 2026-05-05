# my-url-to

Stateful URL shortening and routing via myurlto.com. Shorten long URLs, track link activity, and give users compact shareable links.

## What it does

- Shorten any URL to a `myurlto.com` link
- Track clicks and link activity
- Manage and list links by organization

## Quickstart

```bash
# Shorten a URL
curl -sS -X POST https://myurlto.com/url/shorten \
  -H "Authorization: Bearer $MYAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{"org_id": "<org_id>", "url": "https://example.com/very/long/path"}'
```

## Authentication

```
Authorization: Bearer <api_key>
```

Requires `org_id` from `my-api-hq`.

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyUrlTo](https://myurlto.com)
