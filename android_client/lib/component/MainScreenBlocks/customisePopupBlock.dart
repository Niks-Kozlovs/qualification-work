import 'package:RunningApp/model/Inventory/InventoryItem.dart';
import 'package:RunningApp/repository/AppData.dart';
import 'package:flutter/material.dart';

class CustomisePopupBlock extends StatefulWidget {
  const CustomisePopupBlock({Key key}) : super(key: key);

  @override
  _CustomisePopupBlockState createState() => _CustomisePopupBlockState();
}

class _CustomisePopupBlockState extends State<CustomisePopupBlock> {
  //TODO: make widget stateless and move these two variables to AppData;
  bool _showOnlyOwned = false;
  String _filterType = 'All';
  List<InventoryItem> _items = <InventoryItem>[];
  AppData user;

  @override
  void initState() {
    super.initState();
    user = AppData(context);
    _items = user.userData.inventory.items;
  }

  List<DropdownMenuItem<String>> getDropDownCategories() {
    List<String> typeList = ['All'];
    typeList.addAll(user.userData.inventory.types);

    String capitalise(String s) {
      return s[0].toUpperCase() + s.substring(1).toLowerCase();
    }

    return typeList
        .map<DropdownMenuItem<String>>((type) => DropdownMenuItem<String>(
              value: type,
              child: Text(capitalise(type)),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Ink(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                DropdownButton<String>(
                    value: _filterType,
                    icon: Icon(Icons.arrow_drop_down),
                    items: getDropDownCategories(),
                    onChanged: _dropDownValueChanged),
                FlatButton.icon(
                  onPressed: _onOwnedPressed,
                  icon: Icon(_showOnlyOwned
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                  label: Text('Owned'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ExpansionPanelList(
                  expandedHeaderPadding: EdgeInsets.zero,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _items[index].isExpanded = !_items[index].isExpanded;
                    });
                  },
                  children: _items.map((InventoryItem item) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Text(
                                item.name,
                                textAlign: TextAlign.end,
                              )
                            ],
                          ),
                        );
                      },
                      isExpanded: item.isExpanded,
                      body: Container(
                        child: _getItemBody(item),
                      ),
                      canTapOnHeader: true,
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _dropDownValueChanged(String value) {
    updateList(value: value);
  }

  _onOwnedPressed() {
    updateList(onlyOwned: !_showOnlyOwned);
  }

  updateList({value, onlyOwned}) {
    if (value == null) {
      value = _filterType;
    }
    if (onlyOwned == null) {
      onlyOwned = _showOnlyOwned;
    }

    setState(() {
      _items = user.userData.inventory.items
          .where((InventoryItem item) =>
              (value == "All" || item.type == value) &&
              (item.isOwned || !onlyOwned))
          .toList();
      _filterType = value;
      _showOnlyOwned = onlyOwned;
    });
  }

  Widget _getItemBody(InventoryItem item) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Image(
            height: 100,
            image: AssetImage('img/character_images/${item.imageName}.png'),
          ),
        ),
        Text(item.description),
        Text('Cost: ${item.cost}'),
        Text('Level: ${item.level}'),
        RaisedButton(
            onPressed: () => _buyOrEquip(item.id), child: _getLabel(item))
      ],
    );
  }

  Widget _getLabel(InventoryItem item) {
    if (item.isLoading) {
      return CircularProgressIndicator();
    }

    if (item.isEquipped) {
      return Text('Unequip');
    }

    if (item.isOwned) {
      return Text('Equip');
    }

    return Text('Buy');
  }

  void _buyOrEquip(int itemId) async {
    int itemIndex = _items.indexWhere((item) => item.id == itemId);
    if (_items[itemIndex].isLoading) {
      return;
    }
    setState(() {
      _items[itemIndex].isLoading = true;
    });

    if (_items[itemIndex].isEquipped) {
      await unequipItem(itemIndex);
    } else if (_items[itemIndex].isOwned) {
      await equipItem(itemIndex);
    } else {
      await buyItem(itemIndex);
    }

    setState(() {
      _items[itemIndex].isLoading = false;
    });
  }

  unequipItem(int itemIndex) async {
    if (await user.unequipItem(_items[itemIndex].id)) {
      _items[itemIndex].isEquipped = false;
    } else {
      //TODO: Show Error
    }
  }

  buyItem(int itemIndex) async {
    if (await user.buyItem(_items[itemIndex].id, _items[itemIndex].cost)) {
      _items[itemIndex].isOwned = true;
    } else {
      //TODO: Show error
    }
  }

  equipItem(int itemIndex) async {
    if (await user.equipItem(_items[itemIndex].id)) {
      int oldItemIndex = _items.indexWhere(
          (item) => item.isEquipped && _items[itemIndex].type == item.type && _items[itemIndex].id != item.id);
      _items[itemIndex].isEquipped = true;
      if (oldItemIndex != -1) {
        _items[oldItemIndex].isEquipped = false;
      }
    } else {
      //TODO: Show error
    }
  }
}
