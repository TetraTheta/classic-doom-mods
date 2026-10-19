class DSAmmoCapHandler : StaticEventHandler {
  private void InitializeAmmo(Actor playerPawn) {
    int ammoMax = max(0, CVar.FindCVar("ds_ammo_max").GetInt());
    uint classCount = AllActorClasses.Size();
    for (uint index = 0; index < classCount; index++) {
      let ammoType = (class<Ammo>)(AllActorClasses[index]);
      if (ammoType == null || GetDefaultByType(ammoType).GetParentAmmo() != ammoType) continue;
      let ammo = Ammo(playerPawn.FindInventory(ammoType));
      if (ammo == null) {
        ammo = Ammo(Actor.Spawn(ammoType));
        if (ammo == null) continue;
        ammo.Amount = 0;
        ammo.AttachToOwner(playerPawn);
      }
      ammo.MaxAmount = ammoMax;
    }
  }
  override void PlayerSpawned(PlayerEvent event) {
    if (players[event.PlayerNumber].mo != null) InitializeAmmo(players[event.PlayerNumber].mo);
  }
  override void WorldTick() {
    int ammoMax = max(0, CVar.FindCVar("ds_ammo_max").GetInt());
    for (int playerNumber = 0; playerNumber < MAXPLAYERS; playerNumber++) {
      if (!playeringame[playerNumber] || players[playerNumber].mo == null) continue;
      for (Inventory item = players[playerNumber].mo.Inv; item != null; item = item.Inv) {
        if (item is "Ammo") item.MaxAmount = ammoMax;
      }
    }
  }
}
