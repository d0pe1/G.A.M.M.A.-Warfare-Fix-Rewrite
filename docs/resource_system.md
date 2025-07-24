# Resource System

This module introduces dynamic resources used by factions to upgrade equipment and build infrastructure.

## Resource Types
- **scrap** – general parts and armor plates
- **herbs** – medical plants for healing items
- **electronics** – radio components and weapon mods
- **artifacts** – rare upgrade materials

## Usage
```lua
local resource = require 'gamma_walo.gamedata.scripts.resource_system'
resource.capture_node('agro_scrap_pile', 'duty', 'scrap', 3)
print(resource.get_resource('duty', 'scrap')) -- 3
```

Factions spend these resources through `placeable_system` or other gameplay logic.
