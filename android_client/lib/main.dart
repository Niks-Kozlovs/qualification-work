import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:RunningApp/model/UserData.dart';
import 'theme/style.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './route/index.dart';

Future main() async {
  await DotEnv().load('.env');

  runApp(AuthCheck());
}

class AuthCheck extends StatefulWidget {
  AuthCheck({Key key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: Consumer<UserData>(builder: (context, userData, _) {
        return AuthScreen(userData: userData);
      }),
    );
  }
}

class AuthScreen extends StatefulWidget {
  final UserData userData;
  const AuthScreen({Key key, @required this.userData}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Widget _getScreen(BuildContext context, UserData userData) {
    if (userData.isLoading) {
      return getLoader();
    }

    //For some reason you cant change headers in HttpLink after it has been created so I had to create two seperate providers to make it work with a token

    if (userData.id == null || userData.id.isEmpty) {
      return getLoginMaterial();
    }

    return getMainMaterial(userData);
  }

  MaterialApp getLoader() {
    return MaterialApp(
        home: Scaffold(
          body: Container(
            color: Color.fromARGB(255, 244, 194, 87),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
  }

  GraphQLProvider getMainMaterial(UserData userData) {
    final HttpLink httpLink = new HttpLink(
      uri: DotEnv().env["GRAPHQL_URL"],
      headers: <String, String>{
        "content-type": "application/json",
        "Authorization": "Bearer " + userData.id
      },
    );

    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(
            GraphQLClient(cache: InMemoryCache(), link: httpLink));

    return GraphQLProvider(client: client, child: MyApp());
  }

  GraphQLProvider getLoginMaterial() {
    final HttpLink httpLink = new HttpLink(
      uri: DotEnv().env["GRAPHQL_URL"],
      headers: <String, String>{"content-type": "application/json"},
    );
    final ValueNotifier<GraphQLClient> client =
        new ValueNotifier<GraphQLClient>(
            GraphQLClient(cache: InMemoryCache(), link: httpLink));
    return GraphQLProvider(
        client: client, child: MaterialApp(home: LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return _getScreen(context, widget.userData);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/map': (context) => MapScreen()
      },
      theme: getDefaultTheme(),
    );
  }
}
