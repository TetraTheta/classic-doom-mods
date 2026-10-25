# Build Engine Movement

Adds faster movement and stronger air control, with optional landing camera flinch, weapon sprite panning, and death effects. The mod includes exceptions for ice, frozen players, Ashes 2063 vehicles, and some Wool Ball movement states.

Open **Options → Build Movement Options** to change the main settings. Advanced settings are in its **Advanced Options** submenu. All CVars below are user settings.

| CVar | Default | Effect |
| --- | ---: | --- |
| `cl_buildmove` | `true` | Enable faster Build style movement. |
| `cl_newairmove` | `true` | Enable stronger air control. |
| `cl_buildmove_speed` | `1.9` | Movement speed multiplier. |
| `cl_newairmove_amount` | `0.64` | Air control amount. |
| `cl_noflinch_lowgrav` | `true` | Suppress landing flinch in low gravity. |
| `cl_cam_flinch` | `true` | Enable landing camera flinch. |
| `cl_flinch_threshold` | `8` | Falling time threshold for flinch. |
| `cl_cam_flinch_amount` | `10` | Camera pitch change on landing. |
| `cl_flinch_duration` | `10` | Flinch duration in ticks. |
| `cl_weapon_panning` | `true` | Pan the weapon sprite during a landing flinch. |
| `cl_wpn_panning_amount` | `2.0` | Weapon panning amount. |
| `cl_flinch_slowdown` | `true` | Slow movement briefly during a landing flinch. |
| `cl_roll_death` | `true` | Randomly roll the view on death. |
| `cl_death_flash` | `true` | Keep a red screen tint on death. |
| `cl_always_squat` | `true` | Apply the mod's small jump-height adjustment. Console only. |

No special load order is required.
