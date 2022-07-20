import 'package:flutter/material.dart';

class SafePaddedForm extends StatelessWidget {
  final Widget child;
  const SafePaddedForm({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: child,
        )
      ),
    );
  }
}