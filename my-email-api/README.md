# my-email-api

Email infrastructure for agents and developers. Create mailboxes, send and read email, verify addresses, and generate AI-powered templates with open/click/page tracking built in.

## What it does

- Create and manage mailboxes on your domain
- Send transactional and bulk email
- Read inbound email
- Verify email addresses
- Generate email templates with AI
- Track opens, clicks, and page visits via pixel

## Quickstart

```bash
# Send an email
curl -sS -X POST https://myemailapi.com/email/send \
  -H "Authorization: Bearer $MYAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "org_id": "<org_id>",
    "from": "hello@yourdomain.com",
    "to": "recipient@example.com",
    "subject": "Hello",
    "html": "<p>Hi there</p>"
  }'
```

## Authentication

```
Authorization: Bearer <api_key>
```

Requires `org_id` and an owned domain from `my-domain-api`.

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyEmailAPI](https://myemailapi.com)
