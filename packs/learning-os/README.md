# Pack: Learning OS

Curriculum-style jobs using **[Progressive Cron](../../docs/progressive-cron.md)**.

| Time | Job | Template | Notes |
|------|-----|----------|--------|
| 05:00 | Tech learning | `learning` | needs `plan.md` |
| 07:00 | Interview | `interview` | domain rotation |
| 20:00 | Code reading | `code-reading` | finite → self-pause |
| 21:00 | Topic study | `topic-study` | **optional** |
| 03:00 | Daily review | `daily-review` | human sessions → MEMORY |

## One-command install

```bash
./scripts/install-pack.sh learning-os

# English + topic study
./scripts/install-pack.sh learning-os --en --with-optional

./scripts/install-pack.sh learning-os --dry-run
```

Then edit plans:

```bash
$EDITOR ~/.hermes/daily/learning/plan.md
$EDITOR ~/.hermes/daily/code-reading/plan.md
# optional:
$EDITOR ~/.hermes/daily/topic-study/plan.md
```

## Manifest

Jobs and schedules: [`manifest.tsv`](manifest.tsv).
