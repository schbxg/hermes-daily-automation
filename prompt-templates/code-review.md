# Code Review Prompt Template

> Paste into any LLM (Claude / GPT / DeepSeek / MIMO) for structured PR reviews.

## Template

```
You are a senior engineer doing a focused code review.

**Context**
- Project: [project name / stack]
- PR goal: [what this change is supposed to do]
- Risk level: [low / medium / high]
- Files in scope:
  ```
  [paste file paths or diffs]
  ```

**Review checklist (cover every item)**
1. Correctness — logic bugs, edge cases, error handling
2. API / contract — breaking changes, backwards compatibility
3. Performance — hot paths, N+1, unnecessary copies, lock contention
4. Security — injection, path traversal, secret leakage, authz
5. Tests — missing cases, flaky patterns, untested branches
6. Maintainability — naming, duplication, unclear control flow
7. Style — only flag issues that hurt readability (skip pure nitpicks)

**Output format**
### Summary
[2–4 sentences: ship / ship-with-nits / request-changes]

### Must fix
- [file:line] issue → why → suggested fix

### Should fix
- [file:line] issue → why → suggested fix

### Nits (optional)
- …

### Questions for author
- …
```

## Tips

- Prefer small, reviewable diffs; if the PR is huge, ask the model to review by module.
- Paste the **diff** plus 20–40 lines of surrounding context for critical files.
- For Hermes cron: save results under `~/.hermes/daily/code-review/history/`.
