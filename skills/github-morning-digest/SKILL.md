---
name: github-morning-digest
description: >
  Build a short, actionable morning GitHub digest using the gh CLI — review
  requests, failing CI, open PRs, and assigned issues. Use when the user wants
  a GitHub daily brief, PR triage, notification summary, or "what needs me on
  GitHub today".
version: 1.0.0
author: schbxg
license: MIT
compatibility: Requires GitHub CLI (gh) authenticated; network access to GitHub.
metadata:
  hermes:
    tags: [github, gh, pr, ci, digest, morning, triage]
    category: productivity
    related_skills: [content-progression]
  openstandard: agentskills.io
---

# GitHub Morning Digest

## When to use

- Morning cron for engineers
- User asks "what PRs need me", "CI red?", "GitHub inbox"

## Prerequisites

```bash
command -v gh && gh auth status
```

Optional repo allowlist (one `owner/repo` per line):

```text
~/.hermes/daily/github-digest/repos.txt
```

## Workflow

1. Collect with `gh` (notifications, `gh search prs --author=@me --state=open`, per-repo `gh pr list` / `gh run list` if allowlisted).
2. Rank: **Needs you** → **Inbox** → **Your open PRs** → **FYI**.
3. Compare last 2 files in `~/.hermes/daily/github-digest/history/` for "stale N days".
4. Save `history/YYYY-MM-DD.md`.
5. Deliver short message (tables OK if compact).

## Output skeleton

```text
🐙 GitHub Digest · YYYY-MM-DD

📌 Needs you
1. …

📬 Inbox
- …

🔀 Your open PRs
| PR | Status | Note |

💡 30-min focus
1. …
```

## Safety

- Do not write tokens into history files
- Prefer `gh` login state over embedding PATs in prompts

## Cron prompt source

`cron-jobs/github-digest.md` · EN: `cron-jobs/en/github-digest.md`
