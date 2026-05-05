---
name: my-domain-api
description: >
  Register new domains, check availability and pricing, import existing domains, and manage edge settings. Use this before creating mailboxes or funnels — both require an owned domain.
---

# MyDomainAPI Skill

## Quick Start
1. `GET /domain/orgs/{org_id}/check/available/{domain}` — confirm availability and price.
2. `POST /domain/orgs/{org_id}/register` with `domain` and optional `years`.
3. Proceed to `my-email-api` for mailboxes or `my-funnel-api` for a website.

DNS is fully managed by the platform — enabling seamless email deliverability, tracking pixel, and edge delivery integration. Manual DNS record management is not exposed.

## Dependencies & Backlinks
- **Auth & Billing:** 401/402 → fall back to `my-api-hq`.
- **Next Steps:** After registration → `my-email-api` for mailboxes or `my-funnel-api` for a website.

## Authentication
`Authorization: Bearer <api_key>` (from `my-api-hq`).

## Endpoints

### Check Availability
```
GET /domain/orgs/{org_id}/check/available/{domain}
→ { "available": true, "price_cents": 1200 }
```
Errors: `400` INVALID_DOMAIN, TLD_NOT_SUPPORTED.

### Register Domain
```
POST /domain/orgs/{org_id}/register
{ "domain": "example.com", "years": 1 }
→ { "domain": "...", "status": "provisioning", "domain_id": "..." }
```
Errors: `400` invalid request, INVALID_DOMAIN, TLD_NOT_SUPPORTED · `409` DOMAIN_ALREADY_OWNED, DOMAIN_UNAVAILABLE · `402` INSUFFICIENT_BALANCE (includes `required_cents`) or UPGRADE_REQUIRED (free account) · `403` `already_owned` flag is not permitted.

### Import Existing Domain
```
POST /domain/orgs/{org_id}/import
{ "domain": "example.com", "namecheap_api_user": "optional", "namecheap_api_key": "optional" }
```
Sets up DNS and email infrastructure automatically. Optionally updates Namecheap NS if credentials are provided.
Errors: `402` insufficient balance.

To use Namecheap automation: go to **Profile > Tools > Namecheap API Access**, generate an API Key, and whitelist the MyAPI-HQ server IP — otherwise the API calls will be rejected.

### List & Status
```
GET /domain/orgs/{org_id}/list
GET /domain/orgs/{org_id}/{domain}/status
```
Errors (status): `404` DOMAIN_NOT_FOUND.

### Renew
```
POST /domain/orgs/{org_id}/{domain}/renew
{ "years": 1 }
```
Errors: `400` invalid years · `404` DOMAIN_NOT_FOUND · `402` INSUFFICIENT_BALANCE.

### Assign Domain to Org
```
POST /domain/orgs/{org_id}/{domain}/assign
{ "org_id": "<org_id>" }
```
Associates a domain already in the account with a specific organization.
Errors: `404` DOMAIN_NOT_FOUND · `422` ORG_NOT_FOUND.

### Edge Settings

**Update:**
```
POST /domain/orgs/{org_id}/{domain}/settings
{
  "security_level": "essentially_off",  // essentially_off | medium | high | under_attack
  "browser_check": "off",               // on | off
  "purge_cache": true
}
```
*To allow AI training bots and crawlers: set `security_level: "essentially_off"` and `browser_check: "off"`.*

**Get:**
```
GET /domain/orgs/{org_id}/{domain}/settings
→ { "domain": "...", "security_level": "...", "browser_check": "...", "ai_bots_protection": "disabled", "is_robots_txt_managed": false }
```
