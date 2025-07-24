# 📦 Squad Resource System

## 🧠 Concept Overview
The squad-resource system governs how faction activities like spawning, training, logistics, and equipment scaling depend on the base/resource infrastructure. This adds realism and strategy depth to the STALKER Warfare simulation.

---

## 🔁 Core Mechanics

### 1. Resource Nodes
- Each resource node produces **a limited daily output** of one resource type: `scrap`, `electronics`, `herbs`, or `artifacts`.
- Resources accumulate daily and can be **depleted by transport orders**.
- Nodes have a finite per-day capacity and regenerate over time.

### 2. Base Nodes
- Base nodes include `militia`, `research`, and `trader` designations, and are coordinated by a **faction HQ** node.
- Every base node can **store up to 10 units per resource type**.
- Each base type **consumes specific resources** to perform its function:
  - **Militia Base:** Requires `scrap` and `herbs` to train squads and restock.
  - **Research Base:** Requires `electronics`, `herbs`, and `artifacts` to improve squad modifiers, resourcing logic, and research unlocks.
  - **Trade Post:** Requires `scrap`, `electronics`, and `artifacts` to enrich faction trade inventories and income.
- **HQ Base:** Serves as central coordination hub. Spawns squads, routes logistics, monitors resources, and may receive faction-specific upgrades.

### 3. Resupply & Squad Logistics
- When a base drops below max resource stockpile, it triggers a **poll for nearest node with required resource**.
- If found, the system schedules a **logistics squad** to deliver resources.
- Each squad member can carry **1 unit of a resource**, creating realistic transport bandwidth limits.
- Logistics squads are routed and prioritized by HQ based on:
  - Proximity
  - Urgency (resource type scarcity)
  - Route safety / threat level

---

## 🛍️ Transport & Interactions

### Squad Behavior
- Transport squads are filled with stalkers up to their max carrying capacity.
- If a patrol squad kills a transport squad:
  - The killer squad **loots and holds the cargo**.
  - If no current cargo: **transports it to destination**.
  - Otherwise: **waits for another squad to pick it up**, linked via task queue.

### HQ Logic
- All base logistics and resource paths are overseen by the faction's HQ.
- HQ handles spawn logic, task queuing, resource checks, and fallback behavior.
- HQ nodes are **priority-protected** and can **escalate defenses** based on importance.

---

## 🔗 Inter-system Hooks

### Resource → Base Node Output
- Node resource output **directly feeds base node productivity**.
- Base outcomes (training, gear scaling, trader restock) only trigger if required resources are stored.

### Diplomacy Hooks
- Players and NPC factions may **negotiate over excess resource throughput**.
- Trade deals allow renting excess capacity in exchange for alliances or tactical assistance.

### Faction Philosophy Hook
- Determines **resource preference bias**.
- Influences which resource nodes are prioritized for capture and which base types are built.
- Affects how HQ prioritizes transport to under-supplied bases.

---

## 🚀 Expansion Goals
- Squad task queue logic for dynamic transport scheduling.
- Conflict over transport routes: high-stakes ambush zones.
- UI visualizations for resource stockpiles and logistic paths.
- Extend to artifact research, relic crafting, and medicine distribution.
- Faction HQ upgrades (per-tier benefits, tech trees, intel control).

task completion:

all of these requirements are satisfied by files under gamma_walo
