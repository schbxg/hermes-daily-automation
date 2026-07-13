# GitHub Morning Digest

**History:** `~/.hermes/daily/github-digest/history/`  
Requires `gh` CLI authenticated.

```bash
hermes cron create "0 8 * * *" --name "GitHub Digest" --prompt "$(cat cron-jobs/en/github-digest.md)"
```

## Prompt

Act as an EM writing a **short, actionable** morning digest.

**Language:** English

Collect via `gh` (notifications, `gh search prs --author=@me --state=open`, optional `~/.hermes/daily/github-digest/repos.txt`).

Prioritize: Needs you → Inbox → Your open PRs → FYI.  
Flag items stale vs last 2 history files.  
Save `history/YYYY-MM-DD.md`.

Output sections: 📌 Needs you · 📬 Inbox · 🔀 PRs · 💡 30-min focus.
