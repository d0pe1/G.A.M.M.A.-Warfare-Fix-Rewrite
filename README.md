# ☢️ G.A.M.M.A. Warfare Fix & Rewrite Project

> Turning STALKER: Anomaly’s notoriously unstable Warfare mode into something *actually playable*.

...

## 🎯 "Warfare Evolved" – Gameplay Expansion Concept

(See full design notes in `docs/diplomacyconcept.md`)

---

### 🛠 Gameplay Logic & Node Designation System

#### Territory → Infrastructure Conversion
- Captured **territory nodes** are neutral until designated.
- Player must **invest resources** to convert a captured territory into:
  - A **Resource Node**
  - A **Base Node**
- NPC factions auto-convert territory based on their strategic needs.

#### Base Node Specializations
Once a base node is established, the player can designate it as:
- **Trader Outpost**
- **Research Facility**
- **Militia Post**
- **HQ**

#### Resource Node Specializations
Established resource nodes must be designated manually:
- **Scrap Metal Site**
- **Electronics Site**
- **Medicinal Herb Site**
- **Anomalous Artifact Site** (predefined)

#### PDA Integration
- **Right-click menu on the map** includes:
  - `Establish Node`
  - `Specialize Node`
  - `Upgrade Node` (future)
- Actions available only on player-owned smart terrains.
