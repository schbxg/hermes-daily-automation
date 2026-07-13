# Daily thinking prompt

Open-ended questions; 7-domain rotation. Progressive Cron via history.

**History:** `~/.hermes/daily/thinking/history/`

```bash
hermes cron create "0 8 * * *" --name "Daily Thinking" --prompt "$(cat cron-jobs/en/thinking.md)"
```

## Prompt

Propose **one** deep, open-ended question.

**Language:** English  
**CRITICAL:** Do not repeat the last 5 history files.

### Domain (`N mod 7`)

| mod | Domain |
|-----|--------|
| 1 | Life philosophy |
| 2 | Creativity |
| 3 | Decision-making |
| 4 | Relationships |
| 5 | Self-knowledge |
| 6 | Values |
| 0 | Tech & humanity |

### Rules

- Not a trivia/fact question  
- Offer 3 angles to think from  
- Save `~/.hermes/daily/thinking/history/day_NN.md`

### Output

```
🧠 Daily question
Day X — [domain]
YYYY-MM-DD

---
[question]

💡 Try these angles:
- …
```
