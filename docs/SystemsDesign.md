# ☒️ G.A.M.M.A. Warfare Overhaul — Full System Design Doc

## 🌟 Project Vision

To transform the unstable and shallow STALKER: Anomaly Warfare mode into a **persistent, emergent, faction-driven simulation**. This means:
- **Tactical AI decision-making** grounded in resources, logistics, and faction identity.
- A **living economy** that governs everything from squad spawns to diplomacy.
- **Narrative systems** (like Monolith AI or dynamic alliances) that react to game state.
- **Community-expandable modularity**, making this a future-ready foundation.

This is not just "fixing" Warfare. It's building the **Zone as a self-regulating war machine** — where every bullet, body, and base matters.

---

## 🧩 Core Systems Overview

### 1. 🛠️ Resource Infrastructure System
**Resource Nodes**:
- Output limited daily resources: `scrap`, `electronics`, `herbs`, `artifacts`.
- Can be contested, looted, depleted, or enhanced via upgrades.
- Each faction can bias their acquisition toward preferred resources.

**Base Nodes**:
- Serve specific roles: `militia`, `research`, `trader`, or all-in-one `HQ`.
- Consume resources to produce strategic outputs:
  - **Militia**: Trains new squads and upgrades veterans.
  - **Research**: Enhances squad traits or unlocks strategic tools.
  - **Trader**: Buffs faction economy and availability of rare gear.

**HQ Nodes**:
- Central command that coordinates squad spawns, logistics, strategic decisions.
- Tracks stockpiles and issues logistics orders.

---

### 2. 🚚 Squad Logistics Simulation
**Transport Squads**:
- Carry resources from node → base.
- Stalkers each carry 1 unit of resource.
- Are vulnerable to raids, ambushes, or logistical bottlenecks.

**Behavior**:
- AI squads loot resources from dead transports.
- Smart fallback: patrols pick up dropped goods and deliver them.
- HQs reroute squads dynamically based on changing zone state.

---

### 3. 🎖️ Squad Progression & Legendary System
- Squads gain experience from successful tasks.
- Can be promoted to **legendary squads** with custom names, enhanced stats, gear tiers.
- Legendary squads appear on PDA and affect faction morale/spawn rates.

---

### 4. 🤝 Diplomacy & Player Faction System
**Custom Faction Creation**:
- Player defines starting traits, allies/enemies, preferred resource philosophy.
- Can declare war, offer tribute, request assistance.

**Dynamic AI Diplomacy**:
- Factions request support (e.g. Duty invites Freedom to attack Bandits).
- Negotiations are backed by real strategic offers (e.g. 5 herbs/month for access to Rostok militia training).

**Right-Click PDA Menu**:
- When selecting nodes, the player can:
  - Designate node roles (resource/base)
  - Specialize base (trader/research/militia)
  - Upgrade node levels
  - Open diplomacy actions

---

### 5. 🧠 Faction Philosophy System
Each faction has a `philosophy` config that:
- Determines strategic preferences:
  - **Duty**: values territory, weapons, medicine.
  - **Freedom**: prefers artifacts, herbs, range combat.
  - **Monolith**: disregards logistics, prioritizes aggression and anomalies.
- Influences AI node capture, resource routing, squad composition, diplomacy behavior.

This allows emergent simulation: Monolith overruns research nodes, Duty solidifies chokepoints, Ecologists remain isolated unless approached.

---

### 6. 🧪 Testing, Debugging & Documentation
- Full [`busted`](https://olivinelabs.com/busted/) test suite for Lua modules.
- Auto-generated changelogs + file diffs after Codex passes.
- Modular script files (`.script`, `.spec.script`, `md` docs) to document every system and its API.

---

## ♻️ System Interactions

| System | Hooks Into | Description |
|--------|------------|-------------|
| Resource Nodes | Logistics, Faction AI, Trader Inventory | Daily output → faction capabilities |
| Base Nodes | Squad spawning, Upgrades, Diplomacy | Determines what a faction can *do* |
| Squad AI | Resource/gear scaling, task queue, XP/rank | Squad power = what the economy supports |
| Diplomacy | Player actions, resource surplus, threats | War and peace emerge organically |
| Faction Philosophy | Everything | Defines faction behavior patterns |
| Transport/Patrol Logic | All above | Creates choke points, ambushes, emergent battles |
| Player UI | Right-click PDA map, diplomacy tab | Access to assign roles, negotiate, strategize |

---

## 🌐 Long-Term Modular Extensions
- **Anomaly System**: Factions fear/harvest anomalies differently.
- **Mutant Raids**: Triggered by Monolith Overlord or broken supply lines.
- **Artifact Economy**: Artifacts can be researched, crafted, used or traded.
- **Intel Warfare**: Scouts can reveal hidden movement, ambush routes, or trigger black ops tasks.
- **Community Faction Addons**: Philosophy and infrastructure logic allows plug-in custom factions.
- **Persistent Save Engine**: AI memory of previous raids, alliances, or backstabs.

---

## 🧠 Codex Prompt

```markdown
You are tasked with implementing a complete modular rework of STALKER Anomaly's Warfare mode as described in the `G.A.M.M.A. Warfare Overhaul` design doc.

Work incrementally:
1. Begin with the resource + base + logistics infrastructure as described.
2. Add squad spawn logic and equipment scaling based on resources.
3. Introduce faction HQs to coordinate logistics and spawning.
4. Add transport logic (supply squads, looting behavior, fallback logistics).
5. Implement diplomacy framework with resource tribute trade options.
6. Add faction philosophy config files and influence functions.
7. Generate `CHANGELOG.md`, test specs (`busted`), and full `.md` documentation.

Ensure:
- All files are self-contained and commented.
- Tests validate transport, spawn, and resource behaviors.
- Each system is hooked into others logically and exposes a clear API.
```

> This is not just fixing Warfare — it’s **building a logistics sandbox** worthy of the STALKER mythos.

