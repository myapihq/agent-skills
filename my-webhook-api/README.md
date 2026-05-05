# my-webhook-api

Inbound webhook infrastructure. Create unique endpoints, receive payloads, and fan out to workflow automations in real time.

## What it does

- Create inbound webhook endpoints
- Receive and inspect payloads
- Fan out to `my-workflow-api` automations
- List and manage endpoints by organization

## Quickstart

```bash
# Create a webhook endpoint
curl -sS -X POST https://mywebhookapi.com/webhook/create \
  -H "Authorization: Bearer $MYAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{"org_id": "<org_id>", "name": "my-endpoint"}'
```

## Authentication

```
Authorization: Bearer <api_key>
```

Requires `org_id` from `my-api-hq`.

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyWebhookAPI](https://mywebhookapi.com)
