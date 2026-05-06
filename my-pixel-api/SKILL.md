---
name: my-pixel-api
description: >
  Query web visits, email events, and identity resolution data collected by the tracking pixel. Use this to retrieve engagement history, build attribution reports, or inspect the identity graph for a contact.
---

# MyPixelAPI Skill

## Quick Start
1. Run a campaign via `my-email-api` — each contact gets a unique `pixel_id` automatically.
2. `GET /pixel/orgs/{org_id}/interactions?campaign_id={id}` for a unified timeline.
3. `GET /pixel/orgs/{org_id}/identity/{pixel_id}` to resolve the full identity graph.

## Dependencies & Backlinks
- **Auth:** `Bearer <api_key>` (from `my-api-hq`).
- **Related:** Campaign engagement stats also available via `my-email-api` (`/email/orgs/{org_id}/campaigns/{id}/stats`).

## Authentication
`Authorization: Bearer <api_key>`.

All list endpoints support `?limit=` (default 50, max 500) and `?offset=`. Responses include `total`, `limit`, `offset`.

## Endpoints

### Interactions (unified timeline)
Merges web visits and email events. At least one filter is required.
```
GET /pixel/orgs/{org_id}/interactions
  ?website=yourdomain.com     # filter visits by destination domain
  &domain=yourdomain.com      # filter email events by clicked URL domain
  &campaign_id=<id>           # filter by campaign
  &from=2024-01-01T00:00:00Z  # ISO8601
  &to=2024-12-31T23:59:59Z
  &limit=50  &offset=0

→ {
    "interactions": [
      { "type": "visit", "pixel_id": "...", "from_url": "...", "to_url": "...", "ts": "..." },
      { "type": "event", "pixel_id": "...", "event_type": "open|click|sent", "url": "...", "campaign_id": "...", "ts": "..." }
    ],
    "total_visits": N, "total_events": N, "limit": 50, "offset": 0
  }
```

### Visits
```
GET /pixel/orgs/{org_id}/visits?website=yourdomain.com&from=&to=&limit=&offset=
→ { "visits": [ { "pixel_id", "from_url", "to_url", "ts" } ], "total", "limit", "offset" }
```

### Events
```
GET /pixel/orgs/{org_id}/events?campaign_id=<id>&domain=yourdomain.com&from=&to=&limit=&offset=
→ { "events": [ { "pixel_id", "event_type", "meta", "ts" } ], "total", "limit", "offset" }
```
`meta` is a JSON string: `{"campaign_id": "...", "url": "..."}`. `open` events always have `meta: "{}"`.

### Identity Dossier
```
GET /pixel/orgs/{org_id}/identity/{pixel_id}
→ { "uuid": "...", "is_resolved": true, "nodes": { "<value>": { "type": "email|ip|...", "probability": 0.95 } }, "latency_ms": 12.3 }
```

## Event Types
| `event_type` | Meaning |
|---|---|
| `sent` | Email delivered |
| `open` | Open pixel fired |
| `click` | Link clicked in email |
| `page_visit` | Cookie bridge fired (visitor landed on tracked page) |

### Geo Sample (Audience)
Sub-second geographic lookup using H3 array intersections.
```
GET /pixel/orgs/{org_id}/audience/get_geo_sample
  ?lat=38.8951  &lon=-77.0364   # coordinate search
  &q=Washington D.C.            # OR text search (resolved to coordinates)
  &radius=2000                  # meters (default 2000)

→ {
    "latency_ms": 134.5, "lat": ..., "lon": ..., "radius_m": 2000,
    "people":    [ { "id", "type", "name", "contacts": [] } ],
    "companies": [ { "id", "type", "name", "contacts": [ {"type": "email", "value": "..."} ] } ]
  }
```
