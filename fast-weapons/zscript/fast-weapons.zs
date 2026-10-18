const DS_PISTOL_RATE = 2.0;
const DS_SHOTGUN_RATE = 2.0;
const DS_SUPER_SHOTGUN_RATE = 2.0;
const DS_ROCKET_LAUNCHER_RATE = 2.0;
const DS_CHAINGUN_RATE = 2.0;

class DSFastPistol : Pistol replaces Pistol {
  Default {
    Weapon.SlotNumber 2;
  }

  States {
  Fire:
    PISG A max(1, round(4.0 / DS_PISTOL_RATE));
    PISG B max(1, round(10.0 / DS_PISTOL_RATE) - round(4.0 / DS_PISTOL_RATE)) A_FirePistol;
    PISG C max(1, round(14.0 / DS_PISTOL_RATE) - round(10.0 / DS_PISTOL_RATE));
    PISG B max(1, round(19.0 / DS_PISTOL_RATE) - round(14.0 / DS_PISTOL_RATE)) A_ReFire;
    Goto Ready;
  }
}

class DSFastShotgun : Shotgun replaces Shotgun {
  Default {
    Weapon.SlotNumber 3;
  }

  States {
  Fire:
    SHTG A max(1, round(3.0 / DS_SHOTGUN_RATE));
    SHTG A max(1, round(10.0 / DS_SHOTGUN_RATE) - round(3.0 / DS_SHOTGUN_RATE)) A_FireShotgun;
    SHTG B max(1, round(15.0 / DS_SHOTGUN_RATE) - round(10.0 / DS_SHOTGUN_RATE));
    SHTG C max(1, round(20.0 / DS_SHOTGUN_RATE) - round(15.0 / DS_SHOTGUN_RATE));
    SHTG D max(1, round(24.0 / DS_SHOTGUN_RATE) - round(20.0 / DS_SHOTGUN_RATE));
    SHTG C max(1, round(29.0 / DS_SHOTGUN_RATE) - round(24.0 / DS_SHOTGUN_RATE));
    SHTG B max(1, round(34.0 / DS_SHOTGUN_RATE) - round(29.0 / DS_SHOTGUN_RATE));
    SHTG A max(1, round(37.0 / DS_SHOTGUN_RATE) - round(34.0 / DS_SHOTGUN_RATE));
    SHTG A max(1, round(44.0 / DS_SHOTGUN_RATE) - round(37.0 / DS_SHOTGUN_RATE)) A_ReFire;
    Goto Ready;
  }
}

class DSFastSuperShotgun : SuperShotgun replaces SuperShotgun {
  Default {
    Weapon.SlotNumber 3;
  }

  States {
  Fire:
    SHT2 A max(1, round(3.0 / DS_SUPER_SHOTGUN_RATE));
    SHT2 A max(1, round(10.0 / DS_SUPER_SHOTGUN_RATE) - round(3.0 / DS_SUPER_SHOTGUN_RATE)) A_FireShotgun2;
    SHT2 B max(1, round(17.0 / DS_SUPER_SHOTGUN_RATE) - round(10.0 / DS_SUPER_SHOTGUN_RATE));
    SHT2 C max(1, round(24.0 / DS_SUPER_SHOTGUN_RATE) - round(17.0 / DS_SUPER_SHOTGUN_RATE)) A_CheckReload;
    SHT2 D max(1, round(31.0 / DS_SUPER_SHOTGUN_RATE) - round(24.0 / DS_SUPER_SHOTGUN_RATE)) A_OpenShotgun2;
    SHT2 E max(1, round(38.0 / DS_SUPER_SHOTGUN_RATE) - round(31.0 / DS_SUPER_SHOTGUN_RATE));
    SHT2 F max(1, round(45.0 / DS_SUPER_SHOTGUN_RATE) - round(38.0 / DS_SUPER_SHOTGUN_RATE)) A_LoadShotgun2;
    SHT2 G max(1, round(51.0 / DS_SUPER_SHOTGUN_RATE) - round(45.0 / DS_SUPER_SHOTGUN_RATE));
    SHT2 H max(1, round(57.0 / DS_SUPER_SHOTGUN_RATE) - round(51.0 / DS_SUPER_SHOTGUN_RATE)) A_CloseShotgun2;
    SHT2 A max(1, round(62.0 / DS_SUPER_SHOTGUN_RATE) - round(57.0 / DS_SUPER_SHOTGUN_RATE)) A_ReFire;
    Goto Ready;
  }
}

class DSFastRocketLauncher : RocketLauncher replaces RocketLauncher {
  Default {
    Weapon.SlotNumber 5;
  }

  States {
  Fire:
    MISG B max(1, round(8.0 / DS_ROCKET_LAUNCHER_RATE)) A_GunFlash;
    MISG B max(1, round(20.0 / DS_ROCKET_LAUNCHER_RATE) - round(8.0 / DS_ROCKET_LAUNCHER_RATE)) A_FireMissile;
    MISG B 0 A_ReFire;
    Goto Ready;
  }
}

class DSFastChaingun : Chaingun replaces Chaingun {
  Default {
    Weapon.SlotNumber 4;
  }

  States {
  Fire:
    CHGG A max(1, round(4.0 / DS_CHAINGUN_RATE)) A_FireCGun;
    CHGG B max(1, round(8.0 / DS_CHAINGUN_RATE) - round(4.0 / DS_CHAINGUN_RATE)) A_FireCGun;
    CHGG B 0 A_ReFire;
    Goto Ready;
  }
}
