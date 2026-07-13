# English cron templates

Full set of English prompts. Defaults use `~/.hermes/daily/<job>/` (see `scripts/install-demo.sh`).

| Job | File | Schedule idea |
|-----|------|----------------|
| AI News | [ai-news.md](ai-news.md) | Daily morning |
| GitHub digest | [github-digest.md](github-digest.md) | Daily 08:00 |
| Tech learning | [learning.md](learning.md) | Daily 05:00 |
| Interview | [interview.md](interview.md) | Daily 07:00 |
| English study | [english.md](english.md) | Daily 07:30 |
| Daily thinking | [thinking.md](thinking.md) | Daily 08:00 |
| Tweet drafts | [tweet-draft.md](tweet-draft.md) | Daily 09:00 |
| Code reading | [code-reading.md](code-reading.md) | Daily 20:00 |
| Topic study | [topic-study.md](topic-study.md) | Daily 21:00 |
| Finance | [finance.md](finance.md) | Daily 21:00 |
| Daily review | [daily-review.md](daily-review.md) | Nightly 03:00 |

Chinese originals live in the parent [`cron-jobs/`](../) directory.

```bash
# Example: register English AI News
hermes cron create "0 8 * * *" --name "AI News" \
  --prompt "$(cat cron-jobs/en/ai-news.md)"
```

Mechanism: [Progressive Cron](../../docs/progressive-cron.md).
