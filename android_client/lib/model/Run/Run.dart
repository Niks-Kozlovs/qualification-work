import 'package:RunningApp/model/Run/RunData.dart';

class Run {
  List<RunData> locationData = [];
  int id;
  int rating;
  int experience;
  int coins;

  Run(data) {
    this.id = data["ID"];
    this.rating = data["rating"];
    this.experience = data["experience"];
    this.coins = data["coins"];
    this.locationData = data["locationData"].map<RunData>((e) => RunData(e["latitude"], e["longtitude"], e["altitude"].toDouble(), e["speed"].toDouble(), e["time"])).toList();
  }
}