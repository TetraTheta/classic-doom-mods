const DS_PISTOL_RATE = 2.0;
const DS_SHOTGUN_RATE = 2.0;
const DS_SUPER_SHOTGUN_RATE = 4.0;
const DS_ROCKET_LAUNCHER_RATE = 2.0;
const DS_CHAINGUN_RATE = 4.0;

class DSFastWeaponsHandler : StaticEventHandler {
  private bool fastFire[MAXPLAYERS];
  private State lastWeaponState[MAXPLAYERS];

  private double GetFireRate(Weapon weapon) {
    name className = weapon.GetClassName();
    if (weapon is 'Pistol' || className == 'BD_Pistol') return DS_PISTOL_RATE;
    if (weapon is 'Shotgun' || className == 'BD_Shotgun') return DS_SHOTGUN_RATE;
    if (weapon is 'SuperShotgun' || className == 'BD_SuperShotgun') return DS_SUPER_SHOTGUN_RATE;
    if (weapon is 'RocketLauncher' || className == 'BD_RocketLauncher') return DS_ROCKET_LAUNCHER_RATE;
    if (weapon is 'Chaingun' || className == 'BD_Chaingun') return DS_CHAINGUN_RATE;
    return 0.0;
  }

  override void WorldTick() {
    for (int playerNumber = 0; playerNumber < MAXPLAYERS; playerNumber++) {
      if (!playeringame[playerNumber]) continue;
      Weapon weapon = Weapon(players[playerNumber].readyWeapon);
      double fireRate = weapon == null ? 0.0 : GetFireRate(weapon);
      PSprite weaponSprite = players[playerNumber].FindPSprite(PSP_WEAPON);
      if (fireRate <= 0.0 || weaponSprite == null || weaponSprite.curState == null) {
        fastFire[playerNumber] = false;
        lastWeaponState[playerNumber] = null;
        continue;
      }
      State fireState = weapon.FindState("Fire");
      State readyState = weapon.FindState("Ready");
      if (fireState != null && Actor.InStateSequence(weaponSprite.curState, fireState)) {
        fastFire[playerNumber] = true;
      } else if (readyState != null && Actor.InStateSequence(weaponSprite.curState, readyState)) {
        fastFire[playerNumber] = false;
      }
      if (fastFire[playerNumber] && weaponSprite.curState != lastWeaponState[playerNumber])
        weaponSprite.tics = max(1, round(weaponSprite.tics / fireRate));
      lastWeaponState[playerNumber] = weaponSprite.curState;
    }
  }
}
