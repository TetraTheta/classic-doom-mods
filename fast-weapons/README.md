# Fast Weapons

Shortens primary firing states for the pistol, shotgun, super shotgun, rocket launcher, and chaingun. Other weapons are unchanged. This mod changes firing animation timing rather than the engine's `sv_fastweapons` setting; keep `sv_fastweapons` at `0`.

There are no CVars or in-game settings. The rates below are constants in `zscript/fast-weapons.zs`; changing them requires rebuilding the PK3.

| Weapon | Default rate |
| --- | ---: |
| Pistol | `2.0` |
| Shotgun | `2.0` |
| Super shotgun | `4.0` |
| Rocket launcher | `2.0` |
| Chaingun | `4.0` |

For Beautiful Doom, use [Fast Weapons: Beautiful Doom](../fast-weapons-beautiful-doom/README.md) **instead of** this mod. Load that dedicated version after Beautiful Doom.
