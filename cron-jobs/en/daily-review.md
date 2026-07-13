# Nightly Self-Review ("Dreaming")

**History:** `~/.hermes/daily/daily-review/history/`  
**Memory:** `~/.hermes/daily/MEMORY.md`

```bash
hermes cron create "0 3 * * *" --name "Daily Review" --prompt "$(cat cron-jobs/en/daily-review.md)"
```

## Prompt

Nightly retro for the **human's** sessions only (ignore other cron noise). ≤ 300 words.

1. Search last ~24h user sessions  
2. Done / worked / failed / risk  
3. Append lessons to MEMORY.md; suggest a Skill if a workflow repeated  
4. Save history `YYYY-MM-DD.md`

Output: ✅ Done · 💡 Lessons · ⚠️ Risks
