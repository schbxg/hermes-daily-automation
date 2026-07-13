---
name: daily-self-review
description: >
  Nightly "dreaming" retrospective — review the human's recent work sessions
  (not other cron noise), extract lessons, append to MEMORY.md, suggest new
  skills. Use for 复盘, daily review, dream cron, end-of-day reflection, or
  when the user asks what they accomplished yesterday.
version: 1.0.0
author: schbxg
license: MIT
compatibility: Hermes Agent with session_search (or equivalent) and file write access.
metadata:
  hermes:
    tags: [retrospective, dream, review, memory, cron, 复盘]
    category: productivity
    related_skills: [content-progression]
  openstandard: agentskills.io
---

# Daily Self-Review ("Dreaming")

## When to use

- Nightly cron (~03:00)
- User asks for 复盘 / "what did we do yesterday"
- After a heavy work day, need a short written retro

## When NOT to use

- Reviewing only automated cron outputs (too noisy as primary signal)
- Writing long weekly reports (raise the word cap intentionally)

## Workflow

1. **Time anchor** — run `date`; default window = previous calendar day / last ~24h.
2. **Search human sessions** — `session_search` (or logs). Prefer interactive sources (CLI, Telegram DMs).  
   **Ignore** bulk cron execution noise unless the user was in the loop.
3. **Read MEMORY** — `~/.hermes/daily/MEMORY.md` and/or profile `MEMORY.md` so lessons stay consistent.
4. **Extract** — done / worked / failed / risks (max a few bullets each).
5. **Write back** — append durable lessons to MEMORY; suggest a Skill name if a workflow repeated ≥2 times.
6. **Archive** — `~/.hermes/daily/daily-review/history/YYYY-MM-DD.md`
7. **Deliver** — ≤300 words messaging-friendly summary.

## Output template

```text
📅 YYYY-MM-DD 复盘

✅ 完成
- …

💡 教训
- …

⚠️ 积压 / 风险
- …
```

## Cron prompt source

Repo template: `cron-jobs/daily-review.md` (EN: `cron-jobs/en/daily-review.md`).

## Related

Progressive Cron for curricula: skill `content-progression`.
