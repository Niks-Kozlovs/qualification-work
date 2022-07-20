import 'package:RunningApp/repository/AppData.dart';
import 'package:RunningApp/component/safePaddedForm.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final AppData user;

  LoginForm({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final sizedBoxHeight = 80.0;
  bool _autoValidate = false;
  String email;
  String password;

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter email';
    }

    String emailRegex = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(emailRegex);

    if (regExp.hasMatch(value)) {
      return null;
    }

    return 'Email is not valid';
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }

    return null;
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      widget.user.signIn(email, password);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafePaddedForm(
          child: Form(
            autovalidate: _autoValidate,
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: sizedBoxHeight,
                  child: TextFormField(
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String val) {
                      email = val;
                    },
                  ),
                ),
                SizedBox(
                  height: sizedBoxHeight,
                  child: TextFormField(
                    obscureText: true,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                    ),
                    onSaved: (String val) {
                      password = val;
                    },
                  ),
                ),
                RaisedButton(
                  child: Text('LOGIN'),
                  onPressed: _validateInputs,
                ),
                Text('or'),
                RaisedButton(
                  child: Text('Login with google'),
                  onPressed: () => widget.user.handleGoogleSignIn(),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: RaisedButton(
              child: Text('Forgot password'),
              // TODO: Add forgot password logic here
              onPressed: () => print('Pressed forgot password')),
        ),
      ],
    );
  }
}
