# Contributing

Thanks for improving **Hermes Daily Automation** — a pack of Progressive Cron jobs and skills for [Hermes Agent](https://github.com/NousResearch/hermes-agent).

## Ways to contribute

1. **New cron template** (`cron-jobs/` + optional `cron-jobs/en/`)
2. **Sample output** under `examples/` (redact secrets)
3. **Plan seeds** under `data/`
4. **Docs / translation**
5. **Bug reports** via GitHub Issues

## Cron template checklist

- [ ] Default paths under `~/.hermes/daily/<job>/` (no personal absolute paths)
- [ ] Progressive Cron steps when content must not repeat (plan + history + day index)
- [ ] Finite plans call `cronjob(action='pause', job_id=<self>)` when finished
- [ ] Output fits messaging apps (~Telegram-friendly length)
- [ ] `Language:` line documented
- [ ] Linked from README tables (EN + zh-CN)
- [ ] Optional: English twin in `cron-jobs/en/`
- [ ] Optional: `examples/<name>-sample.md`

### Suggested skeleton

```markdown
# Job title

One-line purpose.

**History:** `~/.hermes/daily/<job>/history/`

## Usage
\`\`\`bash
hermes cron create "0 8 * * *" --name "…" --prompt "\$(cat cron-jobs/….md)"
\`\`\`

## Prompt
…
```

## Commit style

Prefer conventional prefixes: `feat:`, `fix:`, `docs:`, `chore:`.

## Code of conduct

Be respectful. No scraping private data into examples. No secrets in commits.
