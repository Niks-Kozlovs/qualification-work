import 'package:flutter/material.dart';

String getTimeString(int startTime, int endTime) {
  if (startTime > endTime) {
    throw Exception('End time must be bigger then start time');
  }

    int timeDiff = endTime - startTime;
    Duration timeDuration = Duration(milliseconds: timeDiff);

    int seconds = timeDuration.inSeconds % 60;
    int minutes = timeDuration.inMinutes % 60;
    int hours = timeDuration.inHours % 24;


    return '${hours < 10 ? 0 : ''}$hours:${minutes < 10 ? 0 : ''}$minutes:${seconds < 10 ? 0 : ''}$seconds';

}