import 'package:flutter/material.dart';

class BottomAppBarBlock extends StatelessWidget {
  final PageController controller;
  const BottomAppBarBlock({Key key, @required this.controller})
      : super(key: key);

  Color getColor(int requiredPage) {
    if (controller.page == null && requiredPage == 0) {
      return Colors.black;
    }
    if (controller.page == null) {
      return Colors.white;
    }

    return controller.page.round() == requiredPage ? Colors.black : Colors.white;
  }

  void goToPage(int page) {
    controller.animateToPage(page, duration: Duration(milliseconds: 750), curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            color: getColor(0),
            icon: Icon(Icons.home),
            onPressed: () {
              goToPage(0);
            },
          ),
          IconButton(
            color: getColor(1),
            icon: Icon(Icons.settings),
            onPressed: () {
              goToPage(1);
            },
          ),
          IconButton(
            color: getColor(2),
            icon: Icon(Icons.assessment),
            onPressed: () {
              goToPage(2);
            },
          ),
          IconButton(
            color: getColor(3),
            icon: Icon(Icons.people),
            onPressed: () {
              goToPage(3);
            },
          ),
        ],
      ),
    );
  }
}
