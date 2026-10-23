# Fast Weapons: Beautiful Doom

Load this PK3 after Beautiful Doom **instead of** `fast_weapons.pk3`. It is a standalone replacement for Fast Weapons, not an add-on to it. Keep `sv_fastweapons` at `0`.

The `DS_*_RATE` constants in `zscript/fast-weapons-beautiful-doom.zs` have the same names and initial values as Fast Weapons. They are compile-time constants, not CVars. Change a value and rebuild the PK3 to tune it.

The five supported Beautiful Doom weapons use the same rate-based advancement of their primary firing states. State actions such as shooting, casing ejection, ammo checks, and refire still run. Fractional rates accumulate across ticks. Reloading, selecting, deselecting, and alternate fire retain their normal timing. Vanilla Doom weapons retain Fast Weapons' original state-duration scaling. This implementation targets Beautiful Doom 2023.09.01; check behavior again after changing Beautiful Doom versions.
