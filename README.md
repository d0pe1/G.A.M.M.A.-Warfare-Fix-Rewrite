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

---

## Development Workflow

This repository maintains two script sets:

- `runtime files/` – original Warfare scripts shipped with Anomaly.
- `gamma_walo/` – our cleaned and extended version.

Run the **Analyzer** profile to review differences between these directories. After any script update execute the **DocGen** profile to refresh `docs/runtime_vs_gamma_walo.md` and `docs/api_map.md`.

> **Changelog:** every iteration must append a summary entry to `CHANGELOG.md`.
> Each script should begin with a comment block header describing its purpose and recent changes.
