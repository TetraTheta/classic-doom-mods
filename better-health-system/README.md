# Better Health System

This mod turns armor into a shield in Doom II on UZDoom 5.0.3. Health and armor can each reach `999999`.

## Installation and load order

Pass the `better-health-system` folder to the repository's root `pack.cmd` to create `better_health_system.pk3` in the root directory. Select Doom II as the IWAD and load the mods in this order:

1. Beautiful Doom **or** Brutal Doom (if used)
2. `damage-dealt` (if used)
3. `damage-taken` (if used)
4. `better_health_system.pk3`

The full order is **Doom II → gameplay mod → `damage-dealt` → `damage-taken` → Better Health System**. Load Better Health System after either damage mod so damage modifiers run before its shield logic. With the default settings, `damage-taken` multiplies incoming damage by `0.2` before the shield absorbs it; `damage-dealt` multiplies the player's outgoing damage by `2.0`. Both damage mods are optional, and their order relative to each other does not matter.

Better Health System has no CVars or in-game settings. Its health and armor caps are fixed at `999999`.

## Rules

| Item | Health | Armor |
| --- | ---: | ---: |
| Health bonus | +1 (+2 in Brutal Doom) | — |
| Stimpack | +10 | — |
| Medikit | +25 | — |
| Supercharge/Soulsphere | +100 | — |
| Berserk | +100 | — |
| Armor bonus | — | +1 (+2 in Brutal Doom) |
| Green armor | — | +100 |
| Megaarmor/blue armor | — | +200 |
| Megasphere | +200 | +200 |

Pickups add to the current values, capped at `999999`. When armor is available, normal damage, drowning, and armor-piercing attacks drain armor first; only the excess reduces health. Telefrags and forced deaths that bypass the engine's protection logic retain their original behavior. The in-game HUD is unchanged, so large values may be clipped.

## Compatibility

- Supports vanilla Doom II and standard `Health` and `BasicArmor` inventory items.
- GZDoom 4.14.2 cannot load this mod because it lacks `PlayerPawn.MaxPickupHealth`. The `damage-dealt` and `damage-taken` mods above also require ZScript 5.0.0, so use UZDoom 5.0.3 for this combination.
