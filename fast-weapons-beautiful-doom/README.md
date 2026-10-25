# Fast Weapons: Beautiful Doom

Use this dedicated mod when playing with Beautiful Doom. Load `fast_weapons_beautiful_doom.pk3` after Beautiful Doom **instead of** `fast_weapons.pk3`; do not load both Fast Weapons variants. Keep `sv_fastweapons` at `0`.

There are no CVars or in-game settings. The rates below are constants in `zscript/fast-weapons-beautiful-doom.zs`; changing them requires rebuilding the PK3.

| Weapon | Default rate |
| --- | ---: |
| Pistol | `2.0` |
| Shotgun | `2.0` |
| Super shotgun | `2.0` |
| Rocket launcher | `2.0` |
| Chaingun | `4.0` |

The five supported Beautiful Doom weapons have faster primary fire. Reloading, selecting, deselecting, and alternate fire retain their normal timing. Vanilla Doom weapons also receive the firing speed change. This implementation targets Beautiful Doom 2023.09.01; check behavior again after changing Beautiful Doom versions.
