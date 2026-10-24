class BHSVanilla {
  static int ArmorAmount(Inventory item) {
    switch (item.GetClassName()) {
      case 'ArmorBonus':
        return 1;
      case 'GreenArmor':
        return 100;
      case 'BlueArmor':
      case 'BlueArmorForMegasphere':
        return 200;
    }
    return 0;
  }
}
