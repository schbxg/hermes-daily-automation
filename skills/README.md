# Skills (agentskills.io + Hermes)

Each subdirectory is a portable **Agent Skill**: `SKILL.md` with YAML frontmatter (`name` + `description` required). Compatible with [agentskills.io](https://agentskills.io) and [Hermes Agent](https://github.com/NousResearch/hermes-agent) skill loading.

| Skill | Folder | Purpose |
|-------|--------|---------|
| `content-progression` | [content-progression/](content-progression/) | Progressive Cron — anti-repeat curricula |
| `daily-self-review` | [daily-self-review/](daily-self-review/) | Nightly human-session retro → MEMORY |
| `github-morning-digest` | [github-morning-digest/](github-morning-digest/) | `gh`-powered morning triage |

## Install into Hermes

```bash
# from repo root
./scripts/install-skills.sh

# custom category (default: productivity)
HERMES_SKILLS_CATEGORY=productivity ./scripts/install-skills.sh
```

This copies (or symlinks with `HERMES_SKILLS_LINK=1`) skills to:

```text
~/.hermes/skills/<category>/<skill-name>/
```

Then:

```bash
hermes skills list
# or open a session and invoke by name / natural language
```

## Validate frontmatter (optional)

If you have [skills-ref](https://github.com/agentskills/agentskills):

```bash
skills-ref validate ./skills/content-progression
```

## Legacy path

`skills/content-progression.md` is a redirect stub for old links.
