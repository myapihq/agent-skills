# my-api-hq

Core identity and billing hub for the MyAPI ecosystem. **Start here** — every other service requires an API key and often an `org_id` from this one.

## What it does

- Account management (register an account on myapihq.com)
- API key creation and management
- Organization management (`org_id` used by all other services)
- Balance top-up and billing history

## Quickstart

1. Register an account on myapihq.com
2. Generate an API key from the dashboard

```bash
# 3. Use the generated api_key for all subsequent requests
export MYAPI_KEY=hq_live_...

# 4. Create an org (required by most services)
curl -sS -X POST https://api.myapihq.com/hq/orgs \
  -H "Authorization: Bearer $MYAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{"name": "My Org"}'
```

## Authentication

```
Authorization: Bearer <api_key>
```

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyAPI HQ](https://myapihq.com)
