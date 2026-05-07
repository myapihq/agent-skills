---
name: my-funnel-api:funnel
description: >
  A lean CRUD and CDN Publishing API. Manage funnel configurations, push raw HTML pages, and deploy static assets to the edge KV.
---

# MyFunnelAPI Skill

## 1. Funnel Management (Authenticated)
These endpoints manage the database records and structural configuration of funnels.

- `GET /funnel/orgs/{org_id}/funnels`
  Lists all funnels for the specified organization.
- `POST /funnel/orgs/{org_id}/funnels`
  Creates a new funnel entry. Expects basic configuration metadata (name, domain, etc.). Body: `{ "domain": "example.com" }`
- `GET /funnel/orgs/{org_id}/funnels/{id}`
  Retrieves the metadata and configuration details of a specific funnel.
- `DELETE /funnel/orgs/{org_id}/funnels/{id}`
  Deletes a funnel from the database and automatically purges all of its preview and published pages from the edge KV cache.

## 2. Publishing & Edge Deployment (Authenticated)
These endpoints interact with the edge KV cache to push HTML/JS content to the edge domains. As soon as you push a page, it is live.

- `POST /funnel/orgs/{org_id}/funnels/{id}/push-page`
  Deploys raw HTML to a specific slug on the live funnel (e.g., pushing custom HTML to /contact). Body: `{"slug": "/route", "html": "..."}`.
- `POST /funnel/orgs/{org_id}/funnels/{id}/verify`
  Pre-publish verification. Validates syntax and structure of raw HTML or an existing page slug.

## 3. Public Proxies (Unauthenticated)
These endpoints are called directly by the end-users' browsers (via the deployed static HTML). They do not require API keys. They are stateless and act as routing proxies to the Webhook API.

- `POST /funnel/funnels/{id}/submit/{slug...}`
  The endpoint for HTML form submissions. Validates the JSON payload, returns a 200 OK to the browser, and asynchronously POSTs the data to the organization's matching webhook (or fallback webhook).
- `POST /funnel/funnels/{id}/event`
  The endpoint for analytics and tracking scripts. Proxies click events, pageviews, and pixel tracking data to the configured webhook endpoints. Includes built-in rate limiting (max 60 req/min per funnel).
