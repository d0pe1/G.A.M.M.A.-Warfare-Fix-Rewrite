# Legendary Squad System

Squads gain experience through successful combat encounters. Once enough experience is gathered, they level up through several ranks culminating in **legendary** status.

```lua
local leg = require 'gamma_walo.gamedata.scripts.legendary_squad_system'
leg.add_experience('alpha', 120)
print(leg.get_rank('alpha')) -- seasoned
```
