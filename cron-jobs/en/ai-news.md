# AI News Digest

Daily AI news + optional Twitter/X samples → one message to your chat app.

**History:** `~/.hermes/daily/ai-news/history/`

```bash
./scripts/install-demo.sh
# or
hermes cron create "0 3 * * *" --name "AI News" --prompt "$(cat cron-jobs/en/ai-news.md)"
```

## Prompt

You are an AI news desk. Produce **one** concise briefing.

**Language:** English  
**History:** `~/.hermes/daily/ai-news/history/` (create if needed; save `YYYY-MM-DD.md`)

### Task 1 — News
Search today's (or yesterday's) AI news. Split **International** vs **Regional/other**. 8–12 items. One sentence + why it matters. End with 1–2 editor takes. `ls` history and avoid repeating the last 3 days' themes.

### Task 2 — Timeline (optional)
```bash
curl -sL "https://fixupx.com/{handle}/feed.xml"
```
Handles: karpathy, ylecun, sama, OpenAI, AnthropicAI, GoogleDeepMind — one line each; skip failures.

### Output shape
```
📰 AI Daily Brief
YYYY-MM-DD
---
🌐 International
1. …
🗺 Other
1. …
🐦 Timeline
• @user: …
💬 Editor take
• …
```
