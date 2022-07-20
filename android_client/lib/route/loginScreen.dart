import 'package:flutter/material.dart';
import '../repository/AppData.dart';
import 'package:RunningApp/component/LoginScreenBlocks/index.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: _page);
    final user = AppData(context);

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => user.handleSilentLogin());

    return Scaffold(
      appBar: AppBar(
          title: Text(_page == 0 ? 'Sign in' : 'Register'),
          automaticallyImplyLeading: false),
      body: PageView(
        controller: controller,
        onPageChanged: (int page) {
          setState(() {
            _page = page;
          });
        },
        children: [
          LoginForm(user: user),
          RegisterForm(user: user),
        ],
      ),
    );
  }
}
