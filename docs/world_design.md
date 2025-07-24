# 🌍 G.A.M.M.A. Warfare Overhaul — World Design Document

## 🎯 Objective

Design a reactive, living, and semi-persistent world model to underpin the modular warfare simulation introduced in the G.A.M.M.A. Warfare Overhaul. The world must reflect the consequences of AI decisions, player influence, economic collapse, and supply chain disruption in both overt and subtle ways.

This system is intended to be:

- **State-aware**: Factions exist as intelligent agents with goals.
- **Economically bounded**: Nothing is free; everything from squad spawns to gear is gated by logistics and resource chains.
- **Tactically and narratively expressive**: The Zone tells a story through faction movement, collapse, expansion, and diplomacy.

---

## 🧱 Faction as State-Aware Actor

Factions are defined as semi-autonomous agency frameworks. Each faction:

- Has a **central HQ** that acts as the strategic command.
- Is assigned a **Faction Philosophy** configuration file.
- Has a set of dynamic **Goals** (e.g., "secure artifact nodes," "maintain border with enemy").
- Uses **resources** to take action (spawn, upgrade, negotiate).
- Makes decisions using **priority tables** weighted by philosophy, threat level, and opportunity.

Factions without HQs are considered shattered or directionless and behave like raider bands with limited resource use and no diplomacy.

---

## 🛠 Systems that Define the World

### 1. **Territory Control Layer**

- Each map node (smart terrain) can be:

  - **Unclaimed Territory**
  - **Base Node** (militia/research/trader/HQ)
  - **Resource Node** (scrap/herbs/electronics/artifacts)

- Players or factions can convert claimed territory into bases/resources via investment.

- These nodes have visible PDA overlays showing current use and upgrade level.

### 2. **Daily Simulation Cycle**

- Every in-game day, the world:
  - Ticks resource node outputs
  - Consumes base resources to perform functions
  - Schedules supply tasks to refill drained bases
  - Spawns squads if enough resources exist
  - Evaluates diplomatic pressure and random events

### 3. **Transport & Supply Mechanics**

- Each base can store up to **10 of each resource type**.
- When depleted, requests are sent to HQ → nearest node with available stock.
- **Supply Squads** are commissioned:
  - Each stalker in the squad can carry 1 unit.
  - Smart resource merging (one squad carries multi-resource payloads).
  - If killed, their payload can be looted and redirected.

### 4. **Dynamic Conflict & Event Triggers**

- Bases under attack delay output.
- Supply routes become contested chokepoints.
- Holding artifact zones boosts Monolith aggression.
- Losing HQ causes faction collapse, reroutes diplomacy.

---

## 🧠 Hooks Between Systems

| From                  | To              | Hook Description                                          |
| --------------------- | --------------- | --------------------------------------------------------- |
| Resource Node         | Base Node       | Output → Input for functions (spawn, train, trade)        |
| Faction Philosophy    | Expansion Logic | Determines where/what to claim next                       |
| HQ                    | Spawn System    | Governs squad quantity, type, and spawn delay             |
| Supply Squad Death    | Patrol System   | Enables item pickup → delivery to destination             |
| Player Faction Choice | Diplomacy Logic | Modifies initial alignment and tribute offers             |
| Anomaly/Artifact Zone | Event System    | Higher artifact density triggers mutant or Monolith raids |

---

## 🔧 Implementation Priorities

1. Core Territory System: designation + upgrades.
2. Daily Sim Engine: consumption/production, transport triggers.
3. Squad AI: logistic role, payload management, fallback.
4. Resource Visual Overlays: show who controls what.
5. Diplomacy Integration: player + AI faction logic.
6. Modular configs: all faction behavior defined in editable files.

---

## 🧠 Codex Prompt (Design Pass)

```markdown
You're designing the underlying world model for the STALKER Anomaly Warfare Rework.
Implement a reactive, daily-updating world where factions:
- Use HQs to make expansion, spawn, and resource allocation decisions.
- Spawn squads only when enough resources are present.
- Move transport squads to fulfill base demands.
- Engage in diplomacy based on map control and current needs.
- Fall into collapse if HQ is destroyed or supplies choke.
Use modular `.script` files and data-driven `.ltx` configs. Every action should leave traces in PDA overlays, squad stats, and dynamic event logs.
Document every hook between systems.
```

---

> The Zone is no longer a backdrop. It’s an evolving system of interconnected needs, behaviors, and betrayals.

