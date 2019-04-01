import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/prop-config.dart';
import 'package:login/analtyicsController.dart';
import 'package:login/userController.dart';

class BuddiesPage extends StatefulWidget {

  BuddiesPage({
    Key key,
    this.analControl,
    @required this.user
  }) : super(key: key);

  final userController user;
  final analyticsController analControl;

  @override
  _BuddiesPageState createState() => _BuddiesPageState();
}

class _BuddiesPageState extends State<BuddiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              onPressed: () {},
              child: Text(Headers.findBuddies),
          ),
          RaisedButton(
              onPressed: () {},
              child: Text(widget.user.name),
          ),
        ],
      ),
    );
  }
}