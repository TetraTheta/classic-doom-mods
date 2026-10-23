const DS_PISTOL_RATE = 2.0;
const DS_SHOTGUN_RATE = 2.0;
const DS_SUPER_SHOTGUN_RATE = 2.0;
const DS_ROCKET_LAUNCHER_RATE = 2.0;
const DS_CHAINGUN_RATE = 4.0;

class DSFastWeaponsBeautifulDoomHandler : StaticEventHandler {
  private bool fastFire[MAXPLAYERS];
  private State lastWeaponState[MAXPLAYERS];
  private Weapon acceleratedWeapon[MAXPLAYERS];
  private double extraTickCarry[MAXPLAYERS];

  private double GetFireRate(Weapon weapon) {
    name className = weapon.GetClassName();
    if (weapon is 'Pistol' || className == 'BD_Pistol') return DS_PISTOL_RATE;
    if (weapon is 'Shotgun' || className == 'BD_Shotgun') return DS_SHOTGUN_RATE;
    if (weapon is 'SuperShotgun' || className == 'BD_SuperShotgun') return DS_SUPER_SHOTGUN_RATE;
    if (weapon is 'RocketLauncher' || className == 'BD_RocketLauncher') return DS_ROCKET_LAUNCHER_RATE;
    if (weapon is 'Chaingun' || className == 'BD_Chaingun') return DS_CHAINGUN_RATE;
    return 0.0;
  }

  private bool InFireSequence(Weapon weapon, State state, StateLabel label) {
    State start = weapon.FindState(label, true);
    return start != null && Actor.InStateSequence(state, start);
  }

  private bool IsBeautifulDoomFireState(Weapon weapon, State state) {
    return InFireSequence(weapon, state, 'Fire') ||
      InFireSequence(weapon, state, 'Fire.Enhanced') ||
      InFireSequence(weapon, state, 'Fire.Modern') ||
      InFireSequence(weapon, state, 'FireSights') ||
      InFireSequence(weapon, state, 'Fire0.Modern') ||
      InFireSequence(weapon, state, 'Fire1.Modern') ||
      InFireSequence(weapon, state, 'Fire2.Modern') ||
      InFireSequence(weapon, state, 'Fire3.Modern');
  }

  override void WorldTick() {
    for (int playerNumber = 0; playerNumber < MAXPLAYERS; playerNumber++) {
      if (!playeringame[playerNumber]) {
        fastFire[playerNumber] = false;
        lastWeaponState[playerNumber] = null;
        acceleratedWeapon[playerNumber] = null;
        extraTickCarry[playerNumber] = 0.0;
        continue;
      }
      Weapon weapon = Weapon(players[playerNumber].readyWeapon);
      double fireRate = weapon == null ? 0.0 : GetFireRate(weapon);
      PSprite weaponSprite = players[playerNumber].FindPSprite(PSP_WEAPON);
      if (fireRate <= 0.0 || weaponSprite == null || weaponSprite.curState == null) {
        fastFire[playerNumber] = false;
        lastWeaponState[playerNumber] = null;
        acceleratedWeapon[playerNumber] = null;
        extraTickCarry[playerNumber] = 0.0;
        continue;
      }
      State fireState = weapon.FindState("Fire");
      State readyState = weapon.FindState("Ready");
      if (fireState != null && Actor.InStateSequence(weaponSprite.curState, fireState)) {
        fastFire[playerNumber] = true;
      } else if (readyState != null && Actor.InStateSequence(weaponSprite.curState, readyState)) {
        fastFire[playerNumber] = false;
      }
      name className = weapon.GetClassName();
      bool beautifulDoomWeapon = className == 'BD_Pistol' || className == 'BD_Shotgun' ||
        className == 'BD_SuperShotgun' || className == 'BD_RocketLauncher' ||
        className == 'BD_Chaingun';
      if (beautifulDoomWeapon && fireRate > 1.0) {
        if (acceleratedWeapon[playerNumber] != weapon) extraTickCarry[playerNumber] = 0.0;
        acceleratedWeapon[playerNumber] = weapon;
        if (IsBeautifulDoomFireState(weapon, weaponSprite.curState)) {
          extraTickCarry[playerNumber] += fireRate - 1.0;
          int extraTicks = floor(extraTickCarry[playerNumber]);
          extraTickCarry[playerNumber] -= extraTicks;
          for (int tick = 0; tick < extraTicks; tick++) {
            if (players[playerNumber].readyWeapon != weapon ||
                players[playerNumber].FindPSprite(PSP_WEAPON) != weaponSprite ||
                weaponSprite.curState == null ||
                !IsBeautifulDoomFireState(weapon, weaponSprite.curState)) break;
            if (weaponSprite.tics > 1) {
              weaponSprite.tics--;
            } else if (weaponSprite.tics == 1) {
              weaponSprite.SetState(weaponSprite.curState.NextState);
            } else {
              break;
            }
          }
        }
      } else {
        acceleratedWeapon[playerNumber] = null;
        extraTickCarry[playerNumber] = 0.0;
        if (fastFire[playerNumber] && weaponSprite.curState != lastWeaponState[playerNumber])
          weaponSprite.tics = max(1, round(weaponSprite.tics / fireRate));
      }
      lastWeaponState[playerNumber] = weaponSprite.curState;
    }
  }
}
