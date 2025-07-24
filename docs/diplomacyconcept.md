# 📘 Diplomacy and Node Logic Concept

## 🔄 Node Designation Flow

1. Capture a Territory Node
2. Invest to Establish:
   - Base → Trader, Research, Militia, HQ
   - Resource → Scrap, Electronics, Herbs
3. Artifact Nodes = predefined (anomalous zones)

## 🧠 PDA Integration

- Accessed via **map right-click menu**:
  - NOT in the Diplomacy tab
  - Context-aware:
    - `Establish Node`
    - `Specialize Node`
    - `Upgrade Node`

Diplomacy tab = for faction relations only.

🤝 Diplomacy System Concept

The Diplomacy system in the G.A.M.M.A. Warfare Rewrite introduces dynamic, persistent, and faction-specific relations that drive alliances, wars, negotiations, and betrayals. It expands faction behavior beyond basic hostility, making diplomacy a strategic and emergent tool for both AI factions and the player.

🎯 Goals

Introduce dynamic faction relationships (friend, enemy, neutral)

Enable player-driven and AI-driven diplomatic events

Support alliances, tribute systems, joint attacks, betrayals

Reflect faction philosophies and personalities

Visualize diplomacy via a new PDA UI tab

🧠 System Overview

📦 Core Components

diplomacy_system.script – Core data structures, logic, and hooks

ui_pda_diplomacy.script – Visual interface integration

faction_philosophy.script – Defines AI behavior priorities, aggression, and diplomacy

resource_system.script – Enables diplomatic bartering with resources

🏛 Faction Relations

Each faction has a diplomatic_state with every other faction:

friendly – Can form alliances, trade, and share intelligence

neutral – No active hostility or cooperation

hostile – Will engage in open conflict and block diplomacy

These relations can change dynamically through events and scripted behavior.

🧩 Player Diplomacy

📞 Interaction Interface

Accessible via:

PDA diplomacy tab

Right-click map menu on faction nodes

🧰 Player Options

Offer alliance / request peace

Trade resources or node access

Propose joint attacks

Request garrison training (militia node usage)

Bribe or demand tribute

🔄 NPC Diplomacy Events

AI factions can:

Propose alliances or joint operations

Demand tributes or make offers

Break pacts when betrayed or outmatched

Send warnings before war declarations

🧬 System Hooks

Diplomacy-Driven AI Logic

AI factions act based on faction_philosophy values

Low diplomacy factions will rarely initiate pacts

High aggression factions will backstab more easily

Shared enemies and resource balance influence diplomatic behavior

Combat Hooks

Allied factions share map vision

Joint attacks appear as coordinated push events

Betrayals instantly revert to full hostilities

Resource Ties

Factions may barter production capacity or temporary resource shares

Player may exchange militia training or artifact access for favors

🧪 Testing

Test symmetrical state changes (duty marks freedom hostile → both update)

Ensure fallback states for missing factions

Simulate player diplomatic flows and validate response consistency

🔮 Future Ideas

Reputation system for player's diplomatic reliability

Diplomatic cooldowns after broken pacts

Influence system to coerce factions indirectly

Event chain triggers based on alliance webs

Let factions scheme, ally, betray, and evolve — just like the Zone itself.
