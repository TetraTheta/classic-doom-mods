class BHSBrutalDoom {
  static int ArmorAmount(Inventory item) {
    switch (item.GetClassName()) {
      case 'ArmorShard':
        return 2;
      case 'LightArmor':
        return 100;
      case 'HeavyArmor':
        return 200;
    }
    return 0;
  }
}
