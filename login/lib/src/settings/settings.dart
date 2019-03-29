import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/prop-config.dart';
import 'package:login/analtyicsController.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({
    Key key,
    this.analControl,
    @required this.user
  }) : super(key: key);

  final FirebaseUser user;
  final analyticsController analControl;

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
              child: Text(Headers.settings),
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