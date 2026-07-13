# Prompt templates

Copy-paste building blocks for any LLM. For full Hermes cron jobs (schedule + delivery), see [`cron-jobs/`](../cron-jobs/).

## Templates

| Template | Use case | Models |
|----------|----------|--------|
| [Tech learning](tech-learning.md) | Day-by-day course with history | Any |
| [Code review](code-review.md) | Structured PR review | Claude / GPT preferred |
| [Interview prep](interview-prep.md) | One question + answer + follow-ups | Any |
| [Content creation](content-creation.md) | Tweet / short-post drafts | Any |
| [Debug helper](debug-helper.md) | Systematic incident debugging | Claude / GPT preferred |

## How to use

1. Copy the fenced template
2. Replace `[placeholders]`
3. Send to your model (or paste into a Hermes cron prompt)
4. Tighten constraints after the first run

## Default data root

When used with this repo's install script, history lives under:

```text
~/.hermes/daily/<job>/history/
```
