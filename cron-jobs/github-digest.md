# GitHub 日报

开发者刚需：PR / Issue / CI 摘要，早上打开就能处理。

**History:** `~/.hermes/daily/github-digest/history/`

## 使用方式

```bash
# 需要本机已登录 gh（GitHub CLI）
gh auth status

hermes cron create "0 8 * * *" --name "GitHub日报" --prompt "$(cat cron-jobs/github-digest.md)"
```

## Prompt 模板

你是工程经理式的 GitHub 助理。生成**一份**可执行的早间摘要。

**Language:** 中文（仓库名 / PR 标题保持原样）  
**范围默认：** 当前用户有关的通知与仓库；可用环境变量收窄。

## 步骤1：采集（用 shell，失败则说明缺权限）

优先使用 `gh`：

```bash
# 通知（若可用）
gh api notifications --jq '.[].subject | "\(.type) \(.title)"' 2>/dev/null | head -30

# 查看用户最近涉及的 PR（按需改 author 或 search）
gh search prs --author=@me --state=open --limit 20

# 可选：指定仓库列表
# gh pr list -R owner/repo
# gh run list -R owner/repo --limit 10
```

若用户在 `~/.hermes/daily/github-digest/repos.txt` 写了仓库列表（每行 `owner/repo`），则对每个仓库拉取：
- open PRs needing review  
- failed CI on default branch（最近）  
- issues assigned to @me  

## 步骤2：去噪与排序

优先级：
1. **Needs you**（review requested / assigned / failing CI you own）  
2. **Inbox**（comments、mention）  
3. **Your open PRs**  
4. **FYI**（其它）

## 步骤3：历史

读 `~/.hermes/daily/github-digest/history/` 最近 2 天，标注「连续 N 天未动」的项。

## 步骤4：保存

`~/.hermes/daily/github-digest/history/YYYY-MM-DD.md`

## 输出格式（短、可执行）

```
🐙 GitHub Digest · YYYY-MM-DD

📌 Needs you
1. …

📬 Inbox
- …

🔀 Your open PRs
| PR | Status | Note |
|----|--------|------|

💡 建议 30 分钟焦点
1. …
```

## 自定义

- 只盯几个仓库：写 `repos.txt`  
- 英文输出：Language → English  
- 安全：不要把 token 写进 history；`gh` 用本机登录态即可
