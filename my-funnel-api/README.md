# my-funnel-api

Host multi-page sites and funnels by pushing raw HTML or using AI to plan, build, and edit complete funnels. Handles routing, edge delivery, webhook wiring, link/workflow verification, and lead management.

## What it does

- Create and host multi-page funnels from raw HTML
- AI-assisted funnel generation and editing
- Edge delivery on your domain
- Lead capture and management
- Webhook and workflow integration

## Quickstart

```bash
# Create a funnel page
curl -sS -X POST https://myfunnelapi.com/funnel/page \
  -H "Authorization: Bearer $MYAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "org_id": "<org_id>",
    "domain": "yourdomain.com",
    "slug": "/",
    "html": "<html>...</html>"
  }'
```

## Authentication

```
Authorization: Bearer <api_key>
```

Requires `org_id` and an owned domain from `my-domain-api`.

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyFunnelAPI](https://myfunnelapi.com)
