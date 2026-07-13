# Progressive Cron（内容递进）

> **一句话：** 定时 Agent 会忘掉昨天，文件不会。  
> 用 **静态计划 + 追加历史 + 第几天** 三件套，让 LLM 定时任务按天前进，不需要数据库。

**仓库：** [schbxg/hermes-daily-automation](https://github.com/schbxg/hermes-daily-automation)  
**Skill：** [`skills/content-progression/`](../skills/content-progression/SKILL.md)

---

## 问题

每天跑一次「教我系统设计」的 cron，模型很容易**永远讲 Day 1**——因为每次都是新 session。

## 模式

```text
plan.md（大纲） → cron 触发 → history/（只追加）
         │
  1. date 算第 N 天
  2. 读计划第 N 行
  3. 读最近 3 份 history
  4. 生成不重复内容
  5. 写入 day_NN.md
  6. 超出计划 → pause(自己)
```

| 锚点 | 作用 |
|------|------|
| **Plan** | 今天该讲什么 |
| **History** | 以前讲过什么 |
| **Day index** | 今天是第几天 |

## 可复制协议

```markdown
## Progressive Cron 协议
1. date 算 N（Day 1 = 计划里的开始日）
2. 读 ~/.hermes/daily/<job>/plan.md
3. ls + 读 history 最近 3 个文件
4. 生成不重复内容
5. 写入 history/day_NN_<slug>.md
6. 若 N 超计划：总结并 pause 本 cron
```

## 有终点 vs 无终点

- **有终点**（30 天理财、N 天读代码）：跑完 **self-pause**  
- **无终点**（新闻、思考题轮换）：不 pause，但仍写 history 防重复  

## 最小计划文件

```markdown
# 学习计划
> Day 1 = 2026-07-01

| Day | 主题 | 关键词 |
|-----|------|--------|
| 1 | 负载均衡 | L4, L7 |
| 2 | 缓存 | TTL |
```

## 为什么有效

状态可 `ls` / `diff`；与模型无关；个人自动化零额外中间件。

排错见：[troubleshooting.md](../skills/content-progression/references/troubleshooting.md)  
英文完整版：[progressive-cron.md](progressive-cron.md)

```bash
./scripts/install-demo.sh && ./scripts/install-skills.sh
```
