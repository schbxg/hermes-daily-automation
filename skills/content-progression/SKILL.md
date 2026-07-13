---
name: content-progression
description: >
  Progressive Cron — keep scheduled agent jobs from repeating content by using
  plan.md + history/ + day-index as filesystem memory across sessions. Use when
  building daily curricula, interview drills, learning paths, finance courses,
  finite N-day plans, or any cron that must advance day by day without a database.
version: 1.1.0
author: schbxg
license: MIT
compatibility: Works with Hermes Agent cron; portable to any agent that can read/write files and run date.
metadata:
  hermes:
    tags: [cron, progressive-cron, memory, curriculum, daily, anti-repeat, automation]
    category: productivity
    related_skills: [daily-self-review, github-morning-digest]
  openstandard: agentskills.io
---

# Progressive Cron (Content Progression)

**Problem:** Cron agents are stateless. Yesterday's lesson is forgotten → Day 1 forever.  
**Solution:** Three filesystem anchors — **plan**, **history**, **day index**.

## When to use

- Designing or debugging a **daily / multi-day** automated job
- User says: "don't repeat", "day by day", "course", "curriculum", "第几天"
- Finite plans that should **pause themselves** when finished

## When NOT to use

- One-shot tasks with no continuity
- Pure chat Q&A with no schedule
- Jobs that *should* re-run the same checklist every day (use a static prompt)

## Protocol (always)

1. **Day index** — `date +%Y-%m-%d`. Day 1 = start date from plan header. Compute `N`.
2. **Plan** — read `~/.hermes/daily/<job>/plan.md` (or job-specific path) → row for day `N`.
3. **History** — `ls` history dir; **read last 3–5 files**. Do not re-cover those topics.
4. **Generate** — new content only.
5. **Persist** — write `history/day_NN_<slug>.md` (NN zero-padded).
6. **Finite end** — if `N` > plan length: short graduation summary, then  
   `cronjob(action='pause', job_id=<self>)` (Hermes) or disable the schedule.

Copy-paste block for any prompt:

```markdown
## Progressive Cron protocol
1. Run `date +%Y-%m-%d`. Day 1 = <START_DATE>. Compute day index N.
2. Read plan: ~/.hermes/daily/<job>/plan.md → today's topic.
3. List ~/.hermes/daily/<job>/history/ and read the last 3 files.
4. Generate content that does NOT repeat those topics/examples.
5. Save to ~/.hermes/daily/<job>/history/day_NN_<slug>.md
6. If N > plan length: summarize + pause this cron job, then stop.
```

## Default layout

```text
~/.hermes/daily/<job>/
├── plan.md
├── history/
│   ├── day_01_intro.md
│   └── day_02_…
└── (optional) AGENTS.md
```

Templates: [assets/plan-template.md](assets/plan-template.md), [assets/history-day-template.md](assets/history-day-template.md).  
Deep dive: [references/protocol.md](references/protocol.md).  
Ops issues: [references/troubleshooting.md](references/troubleshooting.md).

## Domain rotation (no fixed plan)

```text
N = days since START
domain = N mod K   # e.g. K=7
```

Still **write a history file** so consecutive days do not collide on the same angle.

## Quality bar

- Prefer **real project paths** when teaching code (cite files; don't invent APIs).
- Cap messaging length (Telegram-friendly).
- Never claim "I checked history" without actually listing/reading files.

## Install

From this repo:

```bash
./scripts/install-skills.sh
# → ~/.hermes/skills/productivity/content-progression
```

Or with the daily data scaffold: `./scripts/install-demo.sh` (offers skills install).
