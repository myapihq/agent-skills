---
name: my-url-api:shortener
description: >
  Stateful URL shortening and routing service for the ecosystem. Use this to explicitly shorten long URLs, track link activity, or provide users with compact `myurlto.com` links.
---

# My URL To API (URL Shortener)

## Overview
Generates compact redirect URLs under `myurlto.com`.

## Quick Start
1. `POST /url/orgs/{org_id}/shorten` with `{ "url": "https://example.com" }`.
2. Use the returned `short_url` — it 302-redirects to the original.

## Endpoints

### Shorten URL
```
POST /url/orgs/{org_id}/shorten
{ "url": "https://example.com/very/long/path?parameters=true" }
→ { "data": { "short_code": "8f2a1b9c", "short_url": "https://api.myurlto.com/example.com/8f2a1b9c" } }
```
The domain segment in `short_url` is extracted from the target URL's root domain.

Errors: `400` url is required.

### Redirect (Public — no auth)
```
GET /{domain}/{code}
→ 302 Location: <original URL>
```
Errors: `404` unknown code or code longer than 16 characters.

## Note
Agents don't always need to call this endpoint. Internal Go services automatically shorten certain links (e.g., payment checkout URLs) before returning them to users. Only call explicitly when a user or workflow specifically asks to shorten a URL.
