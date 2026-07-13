# 每日思考题

开放性问题，7 领域轮换。

**History:** `~/.hermes/daily/thinking/history/`

## 使用方式

```bash
hermes cron create "0 8 * * *" --name "每日思考" --prompt "$(cat cron-jobs/thinking.md)"
```

## Prompt 模板

提出一个能引发深度思考的问题。

**Language:** 中文  
**CRITICAL: 不与近 5 天重复。**

## 步骤1：领域

day index `mod 7`：

| mod | 领域 |
|-----|------|
| 1 | 人生哲学 |
| 2 | 创造力 |
| 3 | 决策与判断 |
| 4 | 人际关系 |
| 5 | 自我认知 |
| 6 | 价值观 |
| 0 | 科技与人性 |

## 步骤2：历史

读 `~/.hermes/daily/thinking/history/` 最近 5 个文件。

## 步骤3：问题标准

- 开放、多角度  
- 非知识点背诵  
- 附 3 个思考角度

## 步骤4：保存

`~/.hermes/daily/thinking/history/day_NN.md`

## 输出格式

```
🧠 每日一问
Day X - [领域]
YYYY-MM-DD

---
[问题]

💡 试着从这几个角度想：
- …
```
