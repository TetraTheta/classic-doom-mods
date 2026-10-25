# Damage Dealt

Multiplies positive damage dealt by players. It does not change damage received by players; use [Damage Taken](../damage-taken/README.md) for that.

| Server CVar | Default | Effect |
| --- | ---: | --- |
| `ds_plr_dmg_mult` | `2.0` | Multiplier for outgoing player damage; the result is rounded to a whole damage point and cannot go below `0`. |

Set the CVar in the UZDoom console or your server configuration. If using [Better Health System](../better-health-system/README.md), load this mod before it so damage adjustment happens before the shield logic.
