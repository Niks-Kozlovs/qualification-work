import 'dart:async';
import 'package:flutter/material.dart';

import '../timeDisplay.dart';

class TimeLeft extends StatefulWidget {
  final int startTime;
  TimeLeft({Key key, @required this.startTime}) : super(key: key);

  @override
  _TimeLeftState createState() => _TimeLeftState();
}

class _TimeLeftState extends State<TimeLeft> {
  Timer timer;
  static String timeString;

  _updateTimer() {
    int currTime = DateTime.now().millisecondsSinceEpoch;

    setState(() {
      timeString = getTimeString(widget.startTime, currTime);
    });
  }

  @override
  void initState() {
    _updateTimer();
    timer = Timer.periodic(Duration(seconds: 1), (timer) => _updateTimer());
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(timeString);
  }
}