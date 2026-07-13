# Progressive Cron — protocol reference

## Why files beat chat memory

| Store | Survives process restart | Auditable | Works offline |
|-------|--------------------------|-----------|---------------|
| Model context | No | No | Yes (until cleared) |
| Vector DB | Yes | Medium | Depends |
| **plan + history files** | Yes | Yes (`git`/diff) | Yes |

Cron invocations are new sessions. Files are the cheapest cross-session bus.

## Computing day index

```bash
# Example: Day 1 = 2026-07-01, today = 2026-07-13 → N = 13
python3 - <<'PY'
from datetime import date
start = date.fromisoformat("2026-07-01")
today = date.today()
print((today - start).days + 1)
PY
```

Store `Day 1 = YYYY-MM-DD` at the top of `plan.md` so the agent does not guess.

## History file naming

Recommended:

```text
day_01_intro.md
day_02_memory-model.md
YYYY-MM-DD.md          # for pure digests (news, github)
```

Rules:

- Zero-pad day numbers for sort order
- Slug = short kebab topic
- One file per successful run (even if content is short)

## Self-pause contract (Hermes)

Only for **finite** plans (courses, code-reading sprints):

1. Detect `N > max_day` or missing plan row  
2. Message user: plan complete + 2–3 sentence recap  
3. Call `cronjob(action='pause', job_id=<current>)`  
4. Do not generate fake "Day N+1" content  

Infinite jobs (news, thinking rotation) **never** self-pause.

## Interaction with MEMORY.md

- Curriculum detail → `history/`  
- Cross-job lessons ("always ls history first") → `~/.hermes/daily/MEMORY.md` or agent profile memory  
- Nightly review skill should prefer **user sessions**, not dumping every cron log into MEMORY

## Minimal evaluation checklist

After 3 scheduled runs, manually open `history/`:

- [ ] Three distinct day files exist  
- [ ] Topics match plan rows  
- [ ] No near-duplicate titles  
- [ ] Finite jobs stop after last day  
