# Classic Doom Mods

Small gameplay mods for UZDoom. Each folder is a separate mod; load only the ones you want. See each mod's README for its settings and any load order requirements.

| Mod | What it does |
| --- | --- |
| [Ammo Cap](ammo-cap/README.md) | Sets a configurable maximum for player ammo types. |
| [Better Health System](better-health-system/README.md) | Makes armor a shield that takes damage before health and raises both caps. |
| [Blank HUD](blank-hud/README.md) | Hides a gameplay or map WAD's bundled HUD so you can use another HUD. |
| [Build Engine Movement](build-engine-movement/README.md) | Adds faster movement, stronger air control, landing flinch, and death effects. |
| [Clean Map](clean-map/README.md) | Adds console commands to clear corpses, gore, and decals. |
| [Damage Dealt](damage-dealt/README.md) | Multiplies damage dealt by players. |
| [Damage Taken](damage-taken/README.md) | Multiplies damage received by players. |
| [Fast Weapons](fast-weapons/README.md) | Speeds up the primary fire of five Doom weapons. |
| [Fast Weapons: Beautiful Doom](fast-weapons-beautiful-doom/README.md) | Replaces Fast Weapons when playing with Beautiful Doom. |
| [Universal I-Frame](universal-iframe/README.md) | Adds a configurable invulnerability window after a player is hit. |

## Packaging and loading

On Windows, drag a mod folder onto `pack.cmd`. It uses `C:\Program Files\7-Zip-Zstandard\7z.exe` and writes a PK3 in this directory, replacing hyphens in the folder name with underscores. Load that PK3 in UZDoom with your chosen Doom IWAD. For example, `fast-weapons` becomes `fast_weapons.pk3`.

Load `fast_weapons_beautiful_doom.pk3` **instead of** `fast_weapons.pk3` when using Beautiful Doom. If using `damage_dealt.pk3` or `damage_taken.pk3` with `better_health_system.pk3`, load Better Health System after them so the damage adjustment is applied before its shield logic. The individual READMEs give the full instructions.
