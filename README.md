# MyAPI Agent Skills

Agent skills for the [MyAPI](https://myapihq.com) ecosystem. Drop any skill into your agent and it gains instant access to real infrastructure — domains, email, storage, funnels, webhooks, and more.

## What is MyAPI?

MyAPI is a suite of API-first services designed for agents and developers. Every service shares the same authentication model, response envelope, and conventions, so once you learn one you know them all.

Start with `my-api-hq` to get an API key, then add whichever services your agent needs.

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

Each folder contains a `SKILL.md` you can load directly into any agent (Claude, GPT, Gemini, open-source). Skills follow the [skills.sh](https://skills.sh) format.

### Claude

Install via the Claude plugin registry or load the `SKILL.md` directly into your project.

### Any agent

Point your agent at the raw `SKILL.md` URL:

```
https://raw.githubusercontent.com/myapihq/agent-skills/main/<service>/SKILL.md
```

## Authentication

All services use a single API key. Get yours at [myapihq.com](https://myapihq.com) or by running the `my-api-hq` skill.

```
Authorization: Bearer <your_api_key>
```

## Links

- Docs: [docs.myapihq.com](https://docs.myapihq.com)
- npm: [@myapihq/mcp](https://www.npmjs.com/package/@myapihq/mcp) — MCP server for all services
- npm: [@myapihq/sdk](https://www.npmjs.com/package/@myapihq/sdk) — TypeScript SDK
- npm: [@myapihq/cli](https://www.npmjs.com/package/@myapihq/cli) — CLI tool
