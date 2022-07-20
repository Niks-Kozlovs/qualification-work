import 'package:RunningApp/model/Challenges/ChallengeTask.dart';
import 'package:RunningApp/repository/AppData.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AchievementsPopupBlock extends StatelessWidget {
  const AchievementsPopupBlock({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppData(context);
    final List<ChallengeTask> _items = user.userData.achievements.items;

    return Scaffold(
      body: ListView(
          children: _items.map((item) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Ink(
            color: item.isComplete ? Colors.green : Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      item.isComplete ? Icon(Icons.check) : null,
                      Text(item.name),
                    ].where((child) => child != null).toList(),
                  ),
                ),
                !item.isComplete
                    ? LinearPercentIndicator(
                        percent: item.progress == 0 ? 0 : item.progress / 100,
                        lineHeight: 20.0,
                        progressColor: Colors.blue,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        center: Text('${item.progress}%'))
                    : null,
              ].where((child) => child != null).toList(),
            ),
          ),
        );
      }).toList()),
    );
  }
}
