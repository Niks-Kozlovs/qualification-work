import 'ChallengeTask.dart';

class Challenge {
  List<ChallengeTask> tasks;
  String endDate;

  Challenge(List challenges){
    tasks = challenges.map((challenge) => ChallengeTask(name: challenge["name"], id: challenge["ID"], progressData: challenge["progress"])).toList();
  }
}