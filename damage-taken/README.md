# Damage Taken

Multiplies positive damage received by players. It does not change damage players deal; use [Damage Dealt](../damage-dealt/README.md) for that.

| Server CVar | Default | Effect |
| --- | ---: | --- |
| `ds_npc_dmg_mult` | `0.2` | Multiplier for incoming player damage; the result is rounded to a whole damage point and cannot go below `0`. Despite the name, this applies to incoming damage generally. |

Set the CVar in the UZDoom console or your server configuration. If using [Better Health System](../better-health-system/README.md), load this mod before it so the adjusted damage reaches the shield.
