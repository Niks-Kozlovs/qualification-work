import 'package:flutter/material.dart';

showPopup(BuildContext context, Widget child,
    {onClose, width, height, showCloseButton = true}) {
  showGeneralDialog(
      barrierDismissible: showCloseButton,
      barrierLabel: 'barrier',
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return WillPopScope(
          onWillPop: () {
            return showCloseButton;
          },
          child: Center(
            child: Container(
                width: width != null
                    ? width
                    : MediaQuery.of(context).size.width - 18,
                height: height != null
                    ? height
                    : MediaQuery.of(context).size.height - 160,
                margin: EdgeInsets.only(left: 0, right: 0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 14),
                      margin: EdgeInsets.only(top: 0, right: 11, left: 11),
                      child: child,
                    ),
                    showCloseButton
                        ? Positioned(
                            right: 0.0,
                            child: GestureDetector(
                              onTap: () {
                                if (onClose != null) {
                                  onClose();
                                }
                                Navigator.of(context).pop();
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 14.0,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )),
          ),
        );
      });
}
