import 'package:RunningApp/helper/constants.dart';
import 'package:RunningApp/model/Inventory/InventoryItem.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final InventoryItem item;

  const CharacterItem({
    @required this.item,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _getTop(),
      child: Image(
        height: _getHeight(),
        image: AssetImage('img/character_images/${item.imageName}.png'),
      ),
    );
  }

  double _getTop() {
    switch (item.type) {
      case EYES:
        return 60;
        break;
      case MOUTH:
        return 100;
        break;
      case NOSE:
        return 75;
        break;
      case SHIRT:
        return 155;
        break;
      case PANTS:
        return 250;
        break;
    }

    return 0;
  }

  double _getHeight() {
    switch (item.type) {
      case EYES:
        return 30;
        break;
      case MOUTH:
        return 40;
        break;
      case NOSE:
        return 40;
        break;
      case SHIRT:
        return 110;
        break;
      case PANTS:
        return 100;
        break;
    }

    return 0;
  }
}