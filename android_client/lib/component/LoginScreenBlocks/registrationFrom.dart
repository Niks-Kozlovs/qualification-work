import 'package:RunningApp/repository/AppData.dart';
import 'package:RunningApp/component/safePaddedForm.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final AppData user;

  RegisterForm({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final sizedBoxHeight = 80.0;
  bool _autoValidate = false;
  String email;
  String name;
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

  String _validateRepeatPassword(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }

    if (value != _password.value.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      widget.user.register(email, name , password);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafePaddedForm(
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
                decoration: InputDecoration(
                  labelText: 'DISPLAY NAME',
                ),
                keyboardType: TextInputType.text,
                onSaved: (String val) {
                  name = val;
                },
              ),
            ),
            SizedBox(
              height: sizedBoxHeight,
              child: TextFormField(
                obscureText: true,
                controller: _password,
                validator: _validatePassword,
                decoration: InputDecoration(
                  labelText: 'PASSWORD',
                ),
                onSaved: (String val) {
                  password = val;
                },
              ),
            ),
            SizedBox(
              height: sizedBoxHeight,
              child: TextFormField(
                obscureText: true,
                validator: _validateRepeatPassword,
                decoration: InputDecoration(
                  labelText: 'REPEAT PASSWORD',
                ),
                onSaved: (String val) {
                  password = val;
                },
              ),
            ),
            RaisedButton(
              child: Text('REGISTER'),
              onPressed: _validateInputs,
            ),
          ],
        ),
      ),
    );
  }
}
