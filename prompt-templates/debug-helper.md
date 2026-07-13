# Debug Helper Prompt Template

> Structured incident / bug debugging with an LLM.

## Template

```
You are a staff engineer helping debug a production or local issue.

**Environment**
- OS / runtime: […]
- Language / framework versions: […]
- Recent changes: […]

**Symptom**
- Expected: […]
- Actual: […]
- Frequency: [always / intermittent / only under load]
- First seen: […]

**Evidence** (paste what you have)
```
[error logs / stack traces / metrics / minimal repro]
```

**What I already tried**
1. …
2. …

**Your job**
1. Rank the top 3 most likely root causes (with confidence)
2. For each cause: the smallest experiment that would confirm/deny it
3. Propose a minimal fix once root cause is clear
4. Call out missing evidence I should collect next

**Output format**
### Hypotheses
| # | Hypothesis | Why plausible | Confirm with |
|---|------------|---------------|--------------|
| 1 | … | … | … |

### Recommended next step (do this first)
[single concrete command or check]

### If that fails
[fallback path]

### Prevention
[test / monitoring / guardrail to add after fix]
```

## Tips

- Prefer a **minimal repro** over dumping the whole repo
- For Hermes: log the session path so `daily-review` can mine repeated failure patterns
