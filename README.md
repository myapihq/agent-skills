# MyAPI Agent Skills

Agent skills for the [MyAPI](https://myapihq.com) ecosystem. Drop them into your
agent and it gains instant access to real infrastructure — domains, email,
containers, storage, funnels, payments, CRM, and more.

## Install

```sh
npm install -g @myapihq/cli
myapi install-skills
```

That installs all 25 skills for Claude, Gemini and Cursor. Then:

```sh
myapi account setup     # create an account and mint an API key
myapi status            # your account and every resource in the default org
```

## Where the skills live

**In [myapihq/myapi](https://github.com/myapihq/myapi), under `skills/`** — not
in this repo. They ship inside `@myapihq/cli`, which is what `install-skills`
unpacks, so the skills you install always match the client you installed them
with.

This repo holds a snapshot of 10 skills from April 2026 and is no longer
updated. `install.sh` is kept working — it now installs the CLI and delegates to
it — because the `curl … | sh` one-liner is in circulation and should not break.

The snapshot is left here rather than deleted so old links keep resolving, but
**do not copy from it**: it predates 15 slots, and one of its skills is for a
service that has since been renamed. Read the skills in the myapi repo instead.

## Why the change

The skills used to be published here as a zip on Cloud Storage. When they moved
to the myapi repo, the workflow that built that zip kept watching the old
directory — so it never ran again and never failed either. It just quietly
stopped mattering, and for four months this installer handed people 10 of 25
skills without anyone noticing.

Shipping the skills inside the CLI removes the second copy. There is nothing
left to forget to publish.

## Authentication

`myapi account setup` handles this. For direct HTTP calls, register at
[myapihq.com](https://myapihq.com) and send:

```
Authorization: Bearer <your_api_key>
```
