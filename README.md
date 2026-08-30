# MyAPI for Claude Code

Give your agent the ability to put real things on the internet — a website on
your own domain, business email, a customer list, payments, sign-in for your
users, background jobs, and a git repo it can commit to and deploy.

Not descriptions of those things. The actual things, live, at a URL you can
open.

## Install

```
/plugin marketplace add myapihq/agent-skills
/plugin install myapi
```

Then restart Claude Code. You will be asked to sign in the first time your
agent uses it.

## Try it

Ask for something that has to exist in the world:

> Put a landing page for a bakery called Aurora live on the internet.

> Register a domain for it, set up hello@ on that domain, and wire the
> contact form to a customer list.

> Deploy a small API that stores signups, and give me the URL.

The agent picks the tools itself. You do not need to name them.

## What it can do

**Websites** — publish a page, put it on your own domain, custom subdomains
**Domains** — check availability, register, DNS handled for you
**Email** — mailboxes on your domain, send, inbox and outbox
**Customers** — a CRM, contact forms wired to it, lead search
**Payments** — take card payments (connect your own Stripe account)
**Sign-in** — OIDC for *your* users, with Google or a password
**Data** — a key-value store, file storage, images and logos
**Code** — a git repo with commits, branches and tags; deploy functions and
containers straight from it
**Behind the scenes** — background jobs, scheduled work, webhooks, analytics

Anything without a dedicated tool is still reachable: the server can search
its own API and call any published route.

## Where the instructions live

They come from the server, not from this repo. Tool descriptions, worked
examples and recipes arrive over the connection and are updated when the
platform is — so they cannot go stale in a copy somebody forgot to publish.

This repo used to ship a snapshot of those instructions. It went four months
out of date without anyone noticing, which is why it no longer does.

## Not using Claude Code?

The server speaks the Model Context Protocol over HTTP:

```
https://api.myapihq.com/mcp
```

Any MCP client can connect to it.

---

[myapihq.com](https://myapihq.com/)
