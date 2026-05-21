<div align="center">

# 🤖 Hermes Daily Automation

**用 MIMO 大模型驱动 Hermes Agent，构建每日自动运转的数字员工体系**

[![License: MIT](https://img.shields.io/badge/License-MMIT-yellow.svg)](LICENSE)
[![Hermes Agent](https://img.shields.io/badge/Hermes%20Agent-Compatible-blueviolet)](https://github.com/NousResearch/hermes-agent)
[![MIMO](https://img.shields.io/badge/Xiaomi%20MIMO-Supported-orange)](https://github.com/XiaoMi)

*「AI 不应该只是你问它答的工具，它应该是一个能独立运转的数字员工」*

[看效果](#效果展示) · [快速开始](#快速开始) · [模板列表](#模板列表) · [工作原理](#工作原理)

</div>

---

## 这是什么

这是一个基于 [Hermes Agent](https://github.com/NousResearch/hermes-agent) 的**自动化模板集合**，帮助你快速搭建每日自动推送系统。

我自己用这套体系跑了 10+ 个定时任务，每天自动推送：
- 📰 AI 新闻聚合（抓取 HN + IT之家 + Twitter）
- 📚 技术学习（40天课程，Day by Day 推进）
- 🎧 英语听力（自动生成 TTS 音频）
- 🎯 面试题（C++ / CUDA / 系统设计）
- 💰 理财知识（30天入门计划）
- 🤔 每日思考题（7个领域轮换）

全部无人值守，每天凌晨自动执行，结果推送到 Telegram。

---

## 效果展示

<div align="center">

### AI 新闻聚合
<img src="screenshots/ai-news.jpg" width="400" alt="AI News">

### 技术学习推送
<img src="screenshots/learning.jpg" width="400" alt="Learning">

### 面试题推送
<img src="screenshots/interview.jpg" width="400" alt="Interview">

</div>

---

## 快速开始

### 前置条件

1. 安装 [Hermes Agent](https://github.com/NousResearch/hermes-agent)
2. 配置一个 LLM provider（MIMO / DeepSeek / OpenAI / Claude 都可以）
3. 配置 Telegram 或其他消息平台

### 安装步骤

```bash
# 1. 克隆仓库
git clone https://github.com/YOUR_USERNAME/hermes-daily-automation.git
cd hermes-daily-automation

# 2. 复制配置模板
cp config-template.yaml ~/.hermes/config.yaml

# 3. 创建定时任务（以 AI 新闻为例）
hermes cron create "0 3 * * *" --name "AI新闻" --prompt "$(cat cron-jobs/ai-news.md)"

# 4. 查看任务列表
hermes cron list
```

### 自定义你的第一个任务

```bash
# 编辑 prompt 模板
vim cron-jobs/ai-news.md

# 创建定时任务
hermes cron create "0 8 * * *" --name "我的日报" --prompt "$(cat cron-jobs/ai-news.md)"

# 测试运行
hermes cron run <job_id>
```

---

## 模板列表

### 📰 信息聚合类

| 模板 | 说明 | 推荐频率 |
|------|------|----------|
| [AI新闻](cron-jobs/ai-news.md) | 抓取 HN + IT之家 + Twitter，生成中文摘要 | 每天 3:00 |
| [推文日报](cron-jobs/tweet-daily.md) | 抓取指定 Twitter 账号最新推文 | 每天 3:00 |

### 📚 学习类

| 模板 | 说明 | 推荐频率 |
|------|------|----------|
| [技术学习](cron-jobs/learning.md) | 按计划推进技术课程 | 每天 5:00 |
| [英语学习](cron-jobs/english.md) | 英语词汇 + 听力 + TTS 音频 | 每天 7:30 |
| [面试题](cron-jobs/interview.md) | 每日一道面试题 + 答案 | 每天 7:00 |

### 💡 生活类

| 模板 | 说明 | 推荐频率 |
|------|------|----------|
| [每日思考](cron-jobs/thinking.md) | 哲学/创造力/决策等领域轮换 | 每天 8:00 |
| [理财知识](cron-jobs/finance.md) | 30天理财入门计划 | 每天 21:00 |

### 🔧 核心机制

| 文件 | 说明 |
|------|------|
| [AGENTS模板](AGENTS-template.md) | 项目级 AI onboarding 文件模板 |
| [内容递进](skills/content-progression.md) | 防止 Cron 内容重复的 Skill |

---

## 工作原理

### 核心架构

```
┌─────────────────────────────────────────────┐
│           Hermes Agent (框架层)              │
│  ┌─────────┐ ┌─────────┐ ┌─────────────┐  │
│  │  Cron   │ │ Memory  │ │   Skills    │  │
│  │ 调度器  │ │ 记忆系统 │ │ 经验沉淀    │  │
│  └────┬────┘ └────┬────┘ └──────┬──────┘  │
│       │           │             │          │
│  ┌────▼───────────▼─────────────▼──────┐  │
│  │         Orchestration Loop          │  │
│  │    (编排循环: Prompt → LLM → Tool)  │  │
│  └────┬────────────────────────────────┘  │
│       │                                    │
└───────┼────────────────────────────────────┘
        │
        ▼
┌───────────────┐
│   LLM 模型    │  ← MIMO / DeepSeek / Claude / GPT
└───────┬───────┘
        │
        ▼
┌───────────────┐
│  消息平台     │  ← Telegram / Discord / Slack
└───────────────┘
```

### 内容递进机制（防重复）

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ 学习计划文件  │────▶│  Cron Job    │────▶│ 历史记录目录  │
│ (静态框架)    │     │ (每日触发)   │     │ (动态积累)    │
└──────────────┘     └──────┬───────┘     └──────────────┘
                            │
                     1. 读计划 → 今天第几天？
                     2. 读历史 → 之前讲过什么？
                     3. 生成内容 → 不重复
                     4. 保存到历史目录
```

关键：用**文件系统做 Agent 的外部记忆**，跨 session 也能保持连续性。

---

## 最佳实践

### 1. 时间分散，不要堆在一起

```yaml
# ❌ 不好：7 个任务全在 3:00
3:00 - 任务1, 任务2, 任务3, 任务4, 任务5, 任务6, 任务7

# ✅ 好：分散到不同时间
3:00 - AI新闻
5:00 - 技术学习
7:00 - 面试题
7:30 - 英语学习
8:00 - 每日思考
21:00 - 理财 + 推特提醒
```

### 2. Prompt 要包含"读历史 → 避免重复 → 保存"

```markdown
## 步骤1：确定今天是第几天
运行 date +%Y-%m-%d，计算从 Day 1 开始的天数。

## 步骤2：读取历史记录
ls /path/to/history/  # 读最近 3 天

## 步骤3：生成内容
确保与历史不同。

## 步骤4：保存到历史
保存到 /path/to/history/day_XX.md
```

### 3. AGENTS.md 是给 AI 的 onboarding

```markdown
# 项目简介
# 目录结构
# 代码规范
# 已知坑点
# 工作流程
```

---

## 常见问题

### Q: 会不会每天推送同样的内容？

不会。每个模板都包含：
1. 学习计划文件（静态框架）
2. 历史记录目录（动态积累）
3. "第几天"计算（时间锚点）

三者结合保证内容递进不重复。

### Q: 用什么模型最好？

| 模型 | 适合场景 | 价格 |
|------|----------|------|
| Xiaomi MIMO | 日常事务、中文内容 | 便宜 |
| DeepSeek | 技术学习、代码分析 | 极便宜 |
| Claude Sonnet | 复杂推理、长文档 | 中等 |
| GPT-4o | 通用任务 | 中等 |

建议：日常用 MIMO/DeepSeek，复杂任务用 Claude/GPT。

### Q: 可以用 Discord/Slack 代替 Telegram 吗？

可以。Hermes 支持 10+ 消息平台，配置方式相同。

### Q: 如何调试 Cron Job？

```bash
# 手动触发一次
hermes cron run <job_id>

# 查看运行日志
hermes logs --follow

# 暂停任务
hermes cron pause <job_id>
```

---

## 贡献

欢迎提交 PR 添加新的 Cron Job 模板！

模板格式：
```markdown
# 任务名称

[描述任务目的]

## 步骤
1. ...
2. ...

## 输出格式
[定义输出模板]
```

---

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=YOUR_USERNAME/hermes-daily-automation&type=Date)](https://star-history.com/#YOUR_USERNAME/hermes-daily-automation&Date)

---

## 致谢

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — AI Agent 框架
- [Nous Research](https://nousresearch.com) — 框架开发团队
- [Xiaomi MIMO](https://github.com/XiaoMi) — 大模型支持

---

<div align="center">

**如果觉得有用，请点个 ⭐ Star！**

</div>
