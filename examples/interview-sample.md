# Example output — Daily interview question

🎯 Daily Interview · Day 12 — C++ concurrency  
难度：⭐⭐

---

❓ 题目  
实现一个线程安全的“只初始化一次”的懒加载单例。比较 `std::call_once`、函数内 static（Magic Statics）、以及双重检查锁定（DCLP）三种写法的正确性与代价。什么情况下你仍会避免单例？

💡 参考答案（要点）  
1. **C++11 起函数内 local static 初始化是线程安全的**（Magic Statics）——通常是最简单正确的默认。  
2. **`std::call_once` + `once_flag`** 适合初始化逻辑与对象生命周期分离、或需要显式控制的场景。  
3. **手写 DCLP 极易错**：需要正确的内存序；现代 C++ 几乎总是不值得。  
4. 单例的真正成本常在 **可测性与隐藏依赖**，不在那几行锁。

🔍 面试官可能追问  
- `static` 初始化失败抛异常后，再次进入会怎样？  
- 多动态库 / 插件卸载顺序下的销毁问题（destruction order fiasco）  
- 若需要“可重置”的全局状态，API 会怎么设计？

📝 答题要点  
• 先给正确默认写法，再谈 trade-off  
• 提到 memory model / happens-before（加分）  
• 主动提到测试与依赖注入（资深信号）
