# 🧠 Node Designation & Specialization – Design Doc

## 🧨 Problem

The original Warfare system treats smart terrains as static "territory", "resource", or "base" — with hardcoded functions and no post-capture interaction. This:

- Kills strategic depth
- Prevents faction differentiation
- Makes captured nodes feel meaningless
- Gives players no control after conquest

## 🎯 Goals

We want to transform Warfare into a true territory control system where nodes evolve based on player/faction investment.

Key goals:
- Make captured points meaningful
- Let players **assign function** to conquered nodes
- Tie **node output to specialization**
- Enable **upgrading** and **scaling**
- Create real **conflict over artifact zones**

## 🏗 System Breakdown

### 1. Node States

| State        | Description                            |
|--------------|----------------------------------------|
| `territory`  | Neutral. Does nothing until established |
| `base`       | Requires specialization (Trader, etc.) |
| `resource`   | Requires specialization (Scrap, etc.)  |
| `artifact`   | Predefined, anomaly-linked, fixed      |

NPC factions auto-convert. Player must invest to assign.

---

### 2. Specializations

#### 🏭 Base Specializations
- `Trader`: Trader stock scaling, unique goods
- `Research`: Improves output of nearby nodes
- `Militia`: Trains and gears stationed squads
- `HQ`: All 3 roles in one. Only one per faction

#### ⚒ Resource Specializations
- `Scrap`: Affects armor and weapons pool
- `Electronics`: Affects detectors, scopes, nightvision
- `Herbs`: Affects medkits, drugs, rad protection

#### 💠 Artifact Nodes
- Not assignable. Fixed locations in anomaly zones
- High-conflict. Artifacts = rare power/gear boosts

---

### 3. PDA UX Flow

- Right-click on a player-owned smart terrain → Context Menu addition (already hold "Select point" or "Recruit <level> squad")
  - `Establish Node` (if territory)
  - `Specialize Node` (if base/resource)
  - `Upgrade Node` (tiered future investment)

- Icons update per type and level
- Tooltip shows node status and output

---

### 4. Design Philosophy

- Empower players with post-capture strategic decisions
- Let AI factions evolve similarly (scripted logic)
- Introduce asymmetry via specialization choice
- Allow future upgrades to scale depth (training time, output rate)

---

## 🧪 Codex Implementation Notes

- Treat each state/specialization as a **data-driven enum**
- Track node state in a centralized `node_state_registry`
- Add logic hooks to node capture events
- All context menu options must be **ownership-gated**
- Use modular functions to allow feature gating per faction or difficulty
