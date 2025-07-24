# ☢️ G.A.M.M.A. Warfare Fix & Rewrite Project

> Turning STALKER: Anomaly’s notoriously unstable Warfare mode into something *actually playable*.

---

## 🧠 Overview

This repo is a clean, modular patch + rewrite pipeline for STALKER Anomaly’s **Warfare mode**, which simulates large-scale AI faction warfare.  
We're merging the core Warfare ALife Overhaul (WALO) with the G.A.M.M.A. patch layer — and hardening everything with modern Lua scripting practices.

**Why?**  
Because Warfare is:
- Fun as hell ✅  
- Unstable as hell ❌  
- Written like hell 🔥  

So we’re fixing that.

---

## 📁 Project Structure
`old walo/`  – original Warfare ALife Overhaul base scripts
`gammas patch/` – G.A.M.M.A. patch overrides
`gamma_walo/` – merged & hardened output
`runtime files/` – files loaded at runtime for testing
`modmap.md` – overview of script roles
`warfare_scripts_documentation.md` – generated function list

---

## 🛠️ Goals

- ✅ Merge stable patch logic from G.A.M.M.A. into WALO
- ✅ Harden all Lua scripts: nil checks, iteration guards, debug trace support
- 🔄 Improve Warfare stability without breaking behavior
- 🔁 Build tooling so Warfare and Story Mode can co-exist cleanly
- 🧠 Document and modularize to help other STALKER devs

---

## 🤖 Codex Integration

We use [OpenAI Codex](https://platform.openai.com/docs/guides/codex) to automate merging, hardening, and documentation.  
See [`agents.md`](./agents.md) for task presets like:

- `Merger`: Merge patch logic safely into base files
- `Fixer`: Add nil guards and safe loops
- `Analyzer`: Diff patches and explain changes
- `DocGen`: Build function index of `.script` files
- `StressTester`: Inject debug logging to spot runtime crashes

---

## 🧪 Status

| Phase              | Description                          | Progress |
|-------------------|--------------------------------------|----------|
| Patch merge        | Merge gammas patch into old walo      | ✅ Done  |
| Script hardening   | Apply Lua safety patterns            | 🟡 Ongoing |
| Debug tracing      | Inject log points into sim/task AI   | 🔜 Next |
| LTX pass           | Review + merge `.ltx` configs        | 🔜 Next |
| Story/Warfare sync | Run both modes on same save          | 🚧 Researching |

---

## 🧰 Requirements

If you want to contribute or fork:

- Lua 5.1 syntax understanding
- Familiarity with STALKER Anomaly’s `sim_`, `task_`, `xr_` systems
- Experience with LTX configs and MO2-style override trees
- Optional: Codex or Copilot for AI-assisted tasks

Helpful Links:
- [Anomaly API Reference (Community)](https://github.com/revolucas/anomaly-api-docs)
- [G.A.M.M.A. Repo](https://github.com/Grokitach/Stalker-GAMMA)
- [STALKER Modding Wiki](https://modwiki.stalker-game.com/Main_Page)

---

## 🧩 Contributing

Want to help de-spaghetti STALKER’s most cursed system?

- Clone this repo
- Look in `gamma_walo/` for refactored files
- Use tasks from `agents.md` in Codex or Copilot
- Open PRs that add safety, clarity, or stability (not just "style")

---

## 💬 Contact

Maintainer: [`d0pe1`](https://github.com/d0pe1)

Zone-side help & contributions welcome.  
If your fix stops a crash, **you’re one of us**.

---

> *"He who controls the sim tables controls the Zone."*
