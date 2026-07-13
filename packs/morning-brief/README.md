# Pack: Morning Brief

A small opinionated set of jobs for a developer **weekday** morning.

| Time (local) | Job | Template | Notes |
|--------------|-----|----------|--------|
| 07:30 | AI News | `ai-news` | Mon–Fri |
| 08:00 | GitHub Digest | `github-digest` | needs `gh auth login` |
| 08:15 | Interview | `interview` | **optional** (`--with-optional`) |

## One-command install

```bash
# from repo root
./scripts/install-pack.sh morning-brief

# English prompts + optional interview job
./scripts/install-pack.sh morning-brief --en --with-optional

# Print hermes commands without creating crons
./scripts/install-pack.sh morning-brief --dry-run
```

This will:

1. Seed `~/.hermes/daily/` (via `install-demo.sh`)
2. Register each job from [`manifest.tsv`](manifest.tsv)

## Manual (legacy)

```bash
./scripts/install-demo.sh
ROOT="$(pwd)"
hermes cron create "30 7 * * 1-5" --name "AI News (Morning Brief)" \
  --prompt "$(cat "$ROOT/cron-jobs/en/ai-news.md")"
hermes cron create "0 8 * * 1-5" --name "GitHub Digest (Morning Brief)" \
  --prompt "$(cat "$ROOT/cron-jobs/en/github-digest.md")"
```

## Requirements

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) + messaging configured
- GitHub digest: `gh` CLI authenticated

## Why weekday-only

Weekend noise is lower signal for most people. Edit `manifest.tsv` schedules if you want 7 days (`* * *` instead of `1-5`).
