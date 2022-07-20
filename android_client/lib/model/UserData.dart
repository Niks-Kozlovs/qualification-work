import 'package:RunningApp/helper/constants.dart';
import 'package:RunningApp/model/Achievements/Achievements.dart';
import 'package:RunningApp/model/Challenges/Challenges.dart';
import 'package:RunningApp/model/Inventory/Inventory.dart';
import 'package:RunningApp/model/Inventory/InventoryItem.dart';
import 'package:RunningApp/model/Run/Run.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserData with ChangeNotifier {
  String _name;
  String _email;
  String _id;
  int _number;
  //TODO: Move out to provider
  bool _isLoading = false;
  bool _initialized = false;
  int _coins;
  int _experience;
  Challenge _challenges;
  Achievements _achievements;
  List<Run> _runHistory = [];
  Inventory _inventory;
  bool _isGoogleAccount = false;

  String get name => _name;
  String get email => _email;
  String get id => _id;
  int get number => _number;
  int get coins => _coins;
  int get experience => _experience;
  bool get isLoading => _isLoading;
  bool get isInitialized => _initialized;
  Challenge get challenges => _challenges;
  Achievements get achievements => _achievements;
  List<Run> get runs => _runHistory;
  Inventory get inventory => _inventory;
  List<InventoryItem> get equippedItems {
    return _getEquippedItems();
  }

  bool get isGoogleAccount => _isGoogleAccount;

  List<InventoryItem> _getEquippedItems() {
    List<InventoryItem> items = [];
    items.addAll(
        _inventory.items.where((InventoryItem element) => element.isEquipped));

    items.firstWhere((InventoryItem item) => item.type == SHIRT, orElse: () {
      items.add(InventoryItem(imageName: 'shirt_01', type: SHIRT));
      return;
    });
    items.firstWhere((InventoryItem item) => item.type == PANTS, orElse: () {
      items.add(InventoryItem(imageName: 'pants_01', type: PANTS));
      return;
    });
    items.firstWhere((InventoryItem item) => item.type == EYES, orElse: () {
      items.add(InventoryItem(imageName: 'eyes_01', type: EYES));
      return;
    });
    items.firstWhere((InventoryItem item) => item.type == NOSE, orElse: () {
      items.add(InventoryItem(imageName: 'nose_01', type: NOSE));
      return;
    });
    items.firstWhere((InventoryItem item) => item.type == MOUTH, orElse: () {
      items.add(InventoryItem(imageName: 'mouth_01', type: MOUTH));
      return;
    });

    return items;
  }

  void setGoogleUserData(GoogleSignInAccount googleAccount, String id) {
    _name = googleAccount.displayName;
    _email = googleAccount.email;
    _id = googleAccount.id;
    _isLoading = false;
    _isGoogleAccount = true;

    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;

    notifyListeners();
  }

  void setInitialized(bool initialized) {
    _initialized = initialized;

    notifyListeners();
  }

  void setData(Map data) {
    _id = data["token"];
    Map user = data["user"];
    _name = user["username"];
    _number = user["number"];
    _email = user["email"];
    _coins = user["coins"];
    _experience = user["experience"];
    _challenges = Challenge(user["challenges"]);
    _inventory = Inventory(
        user["inventory"], user["boughtItems"], user["equippedItems"]);
    _achievements = Achievements(user["achievements"]);
    setRunData(user["runs"]);
    _isLoading = false;

    notifyListeners();
  }

  void setRunData(List runs) {
    _runHistory = runs.map((e) => Run(e)).toList();
  }

  void clearData() {
    _name = null;
    _email = null;
    _id = null;
    _initialized = false;
    _isLoading = false;
    _challenges = null;
    _coins = 0;
    _experience = 1;
    _achievements = null;
    _runHistory = [];
    _inventory = null;
    _isGoogleAccount = false;

    notifyListeners();
  }

  void setChallenges(allChallenges, userChallenges) {
    if (allChallenges == null) {
      return;
    }

    var challengeList = allChallenges["challenges"];
    var newchallengeList = challengeList.map((challenge) {
      var userStats = userChallenges.firstWhere(
          (userChallenge) =>
              userChallenge["challenge_item_id"] == challenge["id"],
          orElse: () => {"progress": 0.00, "isComplete": false});
      return {
        ...challenge,
        "progress": userStats["progress"],
        "isComplete": userStats["isComplete"]
      };
    }).toList();
    allChallenges["challenges"] = newchallengeList;
    _challenges = allChallenges;
  }

  void setAchievements(allAchievements, userAchievements) {
    _achievements = allAchievements.map((achievement) {
      var userStats = userAchievements.firstWhere(
          (userAchievement) =>
              userAchievement["achievement_id"] == achievement["id"],
          orElse: () => {"progress": 0.00, "isComplete": false});
      return {
        ...achievement,
        "progress": userStats["progress"],
        "isComplete": userStats["isComplete"]
      };
    }).toList();
  }

  void addRun(data) {
    _coins += data["coins"];
    _experience += data["experience"];
    _runHistory.add(Run(data));

    notifyListeners();
  }

  void setIsGoogle(bool status) {
    _isGoogleAccount = status;

    notifyListeners();
  }

  void unequipItem(int id) {
    _inventory.unequipItem(id);
    notifyListeners();
  }

  void equipItem(int id) {
    _inventory.equipItem(id);
    notifyListeners();
  }

  void buyItem(int id, int price) {
    _inventory.buyItem(id);
    _coins -= price;
    notifyListeners();
  }
}
