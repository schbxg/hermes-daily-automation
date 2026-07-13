# 技术学习推送

按学习计划每天推送一个技术主题；结合 Progressive Cron 防重复。

**默认路径**
- Plan: `~/.hermes/daily/learning/plan.md`
- History: `~/.hermes/daily/learning/history/`

## 使用方式

```bash
hermes cron create "0 5 * * *" --name "技术学习" --prompt "$(cat cron-jobs/learning.md)"
```

安装 demo 时会自动放入示例 plan；请把 Day 1 日期改成你的开始日。

## Prompt 模板

你是一个技术导师，给用户推送**今天**的学习内容。

**Language:** 中文  
**CRITICAL: 每次内容必须不同，禁止重复。**

## 步骤1：确定今天是第几天

运行 `date +%Y-%m-%d`。读取 plan 文件顶部的 `Day 1 = …`，计算 day index N。  
若 N 超过 plan 行数：输出「课程已结束」摘要，并 `cronjob(action='pause', job_id=<当前>)`。

## 步骤2：读取学习计划

读取 `~/.hermes/daily/learning/plan.md`，定位第 N 天主题。

## 步骤3：读取历史记录

```bash
ls ~/.hermes/daily/learning/history/
```

读取最近 3 个文件，避免重复主题与例句。

## 步骤4：生成今日内容

- 概念讲解（通俗）
- 代码示例（若用户配置了项目目录则优先真实代码；否则用最小可运行示例）
- 常见陷阱
- 1 道思考题

可选项目目录（用户可改）：`PROJECT_DIR` 未设置则跳过真实代码引用。

## 步骤5：保存

写入 `~/.hermes/daily/learning/history/day_NN_<slug>.md`（NN 两位数字）。

## 输出格式

```
📚 技术学习 Day X
📅 YYYY-MM-DD | [主题]

---
🧠 概念速览
…

💻 代码实战
…

⚠️ 常见陷阱
…

❓ 思考题
…
```

机制说明：[Progressive Cron](../skills/content-progression/SKILL.md)
