import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/Pages/Setup/logIn.dart';
import 'package:login/Pages/Setup/signUp.dart';


class SettingsPage extends StatefulWidget {

  SettingsPage({
    Key key,
    @required this.user
  }) : super(key: key);

  final FirebaseUser user;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              onPressed: () {},
              child: Text('Settings'),
          ),
          RaisedButton(
              onPressed: () {},
              child: Text(widget.user.email),
          ),
        ],
      ),
    );
  }
}