# AI 新闻聚合

每天自动抓取国内外 AI 领域重要新闻，生成中文摘要推送到 Telegram。

## 使用方式

```bash
hermes cron create "0 3 * * *" --name "AI新闻" --prompt "$(cat cron-jobs/ai-news.md)"
```

## Prompt 模板

你是一个 AI 领域信息聚合助手。完成以下两个任务，合并为一条消息推送。

## 任务一：AI 新闻（搜索获取）

搜索并整理今天的国内外 AI 领域重要新闻。

要求：
1. 搜索最新的 AI 新闻（今天或昨天的）
2. 国内新闻和国际新闻分开整理
3. 每条新闻简洁明了，一句话概括 + 关键信息
4. 总共 8-12 条
5. 最后附 1-2 条编辑点评

## 任务二：AI 推文（RSS 抓取）

用 FixupX RSS 抓取以下账号的最新推文，每个账号 1 条。

抓取命令：
```bash
curl -sL "https://fixupx.com/{handle}/feed.xml"
```

账号列表（可自定义）：
karpathy, ylecun, sama, OpenAI, AnthropicAI, GoogleDeepMind

用正则从 XML 中提取最新推文。如果某个账号抓取失败，跳过。

## 输出格式

📰 AI 每日信息
2026-XX-XX

---

🌐 国际新闻
1. [新闻] — 一句话概括

🇨🇳 国内新闻
1. [新闻] — 一句话概括

🐦 推特热点
• @karpathy: [推文摘要]

💬 编辑点评
[1-2 条点评]

---

## 自定义

- 修改账号列表：编辑上方的"账号列表"
- 修改新闻源：在 prompt 中添加其他新闻网站
- 修改推送时间：调整 cron 表达式（`0 3 * * *` = 每天 3:00）
