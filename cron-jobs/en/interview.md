# Daily Interview Question

**History:** `~/.hermes/daily/interview/history/`

```bash
hermes cron create "0 7 * * *" --name "Interview" --prompt "$(cat cron-jobs/en/interview.md)"
```

## Prompt

One interview question per day. **No repeats** (check last 5 history files).

**Language:** English  
Rotate domain by day mod 7: language · concurrency · OS · networking · DB · algorithms · system design / specialty.

Include: difficulty stars, model answer, follow-ups, scoring points.  
Save `history/day_NN_<domain>.md`.
