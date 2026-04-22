# programming-tutor

**面向 Claude Code / Cowork 的 Agent-Skill —— 让 Claude 化身为一位耐心的私人家庭教师，带你一步一步地、亲自动手地学习编程语言和框架。**

你在自己的编辑器（推荐 VS Code）中完成小而具体的练习，通过代码审查不断迭代，一步一步建立真正的能力。

🌐 **语言**: [日本語](./README.md) · [English](./README.en.md) · **中文** · [Español](./README.es.md) · [Français](./README.fr.md)

---

## 适合哪些人

### ✅ 非常适合

- 刚开始编程，或者想入门一门新语言 / 新框架
- 自学者，希望有"体系化的课程"加"能当场审查你代码的人"
- 官方文档是齐全的，但你不知道从哪一章开始、按什么顺序读
- 希望有人帮忙 review 你的代码，却身边没有可请教的人
- 时间碎片化（每天 15–60 分钟），需要短小可完成的教材
- 已经会其他语言，想高效学习新语言的"地道写法"和"常见坑"

### ⚠️ 不太适合

- **想让它帮你写业务代码。** 本技能是用于学习的。真实工作请用别的工作流。
- 想跳过学习、快速拿到一个完整应用
- 你已经很熟练这门技术，只想要"字典式问答"

---

## 重要：这是"学习用"技能，不是"工作用"

本技能提供的是 **一个用于学习的环境**，请注意：

- **请勿让它直接写你的业务代码。** Agent 会刻意不把完整答案直接交给你，而是用提示一步一步引导你。如果你赶时间出代码，这种节奏会让你抓狂。
- **生成的课程计划、练习、示例代码都是教学用的。** 它们优先照顾清晰、便于理解，而非生产级的严谨（安全性、性能、边界情况不齐全）。请勿直接照搬进生产代码。
- **不要粘贴机密信息。** 公司内部代码、个人信息、API Key 等请避免出现在学习对话里。
- **关键决策请与官方文档交叉验证。** 这里的课程是 *一条* 推荐路径，不是 *唯一* 真理。生态会变，请以上游文档为准。

---

## 已支持的技术

| 类别 | 技术 | 参考文件 |
| --- | --- | --- |
| 语言通用 | Python / JavaScript / TypeScript / Java / C# / Go / Ruby 等 | `references/language-general.md` |
| .NET | C# / ASP.NET Core / EF Core | `references/dotnet.md` |
| Spring Boot | Java / Spring Boot / Spring Data JPA | `references/spring-boot.md` |
| NestJS | Node.js / TypeScript / NestJS / Prisma | `references/nestjs.md` |
| React | React / TypeScript / Vite / React Router | `references/react.md` |
| Rust | Rust / Cargo / 所有权 / CLI 开发 | `references/rust.md` |

未列出的技术（如 Next.js、Flutter、Go Web 框架等），Agent 会以 `language-general.md` 为基础现场搭出课程。你也可以自己补充一个参考文件（见下文「自定义」）。

---

## 安装

本仓库存放的是**源文件**。有三种安装方式可选。

### A) 从 GitHub Releases 下载 `.skill`（最简单）

1. 在 [Releases 页面](https://github.com/SimJ/programming-tutor-skill/releases) 下载最新的 `programming-tutor.skill`
2. **Claude Code**：双击 `.skill`，或者在 UI 中选择 "Install Skill"
3. **Cowork**：把 `.skill` 拖进对话窗口，点击 "Save Skill"

### B) 直接克隆仓库到 skills 文件夹

适合开发者——希望跟上 `main` 的最新状态。

```bash
# Claude Code
git clone https://github.com/SimJ/programming-tutor-skill.git ~/.claude/skills/programming-tutor

# Cowork：克隆到设置中显示的 skills 文件夹下
```

以后更新只需 `cd ~/.claude/skills/programming-tutor && git pull`。

### C) 自己构建 `.skill`

如果你 fork 并做了修改，或者还没有发布 Release，就用这种方式。

```bash
git clone https://github.com/SimJ/programming-tutor-skill.git
cd programming-tutor-skill
bash scripts/build.sh
# => dist/programming-tutor.skill
```

生成的文件按 A) 的方法安装即可。

---

## 使用方法

### 1. 触发

说出任何带有"学习意图"的话即可，不必强调"用这个技能"。

- "我想从零开始学 Rust"
- "帮我学 Spring Boot"
- "带我一步一步学 React"
- "帮我 review 这段 TypeScript"
- "我是新手，该从哪里开始？"

如想明确调用，可加一句"用 programming-tutor 技能"。

### 2. 回答开头的提问

Agent 会先问 4 个问题（大多是 `AskUserQuestion` 的选择题）：

- 目标技术（语言 / 框架）
- 当前水平（零基础 / 已有其他语言经验 / 已掌握基础 / 中级以上）
- 目标（工作用 / 爱好项目 / 考证或面试 / 纯粹兴趣）
- 节奏（每天时间、期望完成时间）

同时会检查环境（OS、编辑器、运行时版本）。可用辅助脚本：

```bash
bash scripts/check_env.sh rust     # 指定技术
bash scripts/check_env.sh all      # 全部检查
```

### 3. 收到学习计划

当前工作目录会出现两个文件：`learning-plan.md`（章节、到达状态、工具、最终产物）和 `progress.md`（逐步进度）。请 review 一下，提修改建议，再确认继续。

### 4. 进入 Step-by-Step 循环

每一步都是这个结构：

```
## Step N: <标题>
### 为什么学这个
### 核心思路
### 最小示例
### 你的任务
- [ ] 做这个
- [ ] 再做这个
```

然后 **Agent 会停下来等待**。你在 VS Code 里自己写代码。

### 5. 用关键词推动节奏

| 你说 | 会发生什么 |
| --- | --- |
| "做完了" / "完成了" | 准备进入下一步；`progress.md` 更新；下一步介绍 |
| "帮我 review" / "看一下" | 进入代码审查：bug → 设计 → 风格分三级 |
| "提示" / "卡住了" | 渐进式提示：问题 → 相关概念 → 部分片段 → 最终答案（作为最后手段） |
| "下一步" | 推进 |
| "先休息" | 总结现在进度，方便下次回来续接 |
| "跳过" / "难一点" | 调整难度 |
| "换一个技术" | 重新进入开头的提问流程 |

### 6. 代码审查的格式

```
👍 做得好的地方       （1–3 条具体表扬）
🚨 必须修的（bug）    （最高优先级）
⚠️ 建议改进（设计）   （最多 2 条）
💡 风格 / 以后再看    （可选）
下一步                （继续 / 改完再发）
```

反馈深度会匹配你的水平——新手不会被挑风格小毛病；中高级会被讨论设计权衡。

---

## 目录结构

```
programming-tutor/
├── SKILL.md                          # Agent 行为定义
├── README.md                         # 日本語（默认）
├── README.en.md                      # 英文
├── README.zh.md                      # 中文（本文件）
├── README.es.md                      # 西班牙文
├── README.fr.md                      # 法文
├── LICENSE                           # MIT
├── references/                       # 按需加载的教学资料
│   ├── pedagogy.md
│   ├── onboarding.md
│   ├── code_review.md
│   ├── language-general.md
│   ├── dotnet.md
│   ├── spring-boot.md
│   ├── nestjs.md
│   ├── react.md
│   └── rust.md
├── assets/                           # Agent 会 clone 的模板
│   ├── learning-plan-template.md
│   ├── progress-tracker-template.md
│   └── exercise-template.md
└── scripts/
    └── check_env.sh
```

"按需加载"意味着只有你选中的技术对应的 reference 文件会被读入，Agent 的上下文不会被其他 curriculum 占满。

---

## 多语言支持

本技能支持 5 种学习者语言：**日本語 / English / 中文（简体） / Español / Français**。

- Agent 会根据你的第一句话自动判断语言
- 判断不了时，会用选择题问你一次
- 随时可以切换："以后用英文"、"请用中文"、"en español por favor"、"passons au français"、"日本語に戻して"
- 代码、文件名、命令、库名始终保持英文原样

---

## 自定义

### 新增一个技术

例如新增 Next.js：

1. 创建 `references/nextjs.md`，可以参考 `react.md` 或 `nestjs.md` 的结构
2. 包含：前置条件、逐章课程与到达状态、常见陷阱、代码审查要点、推荐最终产物
3. 在 `SKILL.md` Planning 节的参考列表里加上这个文件

### 调整教学风格

- 步骤粒度 → 编辑 `references/pedagogy.md` 的 "step-size checklist"
- 审查严格度 → 编辑 `references/code_review.md` 的 "depth by level"
- 语言/语气 → 编辑 `SKILL.md` 的 "Language handling"

### 进度文件的位置

默认 `learning-plan.md` 和 `progress.md` 放在工作目录根。让 Agent "放到 ./docs/ 下"即可。

---

## FAQ

**Q：我想快进，确认来确认去太慢。**
A：说"自走模式"或"直接推进到第 3 章"。技能会照做，但会提醒你这样记忆保留率会降低。

**Q：Agent 不直接给我答案。**
A：设计如此。经过 2–3 轮提示仍然卡住的话，它会给出带解释的完整答案。如果立刻就要答案，直接说"给我答案"。

**Q：想换一个技术。**
A：说"换成 React"即可，会为新主题重新问开头的问题。旧的 `progress.md` 保留。

**Q：能跨多次 session 使用（数周 / 数月）？**
A：可以。每次用"接着上次"开头，Agent 会读 `progress.md` 恢复。请保持工作目录稳定。

**Q：工作上要交付代码。**
A：别用这个技能，用普通的 Claude / Claude Code。本技能刻意放慢节奏，目标是学习不是产出。

**Q：文件很大能 review 吗？**
A：单文件超过 500 行时 Agent 会反问"你想我重点看哪一部分？"。正常学习练习不会写到那么大。

**Q：没有被触发。**
A：编辑 `SKILL.md` 的 `description` 加上你常用的说法。或明确写"用 programming-tutor"。

---

## 版本

- v1: 2026-04
- License: MIT（可自由 fork 和修改）
- 反馈：在本仓库开 issue，或告诉 Claude："请更新 `references/pedagogy.md` 的这里..."

---

## 致谢

遵循 Anthropic `skill-creator` 的规范构建。
结构（`SKILL.md` + `references/` + `assets/` + `scripts/`）采用 progressive disclosure（按需加载），每次只加载相关上下文。
