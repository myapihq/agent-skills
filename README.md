# MyAPI Agent Skills

Agent skills for the [MyAPI](https://myapihq.com) ecosystem. Drop any skill into your agent and it gains instant access to real infrastructure — domains, email, storage, funnels, webhooks, and more.

## What is MyAPI?

MyAPI is a suite of API-first services designed for agents and developers. Every service shares the same authentication model, response envelope, and conventions, so once you learn one you know them all.

Start with `my-api-hq` — it handles registration and gives your agent an API key. All other services require that key.

## Skills

| Skill | What it does |
|---|---|
| [my-api-hq](./my-api-hq/) | Auth, organizations, and billing. **Start here** — all other skills need an API key from this one. |
| [my-domain-api](./my-domain-api/) | Register domains, check availability, manage DNS and edge settings. |
| [my-email-api](./my-email-api/) | Mailboxes, sending, reading, email verification, and AI-powered templates with open/click tracking. |
| [my-funnel-api](./my-funnel-api/) | Host multi-page sites and funnels from raw HTML or AI-generated content. |
| [my-image-api](./my-image-api/) | AI image generation with automatic cloud storage. Pass a prompt, get a hosted URL. |
| [my-pixel-api](./my-pixel-api/) | Query web visits, email events, and identity resolution from the tracking pixel. |
| [my-storage-api](./my-storage-api/) | Upload and host static assets (images, files) with permanent public URLs. |
| [my-url-to](./my-url-to/) | URL shortening and link tracking via myurlto.com. |
| [my-webhook-api](./my-webhook-api/) | Create inbound webhook endpoints and fan out payloads to workflows. |
| [my-workflow-api](./my-workflow-api/) | Webhook-triggered automations with conditions, actions, and retries. |

## Usage

Each skill is a folder containing a `SKILL.md`. Copy the folder into your agent's skills directory:

| Agent | Skills directory |
|---|---|
| Claude | `~/.claude/skills/` |
| Gemini | `~/.gemini/skills/` |

Then restart your agent and it will pick up the skill automatically.

### Claude plugin

Install directly from the Claude plugin registry — no manual setup needed.

## Authentication

Register at [myapihq.com](https://myapihq.com) to get an API key, then set it in your environment:

```
Authorization: Bearer <your_api_key>
```

The `my-api-hq` skill also supports autonomous agent registration — an agent can create its own account without human input.

