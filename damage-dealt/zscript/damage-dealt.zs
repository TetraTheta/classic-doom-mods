class DSDamageDealt : Inventory {
  override void ModifyDamage(int damage, Name damageType, out int newDamage, bool passive, Actor inflictor, Actor source, int flags, double angle) {
    if (!passive && damage > 0) newDamage = max(0, round(damage * CVar.FindCVar("ds_plr_dmg_mult").GetFloat()));
  }
}

class DSDamageDealtHandler : StaticEventHandler {
  override void PlayerSpawned(PlayerEvent event) {
    players[event.PlayerNumber].mo.GiveInventory("DSDamageDealt", 1);
  }
}
