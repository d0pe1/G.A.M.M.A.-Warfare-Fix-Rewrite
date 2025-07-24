# Diplomacy PDA Tab

Provides an in-game overview of faction relations and pending diplomacy requests.

The UI lists each faction pair with their current status and displays messages that require the player's attention.

## Example
```lua
local diplomacy = require 'gamma_walo.gamedata.scripts.diplomacy_system'
local ui = require 'gamma_walo.gamedata.scripts.ui_pda_diplomacy'

-- After relations are configured
local lines = ui.generate_status_list(diplomacy)
for _, l in ipairs(lines) do
    printf(l)
end
```
