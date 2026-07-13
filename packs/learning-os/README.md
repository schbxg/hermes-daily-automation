# Pack: Learning OS

Curriculum-style jobs using **Progressive Cron**.

| Time | Job | Notes |
|------|-----|--------|
| 05:00 | Tech learning | Needs `~/.hermes/daily/learning/plan.md` |
| 07:00 | Interview | Domain rotation + history |
| 20:00 | Code reading | Finite; self-pauses |
| 21:00 | Topic study | Optional `PROJECT_DIR` in plan |
| 03:00 | Daily review | Writes MEMORY — human sessions only |

## Setup

```bash
./scripts/install-demo.sh   # seeds sample plans
# edit:
#   ~/.hermes/daily/learning/plan.md
#   ~/.hermes/daily/code-reading/plan.md
#   ~/.hermes/daily/topic-study/plan.md

ROOT="$(pwd)"
hermes cron create "0 5 * * *" --name "Tech Learning" \
  --prompt "$(cat "$ROOT/cron-jobs/learning.md")"
hermes cron create "0 7 * * *" --name "Interview" \
  --prompt "$(cat "$ROOT/cron-jobs/interview.md")"
hermes cron create "0 3 * * *" --name "Daily Review" \
  --prompt "$(cat "$ROOT/cron-jobs/daily-review.md")"
```

Read: [Progressive Cron](../../docs/progressive-cron.md).
