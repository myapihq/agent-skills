# Sabaki

**One account to run your entire startup.**

24 building blocks — website, domain, business email, card payments, customer
logins, a database, a CRM, file storage, background jobs and real deployed apps
— in one account instead of a dozen subscriptions. They already work together,
so the integrations that normally take a week are just done.

[sabaki.app](https://sabaki.app/)

## Install

```
/plugin marketplace add myapihq/agent-skills
/plugin install sabaki
```

Restart Claude Code. You'll be asked to sign in the first time your agent uses
it — no API key to create or paste.

## Any other MCP client

ChatGPT, Cursor, Windsurf, Zed, Cline, VS Code — point them at:

```
https://api.myapihq.com/mcp
```

## Try it

Ask for something that has to exist in the world:

> Put my product online, let people sign in, and take card payments.

> Register a domain for it and set up hello@ on that domain.

> Every morning, email me new customers and any failed payments.

The agent picks the tools itself. You never name them.

## Replaces

| | |
|---|---|
| Website & hosting | Vercel · Netlify · Webflow |
| Domains | GoDaddy · Namecheap |
| Email | Postmark · SendGrid · Resend |
| Customer logins | Auth0 · Clerk · Firebase Auth |
| Database & storage | Supabase · Firebase · S3 |
| CRM | HubSpot · Pipedrive · Attio |
| Automation | Zapier · Make · n8n |
| Background jobs | Inngest · Trigger.dev · cron |
| Apps & deploys | Heroku · Railway · Render · Fly |
| Analytics | Google Analytics · Plausible |

**The one you keep: Stripe.** Payments really are Stripe — your account, your
money. What disappears is the week of work around it.

## Where the instructions live

They come from the server, not from this repo. Tool descriptions, examples and
recipes arrive over the connection and update when the platform does, so they
cannot go stale in a copy somebody forgot to publish.

This repo used to ship a snapshot of them. It went four months out of date
without anyone noticing, which is why it no longer does.

---

[sabaki.app](https://sabaki.app/) · [Dashboard](https://myapihq.com/)
