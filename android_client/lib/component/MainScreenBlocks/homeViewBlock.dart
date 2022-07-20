import 'package:RunningApp/component/MainScreenBlocks/CharacterItem.dart';
import 'package:RunningApp/model/Inventory/InventoryItem.dart';
import 'package:RunningApp/presentation/custom_icons_icons.dart';
import 'package:RunningApp/repository/AppData.dart';
import 'package:flutter/material.dart';
import 'package:RunningApp/component/popup.dart';

import 'achievementsPopupBlock.dart';
import 'challengesPopupBlock.dart';
import 'customisePopupBlock.dart';

class HomeViewBlock extends StatelessWidget {
  const HomeViewBlock({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appData = AppData(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          //TODO: Change image based on weather
          image: ExactAssetImage('img/spring-scene.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                //Normal shop will be combined with customize menu. Might be useful for a different type of shop
                //Buying coins for real money or some kind of premium pass
                // FlatButton.icon(
                //   icon: Icon(Icons.shopping_cart),
                //   label: Text('SHOP'),
                //   onPressed: () => _showDialog(context),
                // ),
                FlatButton.icon(
                  icon: Icon(Icons.mode_edit),
                  label: Text('CUSTOMISE'),
                  onPressed: () => showPopup(context, CustomisePopupBlock()),
                ),
                FlatButton.icon(
                  icon: Icon(CustomIcons.challenges),
                  label: Text('CHALLENGES'),
                  onPressed: () => showPopup(context, ChallengePopupBlock()),
                ),
                FlatButton.icon(
                  icon: Icon(CustomIcons.achievements),
                  label: Text('ACHIEVEMENTS'),
                  onPressed: () => showPopup(context, AchievementsPopupBlock()),
                ),
                FlatButton.icon(
                  icon: Icon(CustomIcons.logout),
                  label: Text('LOG OUT'),
                  onPressed: () => appData.handleSignOut(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Image(
                    height: MediaQuery.of(context).size.width,
                    image: AssetImage('img/Character.png'),
                  ),
                  ...appData.userData.equippedItems.map<Widget>((InventoryItem item) => CharacterItem(item: item)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
