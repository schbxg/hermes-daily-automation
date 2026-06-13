<div align="center">

# 🤖 Hermes Daily Automation

**Build a team of self-running digital employees with the Hermes Agent, powered by Xiaomi MIMO (or any LLM)**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Hermes Agent](https://img.shields.io/badge/Hermes%20Agent-Compatible-blueviolet)](https://github.com/NousResearch/hermes-agent)
[![MIMO](https://img.shields.io/badge/Xiaomi%20MIMO-Supported-orange)](https://github.com/XiaoMi)

*"AI shouldn't just be a tool you query. It should be a digital employee that runs on its own."*

**English** · [简体中文](README.zh-CN.md)

[Demo](#demo) · [Quick Start](#quick-start) · [Templates](#templates) · [How It Works](#how-it-works)

</div>

---

## What Is This

A collection of **automation templates** built on top of [Hermes Agent](https://github.com/NousResearch/hermes-agent) that help you spin up a daily, hands-off push system in minutes.

I run 10+ scheduled jobs with this setup. Every day it automatically delivers:

- 📰 **AI news digest** (scrapes Hacker News + tech sites + Twitter)
- 📚 **Tech learning** (a 40-day course, advanced day by day)
- 🎧 **English listening** (auto-generated TTS audio)
- 🎯 **Interview questions** (C++ / CUDA / system design)
- 💰 **Personal finance** (a 30-day starter plan)
- 🤔 **Daily thinking prompts** (rotating across 7 domains)
- 🤖 **A nightly self-review** where the agent "dreams" — recaps yesterday and updates its own memory

All unattended. Jobs fire in the early morning, and the results are waiting in Telegram when you wake up.

---

## Demo

<div align="center">

### Daily Push Overview

<img src="screenshots/overview.png" width="600" alt="Daily Automation Overview">

*Everything runs at night — by morning your Telegram is already lined up for you.*

</div>

---

## Quick Start

### Prerequisites

1. Install [Hermes Agent](https://github.com/NousResearch/hermes-agent)
2. Configure an LLM provider (MIMO / DeepSeek / OpenAI / Claude all work)
3. Configure Telegram or another messaging platform

### Installation

```bash
# 1. Clone the repo
git clone https://github.com/schbxg/hermes-daily-automation.git
cd hermes-daily-automation

# 2. Copy the config template
cp config-template.yaml ~/.hermes/config.yaml

# 3. Create a scheduled job (AI news as an example)
hermes cron create "0 3 * * *" --name "AI News" --prompt "$(cat cron-jobs/ai-news.md)"

# 4. List your jobs
hermes cron list
```

### Customize Your First Job

```bash
# Edit the prompt template
vim cron-jobs/ai-news.md

# Create the scheduled job
hermes cron create "0 8 * * *" --name "My Daily" --prompt "$(cat cron-jobs/ai-news.md)"

# Test run it
hermes cron run <job_id>
```

---

## Templates

### 📰 Information Aggregation

| Template | Description | Suggested Schedule |
|----------|-------------|--------------------|
| [AI News](cron-jobs/ai-news.md) | Scrapes HN + tech sites + Twitter, generates a digest | Daily 3:00 |
| [Tweet Drafts](cron-jobs/tweet-draft.md) | Generates 2-3 tweet drafts daily for human review | Daily 3:00 |

### 📚 Learning

| Template | Description | Suggested Schedule |
|----------|-------------|--------------------|
| [Tech Learning](cron-jobs/learning.md) | Advances through a tech course on a plan | Daily 5:00 |
| [English](cron-jobs/english.md) | Vocabulary + listening + TTS audio | Daily 7:30 |
| [Interview Prep](cron-jobs/interview.md) | One interview question + answer per day | Daily 7:00 |
| [Code Reading](cron-jobs/code-reading.md) | Read a huge file over N days, then auto-pauses itself | Daily 20:00 |
| [Topic Study](cron-jobs/topic-study.md) | N-day deep dive on one topic, with real-code examples | Daily 21:00 |

### 🤖 Self-Reflection

| Template | Description | Suggested Schedule |
|----------|-------------|--------------------|
| [Daily Review ("Dreaming")](cron-jobs/daily-review.md) | At 3 AM the agent reviews yesterday's sessions, writes lessons to memory, and suggests new skills | Daily 3:00 |

### 💡 Lifestyle

| Template | Description | Suggested Schedule |
|----------|-------------|--------------------|
| [Daily Thinking](cron-jobs/thinking.md) | Rotates through philosophy / creativity / decision-making | Daily 8:00 |
| [Finance](cron-jobs/finance.md) | A 30-day personal finance starter plan | Daily 21:00 |

### 🧩 Prompt Templates

Reusable, parameterized prompt building blocks you can adapt for your own jobs — see [prompt-templates/](prompt-templates/).

### 🔧 Core Mechanics

| File | Description |
|------|-------------|
| [AGENTS template](AGENTS-template.md) | Project-level AI onboarding file template |
| [Content Progression](skills/content-progression.md) | A Skill that prevents cron jobs from repeating content |

---

## How It Works

### Architecture

```
┌─────────────────────────────────────────────┐
│           Hermes Agent (framework)          │
│  ┌─────────┐ ┌─────────┐ ┌─────────────┐  │
│  │  Cron   │ │ Memory  │ │   Skills    │  │
│  │ schedule│ │ system  │ │ experience  │  │
│  └────┬────┘ └────┬────┘ └──────┬──────┘  │
│       │           │             │          │
│  ┌────▼───────────▼─────────────▼──────┐  │
│  │         Orchestration Loop          │  │
│  │      (Prompt → LLM → Tool)          │  │
│  └────┬────────────────────────────────┘  │
│       │                                    │
└───────┼────────────────────────────────────┘
        │
        ▼
┌───────────────┐
│   LLM Model   │  ← MIMO / DeepSeek / Claude / GPT
└───────┬───────┘
        │
        ▼
┌───────────────┐
│  Messaging    │  ← Telegram / Discord / Slack
└───────────────┘
```

### Content Progression (Anti-Repetition)

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ Plan file    │────▶│  Cron Job    │────▶│ History dir  │
│ (static)     │     │ (daily fire) │     │ (accumulates)│
└──────────────┘     └──────┬───────┘     └──────────────┘
                            │
                  1. Read plan → what day is it?
                  2. Read history → what was covered?
                  3. Generate content → no repeats
                  4. Save to history dir
```

The key idea: **use the file system as the agent's external memory** so continuity holds across sessions.

### Finite Plans That Pause Themselves

Not every job should run forever. A course or a code-reading plan has an end. Each such job
computes "what day is it", and once the plan is over it calls
`cronjob(action='pause', job_id=<self>)` to **pause itself** — no zombie jobs, no manual cleanup.

```
Day 1 ─▶ Day 2 ─▶ ... ─▶ Day N ─▶ "plan finished" ─▶ pause(self)
```

### Grounding in Your Real Code

Learning jobs don't just explain concepts in the abstract. You point them at your project
directory, and they pull **real examples from your actual code** (with file references). What
you learn maps directly onto what you're building, so it sticks.

---

## Best Practices

### 1. Spread Out the Timing

```yaml
# ❌ Bad: 7 jobs all at 3:00
3:00 - job1, job2, job3, job4, job5, job6, job7

# ✅ Good: spread across the day
3:00  - AI News
5:00  - Tech Learning
7:00  - Interview Prep
7:30  - English
8:00  - Daily Thinking
21:00 - Finance + Tweet reminders
```

### 2. Every Prompt Should "Read History → Avoid Repeats → Save"

```markdown
## Step 1: Determine what day it is
Run `date +%Y-%m-%d`, compute days elapsed since Day 1.

## Step 2: Read history
ls /path/to/history/  # read the last 3 days

## Step 3: Generate content
Make sure it differs from history.

## Step 4: Save to history
Write to /path/to/history/day_XX.md
```

### 3. AGENTS.md Is Onboarding for the AI

```markdown
# Project overview
# Directory structure
# Code conventions
# Known pitfalls
# Workflow
```

---

## FAQ

### Q: Will it push the same content every day?

No. Every template combines:
1. A plan file (static framework)
2. A history directory (accumulating record)
3. A "what day is it" anchor (time anchor)

Together these guarantee content progresses without repeating.

### Q: Which model is best?

| Model | Best For | Cost |
|-------|----------|------|
| Xiaomi MIMO | Everyday tasks, Chinese content | Cheap |
| DeepSeek | Tech learning, code analysis | Very cheap |
| Claude Sonnet | Complex reasoning, long docs | Medium |
| GPT-4o | General-purpose | Medium |

Recommendation: MIMO/DeepSeek for daily tasks, Claude/GPT for complex ones.

### Q: Can I use Discord/Slack instead of Telegram?

Yes. Hermes supports 10+ messaging platforms with the same config approach.

### Q: How do I debug a cron job?

```bash
# Trigger once manually
hermes cron run <job_id>

# Follow logs
hermes logs --follow

# Pause a job
hermes cron pause <job_id>
```

---

## Contributing

PRs adding new cron job templates are welcome!

Template format:
```markdown
# Job name

[Describe the job's purpose]

## Steps
1. ...
2. ...

## Output format
[Define the output template]
```

---

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=schbxg/hermes-daily-automation&type=Date)](https://star-history.com/#schbxg/hermes-daily-automation&Date)

---

## Acknowledgements

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — the AI agent framework
- [Nous Research](https://nousresearch.com) — the team behind the framework
- [Xiaomi MIMO](https://github.com/XiaoMi) — LLM support

---

<div align="center">

**If you find this useful, please drop a ⭐ Star!**

</div>
