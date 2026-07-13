<div align="center">

<img src="screenshots/banner.png" width="100%" alt="Hermes Daily Automation — turn any LLM into self-running digital employees">

# Hermes Daily Automation

**Your personal AI morning OS** — news, learning, interview drills, GitHub triage, and a nightly self-review that writes back to memory.  
Built as a **Progressive Cron** pack for [Hermes Agent](https://github.com/NousResearch/hermes-agent) (works with MIMO / DeepSeek / OpenAI / Claude / …).

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Hermes Agent](https://img.shields.io/badge/Hermes%20Agent-Compatible-blueviolet)](https://github.com/NousResearch/hermes-agent)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

*AI shouldn't just answer questions. It should show up for work on its own.*

**English** · [简体中文](README.zh-CN.md)

[5-minute demo](#-5-minute-demo) · [Skills](#-install-skills-agentskillsio) · [Packs](#-packs) · [Examples](#-example-outputs) · [Progressive Cron](#-progressive-cron) · [Templates](#-templates) · [Cost](#-cost-notes)

</div>

---

## Why this exists

Hermes already has cron, memory, and skills. What's missing for most people is a **ready-made personal OS**: opinionated jobs, default paths, anti-repeat curriculum logic, and samples you can trust.

This repo is that pack:

| You get | Not |
|---------|-----|
| Installable daily jobs with `~/.hermes/daily/` defaults | Another agent framework |
| **Progressive Cron** (plan + history + day index) | Stateless prompts that re-teach Day 1 forever |
| Finite courses that **pause themselves** | Zombie crons after a 30-day plan ends |
| EN + ZH templates | English README only |

---

## ⚡ 5-minute demo

**Prerequisites:** [Hermes Agent](https://github.com/NousResearch/hermes-agent) installed, a model provider configured, messaging (Telegram / Discord / …) working.

```bash
git clone https://github.com/schbxg/hermes-daily-automation.git
cd hermes-daily-automation

# 1) Create ~/.hermes/daily/* + seed plans
chmod +x scripts/install-demo.sh
./scripts/install-demo.sh
# English prompts: HERMES_DAILY_LANG=en ./scripts/install-demo.sh
# Non-interactive cron: HERMES_DAILY_CREATE_CRON=yes ./scripts/install-demo.sh

# 2) If the script registered "AI News Demo", run it once:
hermes cron list
hermes cron run <job_id>
```

You should receive one digest in your messaging app. Shape reference: [`examples/ai-news-sample.md`](examples/ai-news-sample.md).

Optional config seed (only if you don't already have Hermes configured):

```bash
cp config-template.yaml ~/.hermes/config.yaml
# then: hermes setup / hermes model / hermes gateway
```

Non-interactive full bootstrap:

```bash
HERMES_DAILY_CREATE_CRON=yes HERMES_DAILY_INSTALL_SKILLS=yes ./scripts/install-demo.sh
```

---

## 🧩 Install skills (agentskills.io)

Portable skills with YAML frontmatter — load in Hermes (and other agentskills-compatible runtimes):

| Skill | What it teaches the agent |
|-------|---------------------------|
| [`content-progression`](skills/content-progression/SKILL.md) | Progressive Cron protocol |
| [`daily-self-review`](skills/daily-self-review/SKILL.md) | Nightly human-session retro |
| [`github-morning-digest`](skills/github-morning-digest/SKILL.md) | `gh` morning triage |

```bash
./scripts/install-skills.sh
# live symlink while developing skills:
HERMES_SKILLS_LINK=1 ./scripts/install-skills.sh

hermes skills list
```

Installs to `~/.hermes/skills/productivity/<skill-name>/` by default. See [`skills/README.md`](skills/README.md).

---

## 📸 Demo & examples

<div align="center">

<img src="screenshots/overview.png" width="600" alt="Daily automation overview">

*Product overview (mock layout). Prefer the markdown samples below for concrete message shape.*

</div>

### Example outputs (copy-paste reality check)

| Sample | What it looks like on a good day |
|--------|----------------------------------|
| [AI News](examples/ai-news-sample.md) | International + local bullets + editor take |
| [Interview](examples/interview-sample.md) | One question, answer, follow-ups |
| [Learning](examples/learning-sample.md) | Day N curriculum card |
| [GitHub digest](examples/github-digest-sample.md) | Needs-you / PRs / 30-min focus |
| [Daily review](examples/daily-review-sample.md) | ≤300 word night retro |
| [Thinking](examples/thinking-sample.md) | Open question + angles |

More: [`examples/README.md`](examples/README.md).

> Real Telegram screenshots from your own run beat any banner — PRs adding redacted photos under `screenshots/` are welcome.

---

## 🧠 Progressive Cron

**Named mechanism:** treat the filesystem as the agent's cross-session memory.

```text
┌──────────┐     ┌──────────┐     ┌──────────┐
│  Plan    │────▶│ Cron job │────▶│ History  │
│ (static) │     │  (fire)  │     │ (append) │
└──────────┘     └────┬─────┘     └──────────┘
                      │
           1. date → day N
           2. read plan row N
           3. skim last 3 history files
           4. generate NEW content
           5. write history/day_NN.md
           6. if past end → pause(self)
```

**Shareable write-up (cite this):** [`docs/progressive-cron.md`](docs/progressive-cron.md) · [中文](docs/progressive-cron.zh-CN.md)  
**Installable skill:** [`skills/content-progression/SKILL.md`](skills/content-progression/SKILL.md)

**Why star this:** you can lift Progressive Cron into *any* agent cron (Hermes, OpenClaw, homemade) without adopting the rest of the pack.

---

## 🎁 Packs

Ready-made job bundles — **one command registers every cron in the pack**:

```bash
./scripts/install-pack.sh list
./scripts/install-pack.sh morning-brief              # weekday news + GitHub
./scripts/install-pack.sh learning-os                # study + interview + review
./scripts/install-pack.sh morning-brief --en --with-optional
./scripts/install-pack.sh learning-os --dry-run      # print commands only
```

| Pack | For |
|------|-----|
| [Morning Brief](packs/morning-brief/README.md) | Weekday AI news + GitHub triage |
| [Learning OS](packs/learning-os/README.md) | Curriculum + interview + nightly review |

See [`packs/README.md`](packs/README.md) and [`scripts/install-pack.sh`](scripts/install-pack.sh).

---

## 📦 Templates

Every job has **ZH** (default path) and **EN** (`cron-jobs/en/`).

### Information

| Template | Description | Schedule |
|----------|-------------|----------|
| [AI News](cron-jobs/ai-news.md) · [EN](cron-jobs/en/ai-news.md) | HN/web + optional X RSS digest | Daily 03:00–08:00 |
| [GitHub Digest](cron-jobs/github-digest.md) · [EN](cron-jobs/en/github-digest.md) | PR / CI / notifications triage (`gh`) | Daily 08:00 |
| [Tweet drafts](cron-jobs/tweet-draft.md) · [EN](cron-jobs/en/tweet-draft.md) | 2–3 human-reviewed drafts | Daily 09:00 |

### Learning

| Template | Description | Schedule |
|----------|-------------|----------|
| [Tech learning](cron-jobs/learning.md) · [EN](cron-jobs/en/learning.md) | Plan-driven course + history | Daily 05:00 |
| [English](cron-jobs/english.md) · [EN](cron-jobs/en/english.md) | Vocab / listening + TTS | Daily 07:30 |
| [Interview](cron-jobs/interview.md) · [EN](cron-jobs/en/interview.md) | One question / day | Daily 07:00 |
| [Code reading](cron-jobs/code-reading.md) · [EN](cron-jobs/en/code-reading.md) | N-day file map → self-pause | Daily 20:00 |
| [Topic study](cron-jobs/topic-study.md) · [EN](cron-jobs/en/topic-study.md) | N-day deep dive + real code | Daily 21:00 |

### Self-improvement

| Template | Description | Schedule |
|----------|-------------|----------|
| [Daily review (“dreaming”)](cron-jobs/daily-review.md) · [EN](cron-jobs/en/daily-review.md) | User-session retro → MEMORY.md | Daily 03:00 |

### Lifestyle

| Template | Description | Schedule |
|----------|-------------|----------|
| [Thinking](cron-jobs/thinking.md) · [EN](cron-jobs/en/thinking.md) | 7-domain rotation | Daily 08:00 |
| [Finance](cron-jobs/finance.md) · [EN](cron-jobs/en/finance.md) | 30-day starter (education only) | Daily 21:00 |

### Building blocks

| Path | Role |
|------|------|
| [`prompt-templates/`](prompt-templates/) | Copy-paste prompts (review, debug, content, …) |
| [`skills/`](skills/README.md) | agentskills.io packages |
| [`packs/`](packs/README.md) | Morning Brief / Learning OS |
| [`docs/progressive-cron.md`](docs/progressive-cron.md) | Citeable mechanism essay |
| [`AGENTS-template.md`](AGENTS-template.md) | Project onboarding for agents |
| [`data/`](data/) | Seed plans copied by the installer |

---

## How it fits together

```text
┌─────────────────────────────────────────────┐
│           Hermes Agent (runtime)            │
│  Cron · Memory · Skills · Messaging         │
└───────────────────┬─────────────────────────┘
                    │ loads prompts from this pack
                    ▼
┌─────────────────────────────────────────────┐
│     ~/.hermes/daily/   (your state)         │
│  plan.md · history/ · MEMORY.md             │
└───────────────────┬─────────────────────────┘
                    ▼
         Telegram / Discord / Slack / …
```

### Best practices

1. **Stagger jobs** (don't fire 10 crons at 03:00).
2. Every curriculum job: **read history → write history**.
3. Keep an `AGENTS.md` in real projects so learning jobs can ground in your code.
4. Cap message length for mobile reading.

---

## Cost notes

Rough order-of-magnitude for **short digests** on cheap APIs (DeepSeek / MIMO-class):

| Load | Ballpark |
|------|----------|
| 1× AI News / day | Often **well under $0.01–0.05**/day |
| Full pack (8–10 jobs) | Commonly **cents per day**, not dollars — measure with your provider |

Heavy jobs (large code reading, long web scrapes) cost more; start with **one** demo job.

---

## FAQ

**Will it repeat the same content every day?**  
Not if you follow Progressive Cron (plan + history + day index). See the skill doc.

**Discord/Slack instead of Telegram?**  
Yes — Hermes multi-platform gateway; templates don't hardcode Telegram APIs.

**Debug a job**

```bash
hermes cron run <job_id>
hermes logs --follow
hermes cron pause <job_id>
```

**Override data root**

```bash
export HERMES_DAILY_HOME=/path/to/daily
./scripts/install-demo.sh
```

---

## Contributing

PRs welcome — new jobs, EN translations, redacted screenshots, example outputs.  
See [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Acknowledgements

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) / [Nous Research](https://nousresearch.com)
- Xiaomi MIMO and every cheap tool-calling model that makes daily agents practical

---

<div align="center">

**If this saved you an evening of prompt plumbing, star the repo — it helps others find a working pack.**

</div>
