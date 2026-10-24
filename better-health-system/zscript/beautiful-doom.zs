class BHSBeautifulDoom {
  static int ArmorAmount(Inventory item) {
    switch (item.GetClassName()) {
      case 'BD_ArmorBonus':
        return 1;
      case 'BD_GreenArmor':
        return 100;
      case 'BD_BlueArmor':
        return 200;
    }
    return 0;
  }
}
