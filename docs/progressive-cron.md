# Progressive Cron

> **One-liner:** Cron agents forget yesterday. Files don't.  
> Pair a **static plan**, an **append-only history**, and a **day index** so scheduled LLM jobs advance without a database.

**Repo:** [schbxg/hermes-daily-automation](https://github.com/schbxg/hermes-daily-automation)  
**Skill:** [`skills/content-progression/`](../skills/content-progression/SKILL.md) ([agentskills.io](https://agentskills.io)-compatible)

---

## The problem

A daily cron that says *"teach me systems design"* will happily re-teach **Day 1** forever. The model has no durable session across fires unless you give it one.

Chat memory, vector stores, and "remember this" tools can help — but for personal automations they are often:

- heavier than needed  
- hard to audit  
- easy to over-trust  

## The pattern

```text
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ plan.md      │────▶│  cron fire   │────▶│ history/     │
│ (syllabus)   │     │  (agent)     │     │ (append-only)│
└──────────────┘     └──────┬───────┘     └──────────────┘
                            │
                 1. date → day N
                 2. read plan row N
                 3. skim last 3 history files
                 4. generate NEW content
                 5. write history/day_NN.md
                 6. if N > end → pause(self)
```

| Anchor | Role | Example |
|--------|------|---------|
| **Plan** | What *should* happen | `~/.hermes/daily/learning/plan.md` |
| **History** | What *did* happen | `.../history/day_03_locks.md` |
| **Day index** | Which row is today | `Day 1 = 2026-07-01` + `date` |

## Drop-in prompt block

```markdown
## Progressive Cron protocol
1. Run `date +%Y-%m-%d`. Day 1 = <START_DATE>. Compute day index N.
2. Read plan: ~/.hermes/daily/<job>/plan.md → today's topic.
3. List ~/.hermes/daily/<job>/history/ and read the last 3 files.
4. Generate content that does NOT repeat those topics/examples.
5. Save to ~/.hermes/daily/<job>/history/day_NN_<slug>.md
6. If N > plan length: summarize completion, pause this cron job, stop.
```

## Finite vs infinite jobs

| Kind | Examples | End behavior |
|------|----------|--------------|
| **Finite** | 30-day finance, N-day code reading | Self-`pause` when done |
| **Infinite** | AI news, thinking rotation | Never pause; still write history for de-dupe |

## Minimal plan file

```markdown
# Systems design
> Day 1 = 2026-07-01

| Day | Topic | Keywords |
|-----|-------|----------|
| 1 | Load balancing | L4, L7 |
| 2 | Caching | TTL, stampede |
| 3 | Consistency | CAP, quorum |
```

## Why this works

1. **Explicit state** — you can `ls` and `diff` progress  
2. **Model-agnostic** — any tool-using agent that can shell + read/write files  
3. **Cheap** — no extra infra for a personal OS  
4. **Composable** — works inside Hermes, OpenClaw-style agents, or a plain crontab + CLI  

## Common failures

| Failure | Fix |
|---------|-----|
| Agent claims it checked history | Require real `ls` / `read` tool calls |
| Always Day 1 | Fix `Day 1 =` header; compute N from calendar, not "file count + 1" alone |
| Zombie finite job | Enforce pause step |
| Path chaos | Standardize on `~/.hermes/daily/<job>/` |

Full troubleshooting: [skills/content-progression/references/troubleshooting.md](../skills/content-progression/references/troubleshooting.md)

## Try it

```bash
git clone https://github.com/schbxg/hermes-daily-automation.git
cd hermes-daily-automation
./scripts/install-demo.sh
./scripts/install-skills.sh
```

Chinese overview: [progressive-cron.zh-CN.md](progressive-cron.zh-CN.md)

---

*Named and documented so it can be cited, forked, and reused outside this repo.*
