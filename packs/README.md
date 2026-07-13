# Packs

Curated **bundles of cron jobs**. Each pack has a `manifest.tsv` and installs via one script.

| Pack | Audience | Install |
|------|----------|---------|
| **Morning Brief** | Engineers — news + GitHub first | `./scripts/install-pack.sh morning-brief` |
| **Learning OS** | Study + interview + night review | `./scripts/install-pack.sh learning-os` |

## Quick start

```bash
# list packs + jobs
./scripts/install-pack.sh list

# install (seeds ~/.hermes/daily, registers crons)
./scripts/install-pack.sh morning-brief

# English prompts, include optional jobs, dry-run
./scripts/install-pack.sh learning-os --en --with-optional --dry-run
```

## Manifest format

`packs/<id>/manifest.tsv` — one job per line:

```text
schedule|display name|template_stem|flags
```

| Column | Example |
|--------|---------|
| schedule | `0 8 * * 1-5` |
| name | `GitHub Digest (Morning Brief)` |
| template_stem | `github-digest` → `cron-jobs/github-digest.md` or `cron-jobs/en/...` |
| flags | `optional`, `gh`, `plan:learning` (comma-separated) |

See [`scripts/install-pack.sh`](../scripts/install-pack.sh).
