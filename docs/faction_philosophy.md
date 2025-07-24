# Faction Philosophy System

This module defines AI personalities for each faction in Warfare. Profiles
influence node designation, resource goals and diplomatic behavior.

```lua
local phil = require 'gamma_walo.gamedata.scripts.faction_philosophy'
print(phil.get_faction_aggression('duty')) -- 0.9
```

## Profiles

- **Duty** – favors weapons and armor, shuns herbs. Highly aggressive with
  limited diplomacy.
- **Freedom** – values herbs and electronics. Balanced aggression and diplomacy.
- **Monolith** – relentless zealots ignoring science and medicine. Max aggression
  and minimal diplomacy.
- **Ecologists** – focus on science and research resources. Pacifistic and open
  to diplomacy.
- **Clear Sky** – mixes science and armor priorities. Generally cooperative.
- **Mercenaries** – pursue profit via weapons and tech. Aggressive negotiators.
- **Bandits** – prioritize loot and artifacts, ignoring scientific needs.
- **Loners (Stalkers)** – adaptable scavengers with average aggression.
- **Renegades** – rough raiders ignoring high-tech gear.
- **Sin** – fanatic artifact hunters hostile to diplomacy.
- **UNISG** – elite operatives seeking scientific artifacts.
