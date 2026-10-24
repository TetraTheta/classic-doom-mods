class BHSArmor : BasicArmor {
  override void AbsorbDamage(int damage, Name damageType, out int newDamage, Actor inflictor, Actor source, int flags) {
    if (damage <= 0 || Amount <= 0) return;
    int absorbed = min(damage, Amount);
    Amount -= absorbed;
    newDamage = damage - absorbed;
    if (Amount == 0) ArmorType = 'None';
  }
}

class BHSShield : Inventory {
  Default {
    Inventory.MaxAmount 1;
    +INVENTORY.UNDROPPABLE + INVENTORY.UNTOSSABLE
  }

  override bool HandlePickup(Inventory item) {
    if (Owner == null) return false;
    let armor = BasicArmor(Owner.FindInventory('BHSArmor'));
    if (armor == null) return false;

    int amount = BHSBrutalDoom.ArmorAmount(item);
    if (amount == 0) amount = BHSBeautifulDoom.ArmorAmount(item);
    if (amount == 0) amount = BHSVanilla.ArmorAmount(item);
    if (amount == 0 && item is 'BasicArmorPickup') amount = BasicArmorPickup(item).GetSaveAmount();
    if (amount == 0 && item is 'BasicArmorBonus') amount = BasicArmorBonus(item).GetSaveAmount();
    if (amount <= 0) return false;
    if (armor.Amount >= 999999) return true;

    armor.Amount += min(amount, 999999 - armor.Amount);
    armor.MaxAmount = 999999;
    armor.SavePercent = 1.0;
    armor.Icon = item.Icon;
    armor.ArmorType = item.GetClassName();
    item.bPickupGood = true;
    return true;
  }

  override void ModifyDamage(int damage, Name damageType, out int newDamage, bool passive, Actor inflictor,
                             Actor source, int flags) {
    if (!passive || damage <= 0 || !(flags & DMG_NO_ARMOR) || (flags & DMG_NO_PROTECT)) return;
    if (damage >= TELEFRAG_DAMAGE) return;
    let armor = BasicArmor(Owner.FindInventory('BHSArmor'));
    if (armor == null || armor.Amount <= 0) return;
    int absorbed = min(damage, armor.Amount);
    armor.Amount -= absorbed;
    newDamage = damage - absorbed;
    if (armor.Amount == 0) armor.ArmorType = 'None';
  }
}

class BHSHandler : StaticEventHandler {
  private void MoveShieldLast(Actor pawn) {
    let shield = Inventory(pawn.FindInventory('BHSShield'));
    if (shield == null || shield.Inv == null) return;
    Inventory previous = null;
    for (Inventory item = pawn.Inv; item != shield; item = item.Inv) previous = item;
    if (previous == null)
      pawn.Inv = shield.Inv;
    else
      previous.Inv = shield.Inv;
    Inventory tail = pawn.Inv;
    while (tail.Inv != null) tail = tail.Inv;
    tail.Inv = shield;
    shield.Inv = null;
  }

  private void ConfigurePlayer(Actor pawn) {
    let playerPawn = PlayerPawn(pawn);
    if (playerPawn == null) return;
    playerPawn.MaxHealth = 999999;
    playerPawn.MaxPickupHealth = 999999;
    if (pawn.FindInventory('BHSShield') == null) pawn.GiveInventory('BHSShield', 1);
    // Passive damage modifiers must run before shield absorption.
    MoveShieldLast(pawn);
    let armor = BasicArmor(pawn.FindInventory('BHSArmor'));
    if (armor != null) {
      armor.MaxAmount = 999999;
      armor.Amount = min(armor.Amount, 999999);
    }
    if (pawn.health > 999999) {
      pawn.health = 999999;
      pawn.player.health = 999999;
    }
  }

  override void PlayerSpawned(PlayerEvent event) { ConfigurePlayer(players[event.PlayerNumber].mo); }

  override void WorldTick() {
    for (int index = 0; index < MAXPLAYERS; index++) {
      if (playeringame[index] && players[index].mo != null) ConfigurePlayer(players[index].mo);
    }
  }
}
