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

🎯 "Warfare Evolved" – Gameplay Expansion Concept
The vision is to evolve the static, territory-only warfare into a rich, strategic, narrative-driven, resource-oriented warfare system.

🏗️ 1. Placeables & Infrastructure System
🛠 Dynamic Placeable Structures
Factions place strategic buildings to boost their territorial advantage:

Armoury

Improves weapon and ammo quality of local NPCs.

Slowly upgrades NPC gear tiers over time.

Weaponsmith

Converts resources into faction-wide weapon upgrades or special ammo.

Unlocks custom weapon crafting for player-aligned factions.

Medical Outpost

Provides healing to nearby squads (faster respawns, less downtime).

Produces medicine from resource nodes, making squads more resilient.

Guard Posts and Fortifications

Stationed guards defending strategic chokepoints.

Slows down enemy invasions, offering tactical defense benefits.

📦 2. Deep Resource System
Replace generic "Resource" with diverse, interactive resources:

Scrap (metal parts, ammo casing, armor plates)

Herbs (medical, stimulants, radiation protection)

Electronics (radio components, weapon mods, detectors)

Artifacts (special upgrades, rare trading goods, anomaly research)

🌍 Dynamic Resource Nodes
Capture and control nodes to feed faction resource pools.

Influence dynamic gear quality, trader inventory, faction equipment upgrades.

⚖️ Resource Pool & Influence
Resource quantity and type directly influence:

NPC weapon and armor quality.

Trader item stocks.

Player faction’s NPC strength scaling.

🗺️ 3. Custom Faction & Diplomacy System
⚙️ Faction Creation & Customization
Found and name your faction.

Define relations dynamically with other factions (Friendly, Neutral, Enemy).

Recruit from neutral or existing NPC factions.

📝 Diplomatic Interactions
Interactive diplomacy UI: negotiate alliances, trade deals, combined attacks.

Proactive NPC-driven diplomacy requests:

Example: "Duty proposes attacking Freedom’s main base. Will you join us?"

Negotiate tariffs, rewards, resource-sharing conditions via interactive dialogue.

📞 Dynamic Alliances & Rivalries
Alliances can shift dynamically based on your choices and NPC actions.

Betrayals, long-term hostilities, or cooperative wins build unique narratives.

📖 4. Meta Narrative Engine ("Monolith AI Overlord")
🧠 Monolith AI Overlord
Acts as an intelligent, strategic antagonist controlling mutant hordes and anomalies aggressively.

Dynamically deploy mutant squads and anomaly surges to destabilize powerful factions.

AI reacts intelligently based on player actions and faction power balances.

🐺 Dynamic Mutant Raids
Strategic mutant hordes triggered by AI Overlord, directly attacking resource nodes, disrupting faction supply lines.

🌟 5. Legendary Squad System
🎖️ Squad Progression & Ranking
Successful squads gain experience, ranks, becoming named "legendary squads".

Higher-ranked squads gain tactical benefits: increased accuracy, durability, advanced weapons, and armor.

Player may encounter, fight alongside, or recruit legendary squads, enhancing narrative immersion.

🎮 6. Expanded Strategic Gameplay Loops
Capture → Defend → Expand → Negotiate → Resource Production → Upgrades.

Diplomacy → Alliances → Combined Strategic Attacks → Territory Gains.

AI Narrative Counteractions (Monolith AI) → Emergent Tactical Scenarios.

⚙️ Technical Roadmap for Codex
Step-by-Step Task Outline for Codex Implementation:
Phase 1: Resource & Placeable Infrastructure

Implement dynamic resource types (Scrap, Herbs, Electronics, Artifacts).

Design placeable structures system (Armoury, Weaponsmith, Medics, Guard Posts).

Link resource nodes to faction inventory and NPC item scaling.

Phase 2: Custom Faction & Diplomacy Mechanics

Develop faction-creation UI and backend logic.

Build diplomatic negotiation dialogue system.

Create proactive NPC diplomatic requests.

Phase 3: Meta Narrative & Legendary System

Develop AI-controlled "Monolith Overlord" antagonist logic.

Implement mutant raid event triggers.

Create "legendary squads" system with ranks and progressive benefits.

Phase 4: Integration and Testing

Pester-style Lua (Busted) testing suite to validate each gameplay subsystem.

Balance gameplay mechanics (resource economy, AI difficulty, squad power scaling).

✅ Resulting Gameplay Loop (Player Perspective)
Player forms their faction, decides allies/enemies.

Captures resource nodes and builds strategic infrastructure.

Faction resources determine overall NPC power & trader availability.

Player navigates diplomatic landscape dynamically.

Monolith AI attempts tactical disruptions via anomalies/mutants.

Legendary squads form naturally, influencing battlefield outcomes.

Continuous, evolving emergent warfare sandbox.

💬 Prompt for Codex Implementation
"Using the Lua-based G.A.M.M.A. Warfare repo, implement the comprehensive gameplay expansion detailed above. Clearly modularize each gameplay feature.
Start with Phase 1 (Resource & Infrastructure).
Ensure tests (Busted) validate resource, placement logic, and faction scaling clearly. Document all changes in the repo’s CHANGELOG.md and generate clear Markdown docs."
