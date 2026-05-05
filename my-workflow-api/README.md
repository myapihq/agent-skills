# my-workflow-api

Webhook-triggered workflow automation. Define trigger conditions and actions like `send_email` or `slack_message`, with variable resolution and automatic retries.

## What it does

- Create workflows triggered by webhook events
- Define conditions and multi-step actions
- Variable resolution from payload data
- Automatic retries on failure
- Manage and inspect workflow runs

## Quickstart

```bash
# Create a workflow
curl -sS -X POST https://myworkflowapi.com/workflow/create \
  -H "Authorization: Bearer $MYAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "org_id": "<org_id>",
    "name": "Welcome email",
    "trigger": {"webhook_id": "<webhook_id>"},
    "actions": [
      {"type": "send_email", "to": "{{payload.email}}", "subject": "Welcome!"}
    ]
  }'
```

## Authentication

```
Authorization: Bearer <api_key>
```

Requires `org_id` from `my-api-hq`. Workflows are triggered by endpoints from `my-webhook-api`.

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyWorkflowAPI](https://myworkflowapi.com)
