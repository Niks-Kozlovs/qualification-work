import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final Widget icon;
  final String text;
  const IconText(
    this.icon,
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: icon,
        ),
        Text(text),
      ],
    );
  }
}
