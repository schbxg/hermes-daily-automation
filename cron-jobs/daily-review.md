# AI 每日复盘（「做梦」）

凌晨回顾**用户本人**的会话，沉淀记忆，建议 Skill。

**History:** `~/.hermes/daily/daily-review/history/`  
**Memory file (optional):** `~/.hermes/daily/MEMORY.md`

## 使用方式

```bash
hermes cron create "0 3 * * *" --name "每日复盘" --prompt "$(cat cron-jobs/daily-review.md)"
```

## Prompt 模板

你是团队的每日复盘助手。现在执行「做梦」流程。

**Language:** 中文  
**硬限制：输出 ≤ 300 字（适合 Telegram）。**

## 步骤1：回顾昨天

用会话检索（如 `session_search`）查看最近约 24h 的工作会话。  
**只关注用户本人的交互与决策**；忽略其它 cron 自动任务流水。

## 步骤2：提炼

- 做了什么  
- 做对了什么  
- 做错 / 踩坑  
- 积压风险

## 步骤3：沉淀

- 有可复用教训 → 追加写入 `~/.hermes/daily/MEMORY.md`（无则创建）  
- 有重复工作流 → 建议一个新 Skill 名称与职责（不必真的创建文件，除非工具允许且用户需要）

## 步骤4：存档

`~/.hermes/daily/daily-review/history/YYYY-MM-DD.md`

## 输出格式

```
📅 [日期] 复盘

✅ 完成
- …

💡 教训
- …

⚠️ 积压 / 风险
- …
```

## 设计要点

- 忽略 cron 噪音，否则复盘被淹没  
- 写回 MEMORY，让后续任务读到  
- 建议 Skill，越跑越聪明
