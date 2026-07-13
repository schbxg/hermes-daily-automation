# Default data layout

`scripts/install-demo.sh` creates this tree under **`~/.hermes/daily/`** (override with `HERMES_DAILY_HOME`).

```text
~/.hermes/daily/
├── ai-news/history/
├── learning/
│   ├── plan.md
│   └── history/
├── interview/history/
├── thinking/history/
├── finance/
│   ├── plan.md
│   └── history/
├── english/history/
├── github-digest/history/
├── tweet-draft/history/
├── code-reading/
│   ├── plan.md
│   └── history/
├── topic-study/
│   ├── plan.md
│   └── history/
└── daily-review/history/
```

All cron templates in this repo default to these paths so you can run without editing placeholders.
