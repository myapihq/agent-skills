---
name: my-workflow-api
description: Webhook-triggered workflow automation for developers. Define trigger conditions and actions like send_email or slack_message, with variable resolution and automatic retries.
---

# MyWorkflowAPI

## Quick Start
1. Create a webhook endpoint via `my-webhook-api`, note its `id`.
2. `POST /workflow/orgs/{org_id}/workflows` with `name`, `trigger_config.endpoint_id`, and a `steps` array.
3. Enable it: `POST /workflow/orgs/{org_id}/workflows/{id}/enable`.
4. Any payload POSTed to the webhook URL will now trigger the workflow steps.

## Authentication
`Authorization: Bearer <api_key>` (from `my-api-hq`).

## Endpoints

### Create Workflow
```
POST /workflow/orgs/{org_id}/workflows
{
  "name": "Send Welcome Email",
  "trigger_config": { "endpoint_id": "<webhook_endpoint_uuid>" },
  "steps": [
    {
      "type": "send_email",
      "from": "hello@example.com",
      "to": "{{payload.user.email}}",
      "subject": "Welcome, {{payload.user.first_name}}!",
      "template_id": "<email_template_uuid>"
    }
  ]
}
→ { "id": "...", ... }
```
Errors: `400` invalid_json · `422` name_required, steps_required.

### List / Get
```
GET /workflow/orgs/{org_id}/workflows
GET /workflow/orgs/{org_id}/workflows/{id}
```
Errors: `404` workflow_not_found.

### Update
```
PATCH /workflow/orgs/{org_id}/workflows/{id}
{ "name": "New Name", "steps": [ ... ] }
```
Errors: `400` invalid_json · `404` workflow_not_found · `422` name_cannot_be_empty.

### Enable / Disable
```
POST /workflow/orgs/{org_id}/workflows/{id}/enable   → { "enabled": true }
POST /workflow/orgs/{org_id}/workflows/{id}/disable
```
Errors: `404` workflow_not_found.

### Delete
```
DELETE /workflow/orgs/{org_id}/workflows/{id}
→ 204
```
Errors: `404` workflow_not_found.

### Runs
```
GET /workflow/orgs/{org_id}/workflows/{id}/runs
→ [ { "id", "workflow_id", "trigger_payload", "status", "error", "attempt", "started_at", "finished_at", "created_at" } ]
```
Returns up to 100 most recent runs, newest first.

```
GET /workflow/orgs/{org_id}/runs/{id}
```
Errors: `404` run_not_found.

`status` values: `pending`, `running`, `completed`, `failed`.

## Step Types

### `send_email`
Sends an email. `template_id` takes priority over inline `html`.
**Prerequisite:** `from` must be a mailbox created and sending-activated via `my-email-api`. Using an arbitrary address will silently fail.
```json
{
  "type": "send_email",
  "from": "hello@example.com",
  "to": "{{payload.email}}",
  "subject": "Hello {{payload.name}}",
  "template_id": "<email_template_uuid>"
}
```

**Payload variable note:** For form submissions, fields map directly onto `payload` — no `.body` wrapper.
- **Correct:** `{{payload.email}}`
- **Wrong:** `{{payload.body.email}}`

### `slack_message`
Posts to a Slack channel via an incoming webhook URL.
```json
{
  "type": "slack_message",
  "webhook_url": "https://hooks.slack.com/services/T00/B00/xxx",
  "text": "New lead: {{payload.name}} from {{payload.company}} — {{payload.email}}"
}
```
- `webhook_url` — required. Create at `api.slack.com/apps` → Incoming Webhooks.
- `text` — supports `{{payload.field}}` and `{{payload.nested.field}}` interpolation.
- Failed sends are retried up to 3 times with exponential backoff.
