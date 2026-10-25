# Clean Map

Adds two console commands for clearing corpses, gore actors, and decals from the current map. It recognizes common remains from vanilla Doom, Beautiful Doom, and Brutal Doom.

| Console command | Effect |
| --- | --- |
| `cleanmap` | Remove remains and decals created since the map was loaded; keep recognized map-start remains and decals. |
| `cleanmap_force` | Also remove recognized map-start remains and decals, and flush the engine's corpse queue. |

Type a command in the UZDoom console or bind it to a key. The mod has no CVars; there is no automatic cleanup. For compatibility with Beautiful Doom or Brutal Doom, load Clean Map after the gameplay mod.
