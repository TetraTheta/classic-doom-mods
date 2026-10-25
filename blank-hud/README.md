# Blank HUD

Use Blank HUD when a gameplay WAD or map WAD includes its own HUD and you do not want to use it. Blank HUD replaces that HUD with empty status bar layouts, including normal play, fullscreen view, the automap, and inventory views. It does not change gameplay.

## Load order

Load the files in this order:

1. Doom or Doom II IWAD
2. Gameplay or map WAD that provides a HUD
3. `blank_hud.pk3`
4. Your preferred custom HUD mod, if any

Load Blank HUD after the WAD whose HUD you want to hide. Load a replacement HUD after Blank HUD so it can provide the visible HUD. Without a replacement, HUD information remains hidden.

Blank HUD has no CVars or settings. It is always enabled when loaded.
