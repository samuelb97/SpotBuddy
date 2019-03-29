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
  List<Buddy> _buddies;


  @override
  void initState() {
    super.initState();
    _loadBuddys();
  }

  Future<void> _loadBuddys() async {
    http.Response response =
        await http.get('https://randomuser.me/api/?results=25');

    setState(() {
      _buddies = Buddy.allFromResponse(response.body);
    });
  }

  Widget _buildBuddyListTile(BuildContext context, int index) {
    var buddy = _buddies[index];

    return new ListTile(
      onTap: () => _navigateToBuddyDetails(buddy, index),
      leading: new Hero(
        tag: index,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(buddy.avatar),
        ),
      ),
      title: new Text(buddy.name),
      subtitle: new Text(buddy.email),
    );
  }

  void _navigateToBuddyDetails(Buddy buddy, Object avatarTag) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new BuddyDetailsPage(buddy, avatarTag: avatarTag);
        },
      ),
    );
  }




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