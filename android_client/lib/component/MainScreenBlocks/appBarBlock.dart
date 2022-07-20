import 'package:flutter/material.dart';

class AppBarBlock extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final int coinCount;
  final int level;
  const AppBarBlock(
      {Key key,
      @required this.name,
      @required this.coinCount,
      @required this.level})
      : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text(name),
          Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: AssetImage('img/star_icon.png'),
                width: 48,
                height: 48,
              ),
              Text(
                level.toString(),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage('img/coinImage.png'),
                width: 24,
                height: 24,
              ),
              Text(
                ' ${coinCount.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => getSize();

  Size getSize() {
    return new Size(100.0, 50.0);
  }
}
