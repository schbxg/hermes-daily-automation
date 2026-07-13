# 代码阅读计划（N 天读懂一个大文件）

有终点；结束后 **self-pause**。

**Plan:** `~/.hermes/daily/code-reading/plan.md`  
**History:** `~/.hermes/daily/code-reading/history/`

## 使用方式

1. 编辑 plan，填入目标文件与每日行号范围  
2. 设置 Day 1 日期  

```bash
hermes cron create "0 20 * * *" --name "代码阅读" --prompt "$(cat cron-jobs/code-reading.md)"
```

## Prompt 模板

你是代码阅读教练。

**Language:** 中文

## 步骤1：第几天

读 `~/.hermes/daily/code-reading/plan.md`。用 `date` 算 N。  
超出范围 → 总结 + `cronjob(action='pause', job_id=<当前>)`。

## 步骤2：今日任务

从 plan 取 Day N：

- 目标（一个核心问题）  
- 范围（文件 + 行号）  
- 3–5 阅读重点  
- 可勾选任务清单  
- 1 道思考题

## 步骤3：保存

`~/.hermes/daily/code-reading/history/day_NN.md`

## 输出格式

```
📖 代码阅读 Day X / N
📅 日期 | 今日目标

📍 范围：file:lines
🔍 阅读重点
✅ 今日任务
❓ 思考题
```

## Plan 示例

写入 `~/.hermes/daily/code-reading/plan.md`：

```markdown
# Code reading
> Day 1 = YYYY-MM-DD
> Target: /path/to/big_file.cpp (~lines)

| Day | Goal | Range |
|-----|------|-------|
| 1 | 结构全景 | header / 1-120 |
| 2 | 主流程 | main loop |
| 3 | 分支逻辑 | … |
| 4 | 错误处理 | … |
| 5 | 总结 | 全文串联 |
```
