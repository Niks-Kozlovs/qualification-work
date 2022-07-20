class InventoryItem {
  InventoryItem(
      {this.id,
      this.name,
      this.imageName,
      this.cost,
      this.type,
      this.level,
      this.description,
      this.isExpanded: false,
      this.isLoading: false,
      this.isOwned = false,
      this.isEquipped = false});

  int id;
  String name;
  String imageName;
  String description;
  int cost;
  String type;
  int level;
  bool isExpanded;
  bool isLoading;
  bool isOwned;
  bool isEquipped;
}