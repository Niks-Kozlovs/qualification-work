import 'package:RunningApp/model/Challenges/ChallengeTask.dart';

class Achievements {
  List<ChallengeTask> items;

  Achievements(List achievements) {
    this.items = achievements.map((achievement) => ChallengeTask(name: achievement["name"], id: achievement["ID"], progressData: achievement["progress"])).toList();
  }
}