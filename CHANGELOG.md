# Changelog

## 0.2.0 — 2026-07-13

### Added

- **Progressive Cron** branded skill pack (`skills/content-progression/`) with agentskills.io frontmatter, references, and assets
- Skills: `daily-self-review`, `github-morning-digest`
- `scripts/install-demo.sh` — scaffold `~/.hermes/daily` + optional AI News cron
- `scripts/install-skills.sh` — install skills into `~/.hermes/skills/productivity/`
- Default data seeds under `data/`
- Example outputs under `examples/`
- English cron twins under `cron-jobs/en/`
- GitHub morning digest job (`cron-jobs/github-digest.md`)
- Full prompt-templates set (code-review, interview-prep, content-creation, debug-helper)
- CONTRIBUTING + GitHub issue/PR templates
- `.gitattributes` so language stats are not 100% HTML

### Changed

- README (EN/zh) rewritten: 5-minute demo, cost notes, Progressive Cron first-class
- All cron jobs use `~/.hermes/daily/<job>/` defaults (no personal absolute paths)
- Removed empty Star History chart from README

### Fixed

- Dead links in `prompt-templates/README.md`
- Personal machine paths in tech-learning / tweet-draft examples

## 0.1.0 — 2026-05-21

- Initial public templates: AI news, learning, English, interview, thinking, finance
- AGENTS template, content-progression notes, bilingual README (later)
