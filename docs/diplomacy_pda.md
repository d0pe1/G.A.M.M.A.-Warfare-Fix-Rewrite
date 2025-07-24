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

### 🧠 Node Conversion & Specialization Flow

1. **Capture a Territory Node** (Neutral by default)
2. **Invest to Establish** as:
   - Base → Then specialize: Trader / Militia / Research / HQ
   - Resource → Then specialize: Scrap / Electronics / Herbs
3. **Artifact Nodes** are predefined in anomaly zones and not assignable
4. **Factions auto-assign nodes**, player must invest manually
5. **Upgrades** improve yield or squad effect (future)
