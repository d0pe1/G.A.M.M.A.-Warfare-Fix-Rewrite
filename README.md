# ☢️ G.A.M.M.A. Warfare Fix & Rewrite Project

> Turning STALKER: Anomaly’s notoriously unstable Warfare mode into something *actually playable*.

...

## 🎯 "Warfare Evolved" – Gameplay Expansion Concept

(See full design notes in `docs`)

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

- `runtime files/` – script files as the engine would currently (in the default gamma modpack) would load at runtime = is status of gamefiles pre our modding attempt under gamma_walo.
- `gamma_walo/` – our cleaned and extended version we are trying to build for the GAMMA Modpack, should hook up new system we describe while not breaking compatibility to all the non modified gamma baseline files as found under "runtime files".
- `old_walo` – Vintars Clean Warfare A-Life Overhaul Mod files for referrence (link : https://www.moddb.com/mods/stalker-anomaly/addons/warfare-alife-overhaul)
- `gammas patch` – Fix Attempts by the GAMMA TEAM for reference, as delivered with the Modpack

Run the **Analyzer** profile to review differences between these directories. After any script update execute the **DocGen** profile to refresh `docs/runtime_vs_gamma_walo.md` and `docs/api_map.md`.

> **Changelog:** every iteration must append a summary entry to `CHANGELOG.md`.
> Each script should begin with a comment block header describing its purpose and recent changes.
