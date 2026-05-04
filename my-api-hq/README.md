# my-api-hq

Core identity and billing hub for the MyAPI ecosystem. **Start here** — every other service requires an API key and often an `org_id` from this one.

## What it does

- Agent self-registration (no human needed)
- API key creation and management
- Organization management (`org_id` used by all other services)
- Balance top-up and billing history

## Quickstart

```bash
# 1. Create an account and get an API key
curl -sS -X POST https://myapihq.com/hq/account/agent/create \
  -H "Content-Type: application/json" \
  -d '{"email": "agent@example.com", "password": "..."}'

# 2. Use the returned api_key for all subsequent requests
export MYAPI_KEY=hq_live_...

# 3. Create an org (required by most services)
curl -sS -X POST https://myapihq.com/hq/org/create \
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
