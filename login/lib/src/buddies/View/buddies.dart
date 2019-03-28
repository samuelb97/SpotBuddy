import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:login/src/buddies/View/details_page.dart';
import 'package:login/src/buddies/Model/buddy.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/analtyicsController.dart';

class BuddiesPage extends StatefulWidget { 
  BuddiesPage({
    Key key,
    @required this.user, 
    this.analControl
  })
      : super(key: key);

  final FirebaseUser user;
  final analyticsController analControl;

  @override
  _BuddiesPageState createState() => _BuddiesPageState();
}

class _BuddiesPageState extends StateMVC<BuddiesPage> {

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_buddies.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: _buddies.length,
        itemBuilder: _buildBuddyListTile,
      );
    }
    return new Scaffold(
      body: content,
    );
  }
}