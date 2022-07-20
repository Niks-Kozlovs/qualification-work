import 'package:RunningApp/component/MainScreenBlocks/appBarBlock.dart';
import 'package:RunningApp/component/MainScreenBlocks/bottomAppBarBlock.dart';
import 'package:RunningApp/component/MainScreenBlocks/friendsBlock.dart';
import 'package:RunningApp/component/MainScreenBlocks/homeViewBlock.dart';
import 'package:RunningApp/component/MainScreenBlocks/runHistoryBlock.dart';
import 'package:RunningApp/component/MainScreenBlocks/settingsViewBlock.dart';
import 'package:RunningApp/repository/AppData.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: _page);
    final user = AppData(context);

    return Scaffold(
      appBar: AppBarBlock(
        name: user.userData.name,
        coinCount: user.userData.coins,
        level: (user.userData.experience / 1000).round() + 1,
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (int page) {
          setState(() {
            _page = page;
          });
        },
        children: <Widget>[
          HomeViewBlock(),
          SettingsViewBlock(),
          RunHistoryBlock(),
          FriendsBlock(),
        ],
      ),
      floatingActionButton: getFloatingActionButton(),
      floatingActionButtonLocation: _page == 0
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBarBlock(controller: controller),
    );
  }

  FloatingActionButton getFloatingActionButton() {
    void _onPressed() {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/map',
        (Route<dynamic> route) => false,
      );
    }

    if (_page < 1) {
      return FloatingActionButton.extended(
        elevation: 4.0,
        label: Text('To map'),
        onPressed: _onPressed,
      );
    }

    return FloatingActionButton(
      elevation: 4.0,
      child: Icon(Icons.directions_run, semanticLabel: 'Test',),
      onPressed: _onPressed,
    );
  }
}
