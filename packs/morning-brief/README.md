# Pack: Morning Brief

A small opinionated set of jobs for a developer weekday morning.

| Time (local) | Job | Template |
|--------------|-----|----------|
| 07:30 | AI News | `cron-jobs/ai-news.md` or `cron-jobs/en/ai-news.md` |
| 08:00 | GitHub Digest | `cron-jobs/github-digest.md` |
| 08:15 | Interview (optional) | `cron-jobs/interview.md` |

## Install

```bash
# from repo root — data + skills
./scripts/install-demo.sh
./scripts/install-skills.sh

# register (adjust paths/lang)
ROOT="$(pwd)"
hermes cron create "30 7 * * 1-5" --name "AI News" \
  --prompt "$(cat "$ROOT/cron-jobs/en/ai-news.md")"
hermes cron create "0 8 * * 1-5" --name "GitHub Digest" \
  --prompt "$(cat "$ROOT/cron-jobs/en/github-digest.md")"
```

Requires: Hermes + messaging; GitHub digest needs `gh auth login`.

## Why weekday-only

Weekend noise is lower signal for most people. Change to `* * *` if you want 7 days.
