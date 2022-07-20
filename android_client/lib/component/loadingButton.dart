import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;
  LoadingButton({Key key, @required this.onPressed, @required this.child})
      : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        if (_isLoading) {
          return;
        }

        _setIsLoading(true);
        await widget.onPressed();
        _setIsLoading(false);
      },
      child: _isLoading ? CircularProgressIndicator() : widget.child,
    );
  }

  _setIsLoading(bool status) {
    setState(() {
      _isLoading = status;
    });
  }
}
