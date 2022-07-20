import 'package:RunningApp/model/UserData.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class AppData {
  GoogleSignIn _googleSignIn;
  BuildContext _context;
  UserData _user;

  UserData get userData => _user;

  AppData(BuildContext context, {GoogleSignIn googleSignin}) {
    this._googleSignIn = googleSignin ??
        GoogleSignIn(
          scopes: ['email'],
        );

    this._context = context;
    this._user = Provider.of<UserData>(_context, listen: false);
  }

  void _setGoogleData(GoogleSignInAccount googleUser) async {
    if (googleUser == null) {
      return;
    }
    final GoogleSignInAuthentication auth = await googleUser.authentication;
    _user.setGoogleUserData(googleUser, auth.idToken.toString());

    _user.setIsLoading(false);
  }

  Future<void> _handleGoogleSignIn(name, email) async {
      _user.setIsLoading(true);
      const googleLoginMutation = """
        mutation GoogleLogin(\$name: String! \$email: String!) {
          googleLogin(name: \$name email: \$email) {
            id
            name
            email
            coins
            experience
          }
        }
      """;

      var user = await GraphQLProvider.of(_context).value.mutate(MutationOptions(
    documentNode: gql(googleLoginMutation),
    variables: {"name": name, "email": email}));

    if (user.hasException) {
      throw (user.exception.toString());
    }

    _user.setIsGoogle(false);

    _user.setData(user.data["googleLogin"]);
  }

  Future<void> handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      _setGoogleData(googleUser);
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      _user.clearData();
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleSilentLogin() async {
    bool isSignedIn = await _googleSignIn.isSignedIn();
    _user.setIsLoading(false);
    if (!isSignedIn) {
      return;
    }

    try {
      final GoogleSignInAccount googleUser =
          await _googleSignIn.signInSilently();
      _setGoogleData(googleUser);
    } catch (error) {
      print(error);
    }
  }

  Future<void> signIn(email, password) async {
    _user.setIsLoading(true);
    const mutation = """
    mutation Login(\$email: String! \$password: String!) {
      login(email: \$email password: \$password) {
        token
        user {
          username
          number
          email
          experience
          coins
          challenges {
            name
            type
            progress
          }
          inventory {
            ID
            name
            description
            image_name
            price
            type
            level
          }
          boughtItems
          equippedItems
          achievements {
            ID
            name
            progress
          }
          runs {
            ID
            rating
            experience
            coins
            locationData {
              latitude
              longtitude
              altitude
              speed
              time
            }
          }
          friends {
            experience
            username
            number
            equippedItems
          }
          friendRequests {
            name
            id
          }
        }
      }
    }
    """;

    var user = await GraphQLProvider.of(_context).value.mutate(MutationOptions(
        documentNode: gql(mutation),
        variables: {"email": email, "password": password}));

    if (user.hasException) {
      _user.setIsLoading(false);
      throw (user.exception.toString());
    }

    if (user.data["login"] == null) {
      _user.setIsLoading(false);
      throw ('User not found');
    }

    _user.setData(user.data["login"]);
  }

  Future<void> register(email, name, password) async {
    _user.setIsLoading(true);
    const registerMutation = """
      mutation Register(\$name: String! \$email: String! \$password: String!) {
        register(name: \$name, email: \$email password: \$password) {
          id
          name
          email
          coins
          experience
        }
      }
    """;

    var user = await GraphQLProvider.of(_context).value.mutate(MutationOptions(
        documentNode: gql(registerMutation),
        variables: {"name": name, "email": email, "password": password}));

    if (user.hasException) {
      throw (user.exception.toString());
    }

    _user.setData(user.data["register"]);
  }

  Future<void> addRun(Map run) async {
    const runQuery = """
      mutation FinishRun(\$locations: [LocationInput!]! \$distance: Int! \$time: Int! \$rating: Int) {
        finishRun(locations: \$locations distance: \$distance time: \$time rating: \$rating) {
          experience
          coins
          rating
          locationData {
            latitude
            longtitude
            altitude
            speed
            time
          }
        }
      }
    """;

    var result = await GraphQLProvider.of(_context)
        .value
        .mutate(MutationOptions(documentNode: gql(runQuery), variables: {
          "locations": run["locations"].map((LocationData location) {
            return {
              "latitude": location.latitude,
              "longtitude": location.longitude,
              "altitude": location.altitude,
              "speed": location.speed,
              "time": location.time
            };
          }).toList(),
          "rating": run["rating"],
          "distance": run["distance"],
          "time": run["time"]
        }));

    if (result.hasException) {
      throw (result.exception.toString());
    }

    _user.addRun(result.data["finishRun"]);
  }

  Future<bool> equipItem(int id) async {
    const equipItemMutation = """
      mutation EquipItem(\$itemId: Int!) {
        equipItem(itemId: \$itemId)
      }
    """;

    var result = await GraphQLProvider.of(_context).value.mutate(
            MutationOptions(documentNode: gql(equipItemMutation), variables: {
          "itemId": id,
        }));

    if (result.hasException) {
      return false;
    }

    _user.equipItem(id);
    return true;
  }

  Future<bool> buyItem(int id, int price) async {
        const buyItemMutation = """
      mutation BuyItem(\$itemId: Int!) {
        buyItem(itemId: \$itemId) {
          ID
        }
      }
    """;

    var result = await GraphQLProvider.of(_context).value.mutate(
            MutationOptions(documentNode: gql(buyItemMutation), variables: {
          "itemId": id,
    }));

    if (result.hasException) {
      return false;
    }

    _user.buyItem(id, price);
    return true;
  }

  Future<bool> unequipItem(int id) async {
    const unequipItemMutation = """
      mutation UnequipItem(\$itemId: Int!) {
        unequipItem(itemId: \$itemId)
      }
    """;

    var result = await GraphQLProvider.of(_context).value.mutate(
            MutationOptions(documentNode: gql(unequipItemMutation), variables: {
          "itemId": id,
    }));

    if (result.hasException) {
      return false;
    }

    _user.unequipItem(id);
    return true;
  }
}
