# my-pixel-api

Query web visits, email events, and identity resolution data collected by the tracking pixel. Build attribution reports, inspect the identity graph for a contact, or retrieve engagement history.

## What it does

- Query web visit events by domain, contact, or time range
- Query email open/click events
- Identity resolution — link anonymous visits to known contacts
- Attribution and engagement reporting

## Quickstart

```bash
# Get recent visits for a domain
curl -sS "https://mypixelapi.com/pixel/visits?org_id=<org_id>&domain=yourdomain.com" \
  -H "Authorization: Bearer $MYAPI_KEY"
```

## Authentication

```
Authorization: Bearer <api_key>
```

Requires `org_id` from `my-api-hq`. Pixel data is collected automatically when you embed the tracking snippet in your funnel pages.

## Links

- [Full skill documentation (SKILL.md)](./SKILL.md)
- [MyPixelAPI](https://mypixelapi.com)
