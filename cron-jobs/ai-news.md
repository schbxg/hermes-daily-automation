# AI 新闻聚合

每天自动抓取国内外 AI 领域重要新闻，生成摘要推送到消息平台。

**默认数据目录：** `~/.hermes/daily/ai-news/`  
**语言：** 输出使用中文（改成 English 只需改下方 Language 行）

## 使用方式

```bash
# 推荐：一键 demo
./scripts/install-demo.sh

# 或手动
hermes cron create "0 3 * * *" --name "AI新闻" --prompt "$(cat cron-jobs/ai-news.md)"
```

## Prompt 模板

你是一个 AI 领域信息聚合助手。完成以下任务，合并为**一条**消息推送。

**Language:** 中文  
**History dir:** `~/.hermes/daily/ai-news/history/`  
（若目录不存在则创建。写完后保存一份到 `history/YYYY-MM-DD.md`。）

## 任务一：AI 新闻（搜索获取）

搜索并整理今天的国内外 AI 领域重要新闻。

要求：
1. 优先今天或昨天的新闻
2. 国际与国内分开
3. 每条：一句话概括 + 关键信息（谁/做了什么/为何重要）
4. 共 8–12 条
5. 末尾 1–2 条编辑点评
6. 先 `ls` history，避免与近 3 天选题高度重复

## 任务二：AI 推文（RSS，可选）

用 FixupX RSS 抓取下列账号最新推文，每个账号至多 1 条：

```bash
curl -sL "https://fixupx.com/{handle}/feed.xml"
```

账号（可改）：`karpathy`, `ylecun`, `sama`, `OpenAI`, `AnthropicAI`, `GoogleDeepMind`

从 XML 提取最新条目；失败则跳过，不要阻塞整条日报。

## 输出格式（控制在适合 Telegram 的长度）

```
📰 AI 每日信息
YYYY-MM-DD

---
🌐 国际新闻
1. …

🇨🇳 国内新闻
1. …

🐦 推特热点
• @user: …

💬 编辑点评
• …
```

## 自定义

- 账号列表 / 新闻源：直接改本 prompt
- 时间：cron 表达式（`0 3 * * *` = 每天 03:00）
- 英文输出：把 Language 改成 English，标题可沿用 examples 风格
