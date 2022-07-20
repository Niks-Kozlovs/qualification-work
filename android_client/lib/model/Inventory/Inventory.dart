import 'InventoryItem.dart';

class Inventory {
  List<InventoryItem> items;
  List<String> types = [];

  Inventory(allItems, boughtItems, equippedItems){
    items = allItems.map<InventoryItem>((item){
      var equippedItem = equippedItems.any((eqippedItem) => item["ID"] == eqippedItem);
      var ownedItem = boughtItems.any((ownedItem) => item["ID"] == ownedItem);
      return InventoryItem(id: int.tryParse(item["ID"]), name: item["name"],description: item["description"], imageName: item["image_name"], cost: item["price"], type: item["type"], level: item["level"], isEquipped: equippedItem, isOwned: ownedItem || item["cost"] == 0);
    }).toList();
    addTypes();
  }

  void addTypes() {
    items.forEach((element) {
      if (types.every((category) => element.type != category)) {
        types.add(element.type);
      }
    });
  }

  void equipItem(int id) {
    int itemIndex = items.indexWhere((item) => item.id == id);
    items[itemIndex].isEquipped = true;
    int oldItemIndex = items.indexWhere((item) => item.isEquipped && items[itemIndex].type == item.type);
    if (oldItemIndex != null) {
      items[oldItemIndex].isEquipped = false;
    }
  }

  void unequipItem(int id) {
    int itemIndex = items.indexWhere((item) => item.id == id);
    items[itemIndex].isEquipped = false;
  }

  void buyItem(int id) {
    int itemIndex = items.indexWhere((item) => item.id == id);
    items[itemIndex].isOwned = true;
  }
}