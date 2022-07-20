import 'package:flutter/material.dart';

class RenderLoadingMap extends StatelessWidget {
  const RenderLoadingMap();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Loading map..',
          style:
              TextStyle(fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
        ),
      ),
    );
  }
}