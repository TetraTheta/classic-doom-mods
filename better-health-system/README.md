# Better Health System

This mod turns armor into a shield in Doom II on UZDoom 5.0.3. Health and armor can each reach `999999`.

## Installation and load order

Pass the `better-health-system` folder to the repository's root `pack.cmd` to create `better_health_system.pk3` in the root directory. Select Doom II as the IWAD and load the mods in this order:

1. Beautiful Doom **or** Brutal Doom (if used)
2. `damage-dealt` (if used)
3. `damage-taken` (if used)
4. `better_health_system.pk3`

The full order is **Doom II → gameplay mod → `damage-dealt` → `damage-taken` → Better Health System**. Load Better Health System last so it can replace the armor class used by the preceding mods with its shield class. The default `damage-taken` multiplier of `0.2` is applied before damage drains the shield. The default `damage-dealt` multiplier of `2.0` applies to damage dealt by the player. Both damage multiplier mods are optional.

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
- Beautiful Doom was tested with the supplied `beautiful-doom.pk3` (SHA-256 `B323DCD3E0512DCF1DA7684DE8E720772B768C468AB078189FD2374DBBB1951E`). Item sprites, sounds, and Berserk's additional effects are preserved.
- Brutal Doom was tested with `brutal22test6.pk3` listed on the creator's [v22 Beta Test 6 download page](https://www.moddb.com/mods/brutal-doom/downloads/brutal-doom-v22-beta-test). The tested PK3 has SHA-256 `D897FB2F0E2332C1E3886169DD49AB626D75962261F2F7522A553A94661A6FC7`. Its health and armor bonuses retain their original +2 values.
- Loading Beautiful Doom and Brutal Doom together, or using other mods with independent pickup or damage systems, has not been tested. Recheck compatibility when either supported gameplay mod changes version.
- GZDoom 4.14.2 cannot load this mod because it lacks `PlayerPawn.MaxPickupHealth`. The `damage-dealt` and `damage-taken` mods above also require ZScript 5.0.0, so use UZDoom 5.0.3 for this combination.

The reproduction probe's ZScript is in `tests/better-health-system-probe`. Load the probe PK3 after Better Health System and start MAP01 to see health and armor results prefixed with `BHS PROBE` in the console.
