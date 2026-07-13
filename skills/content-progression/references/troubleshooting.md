# Progressive Cron — troubleshooting

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| Same topic every day | Agent never reads history | Force `ls` + `read` last 3 files in prompt; fail closed if history missing |
| Always Day 1 | Wrong/missing start date | Set `Day 1 = YYYY-MM-DD` in plan; recompute with `date` |
| Skipped days | Cron missed fire | Touch placeholder `day_NN_skip.md` or recompute N from calendar (not file count) |
| History huge | Reading all files | Cap at last 3–5 files |
| Zombie finite job | No self-pause | Add step 6 pause contract |
| Path errors | Personal absolute paths | Use `~/.hermes/daily/<job>/` defaults from this pack |
| Telegram split messages | Output too long | Hard cap (~300–800 Chinese chars / ~1500 English chars depending on job) |
| "I saved history" but no file | Model hallucinated write | Require tool write; verify with `ls` in same turn when possible |

## Reset

```bash
# Restart a course, keep the syllabus
rm -rf ~/.hermes/daily/<job>/history/*
# optional: reset Day 1
```

## Debug once

```bash
hermes cron run <job_id>
hermes logs --follow
ls -la ~/.hermes/daily/<job>/history/
```
