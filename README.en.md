# programming-tutor

**An Agent-Skill for Claude Code / Cowork — a step-by-step, hands-on programming tutor for learning languages and frameworks, with Claude acting as a patient personal tutor.**

You'll work in your own editor (VS Code recommended) on small hands-on exercises, and iterate through code reviews, building real skills one step at a time.

🌐 **Languages**: [日本語](./README.md) · **English** · [中文](./README.zh.md) · [Español](./README.es.md) · [Français](./README.fr.md)

---

## Who is this for

### ✅ Good fit

- You're new to programming, or new to a specific language/framework
- You're self-studying and want a structured curriculum plus someone who reviews your code on the spot
- Official docs exist, but you don't know in what order to tackle them
- You want someone to check your code but have no one to ask
- You have fragmented time (15–60 minutes/day) and need bite-sized material
- You already know another language and want to learn a new one's idioms and pitfalls efficiently

### ⚠️ Not a good fit

- **You want it to write your production code for you.** This skill is for learning. For real work, use a different workflow.
- You want a finished app quickly without actually learning
- You're already fluent and just want dictionary-style Q&A

---

## Important: this is a learning skill, not a production tool

This skill provides **an environment for learning**. Please keep in mind:

- **Don't ask it to implement your work tasks.** The agent is designed to *withhold* complete answers and guide you with hints. If you need code fast, this will frustrate you.
- **Generated plans, exercises, and sample code are educational.** They prioritize clarity over production-grade rigor (security, performance, edge cases). Do not copy them directly into production.
- **Don't paste secrets.** Keep proprietary code, personal data, and API keys out of your learning chats.
- **Cross-check with official docs.** The curriculum is *a* recommended path, not *the* only truth. Ecosystems change, so verify against current upstream documentation.

---

## Supported technologies

| Category | Technologies | Reference file |
| --- | --- | --- |
| Language basics | Python / JavaScript / TypeScript / Java / C# / Go / Ruby, etc. | `references/language-general.md` |
| .NET | C# / ASP.NET Core / EF Core | `references/dotnet.md` |
| Spring Boot | Java / Spring Boot / Spring Data JPA | `references/spring-boot.md` |
| NestJS | Node.js / TypeScript / NestJS / Prisma | `references/nestjs.md` |
| React | React / TypeScript / Vite / React Router | `references/react.md` |
| Rust | Rust / Cargo / ownership / CLI building | `references/rust.md` |

For technologies without a dedicated reference (Next.js, Flutter, Go web frameworks, etc.), the agent builds a curriculum using `language-general.md` as the base. You can also add your own reference file (see "Customization" below).

---

## Installation

This repository holds **source files**. There are three ways to install.

### A) Download the `.skill` from GitHub Releases (easiest)

1. Grab the latest `programming-tutor.skill` from the [Releases page](https://github.com/SimJ/programming-tutor-skill/releases)
2. **Claude Code**: double-click the `.skill`, or use "Install Skill" in the UI
3. **Cowork**: drag the `.skill` into the chat, then click "Save Skill"

### B) Clone the repo directly into your skills folder

Best for developers who want to track `main`.

```bash
# Claude Code
git clone https://github.com/SimJ/programming-tutor-skill.git ~/.claude/skills/programming-tutor

# For Cowork, clone into the skills folder shown in your settings
```

Update later with `cd ~/.claude/skills/programming-tutor && git pull`.

### C) Build the `.skill` yourself

Use this if you've forked and modified the skill, or if no Release has been published yet.

```bash
git clone https://github.com/SimJ/programming-tutor-skill.git
cd programming-tutor-skill
bash scripts/build.sh
# => dist/programming-tutor.skill
```

Then install that file the same way as option A.

---

## How to use

### 1. Trigger it

The skill activates on any learning-intent phrase. You don't need to say "use this skill".

- "I want to learn Rust from scratch"
- "Help me get good at Spring Boot"
- "Walk me through React step by step"
- "Review my TypeScript code"
- "I'm new to programming — where do I start?"

To explicitly invoke it, you can prefix with "with the programming-tutor skill".

### 2. Answer the hearing

The agent asks four questions upfront (mostly multiple-choice via `AskUserQuestion`):

- Target technology (which language/framework)
- Current level (beginner / experienced in other languages / basics in place / intermediate+)
- Goal (work / hobby / certification / curiosity)
- Pace (time per day, target completion)

It also checks your environment (OS, editor, runtime versions). You can run the helper:

```bash
bash scripts/check_env.sh rust     # specific technology
bash scripts/check_env.sh all      # everything at once
```

### 3. Receive your learning plan

Two files appear in your working directory: `learning-plan.md` (chapters, target states, tools, final artifact) and `progress.md` (per-step tracker). Review, ask for adjustments, and confirm.

### 4. Enter the Step-by-Step loop

Each step has this shape:

```
## Step N: <title>
### Why this matters
### Core idea
### Minimal example
### Your task
- [ ] do this
- [ ] then this
```

Then the agent **stops and waits**. You code in VS Code.

### 5. Signal back

| You say | What happens |
| --- | --- |
| "done" / "finished" | Ready to move on; `progress.md` updates; next step intro |
| "review it" / "check this" | Code review with bugs → design → style levels |
| "hint" / "stuck" | Gradual hints: question → related concept → partial snippet → final answer (last resort) |
| "next" | Advance |
| "break" | Current position summarized; easy to resume |
| "skip" / "harder" | Difficulty adjustment |
| "switch technologies" | Full restart with new hearing |

### 6. Code review format

```
👍 Strengths        (1–3 specific points)
🚨 Must fix (bugs)   (highest priority)
⚠️ Should improve (design)  (max 2)
💡 Style / future   (optional)
Next action         (move on / fix and resubmit)
```

Feedback depth matches your level — beginners get minimal nits, advanced learners get design trade-off discussions.

---

## Directory layout

```
programming-tutor/
├── SKILL.md                          # Agent behavior definition
├── README.md                         # Japanese (default)
├── README.en.md                      # English (this file)
├── README.zh.md                      # Chinese (Simplified)
├── README.es.md                      # Spanish
├── README.fr.md                      # French
├── LICENSE                           # MIT
├── references/                       # Load-on-demand teaching materials
│   ├── pedagogy.md
│   ├── onboarding.md
│   ├── code_review.md
│   ├── language-general.md
│   ├── dotnet.md
│   ├── spring-boot.md
│   ├── nestjs.md
│   ├── react.md
│   └── rust.md
├── assets/                           # Templates the agent clones
│   ├── learning-plan-template.md
│   ├── progress-tracker-template.md
│   └── exercise-template.md
└── scripts/
    └── check_env.sh
```

"Load-on-demand" means only the reference file for your chosen technology is loaded — keeping the agent's context light.

---

## Language support

The skill itself supports learners in five languages: **日本語 / English / 中文 (简体) / Español / Français**.

- The agent auto-detects your language from the first message
- If uncertain, it asks you once via a multiple-choice question
- You can switch anytime: "from now on in English", "请用中文", "en español por favor", "passons au français", "日本語に戻して"
- Code, filenames, commands, and library names always remain in English

---

## Customization

### Add a new technology

For a framework not yet covered (e.g., Next.js):

1. Create `references/nextjs.md`, using `react.md` or `nestjs.md` as a template
2. Include: prerequisites, chapter-by-chapter curriculum with target states, common pitfalls, code review foci, recommended final artifacts
3. Add the file to the list in `SKILL.md`'s Planning section

### Change teaching style

- Step granularity → edit `references/pedagogy.md` "step-size checklist"
- Review strictness → edit `references/code_review.md` "depth by level"
- Language/tone preferences → edit `SKILL.md` "Language handling"

### Where progress files go

By default, `learning-plan.md` and `progress.md` land in the working directory root. Tell the agent "put them in ./docs/" and it complies.

---

## FAQ

**Q: I want to skip ahead. The confirmation cycle is slow.**
A: Say "auto mode" or "advance through chapter 3". The skill honors this but notes that retention suffers.

**Q: The agent won't just give me the answer.**
A: That's intentional. After 2–3 hint exchanges, it shows the full solution with explanation. If you need it immediately, say "just show me the answer".

**Q: I want to switch technologies.**
A: Say "switch to React" — it re-runs the hearing for the new topic. Your previous `progress.md` stays.

**Q: Can I use this across multiple sessions (weeks/months)?**
A: Yes. Open a session with "continue where we left off"; the agent reads `progress.md` and resumes. Keep a stable working directory.

**Q: I need to ship code at work.**
A: Don't use this skill — use regular Claude / Claude Code for that. This one deliberately slows you down to maximize learning.

**Q: My file is huge — can it be reviewed?**
A: Files over ~500 lines will prompt a "which part should I focus on?" question. Normal learning sessions don't produce files that big.

**Q: It didn't trigger.**
A: Edit `SKILL.md`'s `description` to include your common phrasings. Or invoke it explicitly: "with programming-tutor".

---

## Versioning

- v1: April 2026
- License: MIT (free to fork and modify)
- Feedback: open an issue on this repository, or tell Claude "please update `references/pedagogy.md` to ..."

---

## Credits

Built following the Anthropic `skill-creator` pattern.
Structure (`SKILL.md` + `references/` + `assets/` + `scripts/`) uses progressive disclosure so only the relevant context loads per session.
