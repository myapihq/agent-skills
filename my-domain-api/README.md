# my-domain-api

Register domains, check availability and pricing, import existing domains, and manage edge settings. Required before creating mailboxes (`my-email-api`) or funnels (`my-funnel-api`) — both need an owned domain.

## What it does

- Check domain availability and pricing
- Register new domains (auto-configures DNS + email infrastructure)
- Import existing domains
- Manage edge/DNS settings

## Quickstart

```bash
# Check availability
curl -sS https://mydomainapi.com/domain/check/example.com \
  -H "Authorization: Bearer $MYAPI_KEY"

# Register a domain
curl -sS -X POST https://mydomainapi.com/domain/register \
  -H "Authorization: Bearer $MYAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{"domain": "example.com", "org_id": "<org_id>"}'
```

## Authentication

```
Authorization: Bearer <api_key>
```

Requires `org_id` from `my-api-hq`.

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyDomainAPI](https://mydomainapi.com)
