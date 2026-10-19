class iframesHandler : EventHandler {
  override void WorldThingDamaged(WorldEvent e) {
    actor mo = e.thing;
    if (e.thing.Player && iframesDuration && !(e.thing.FindInventory("iframes")) && e.DamageSource &&
        e.DamageSource != e.thing)
      e.thing.A_GiveInventory("iframes");
  }
}

CLASS iframes : powerup {
  int DelayDamage;
  DEFAULT {
    Inventory.MaxAMount 1;
    +Inventory.ALWAYSPICKUP;
    Powerup.Color "None", 0.0;
  }

  override void InitEffect() {
    Super.InitEffect();
    effecttics = iframesDuration;
  }
  override void DoEffect() {
    Super.DoEffect();
    DelayDamage++;
  }
  override void ModifyDamage(int damage, Name damageType, out int newdamage, bool passive, Actor inflictor,
                             Actor source, int flags) {
    Switch(DamageType) {
    Default:
      if (DelayDamage > 1 && passive && source && source != owner) NewDamage = 0;
      break;
    }
  }
  override void AlterWeaponSprite(VisStyle vis, in out int changed) {
    if (EffectTics & 3) {
      vis.RenderStyle = STYLE_Translucent;
      vis.Alpha = 0.5;
    } else {
      vis.Alpha = 1.0;
    }
  }
}
