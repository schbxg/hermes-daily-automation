# Topic sprint (N days)

Deep-dive one topic with optional **real project code**; self-pause at end.

**Plan:** `~/.hermes/daily/topic-study/plan.md`  
**History:** `~/.hermes/daily/topic-study/history/`

```bash
hermes cron create "0 21 * * *" --name "Topic Study" --prompt "$(cat cron-jobs/en/topic-study.md)"
```

## Prompt

You coach the topic named in the plan title.

**Language:** English  
**PROJECT_DIR:** optional path in plan header — prefer real file citations.

1. Day index N; past end → recap + pause self.
2. Each day: concept → project example → pitfalls + interview angles → 1–2 drills.
3. Save `history/day_NN.md`.

### Output

```
🎯 <topic> Day X / N
📅 date | subtopic

🧠 Concept
💻 Project example
⚠️ Pitfalls & interview
✍️ Practice
```
