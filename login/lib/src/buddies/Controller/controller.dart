import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/prop-config.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/analtyicsController.dart';
import 'package:login/src/buddies/Model/buddy.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:login/src/buddies/View/details_page.dart';

class Controller extends ControllerMVC {
  factory Controller() {
    if (_this == null) _this = Controller._();
    return _this;
  } 
  static Controller _this;

  Controller._();

  static Controller get con => _this;

  List<Buddy> _buddies = [];

  @override
  void initState() {
    super.initState();
    _loadBuddies();
  }

  Future<void> _loadBuddies() async {
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

  void _navigateToBuddyDetails(
      Buddy buddy, Object avatarTag) 
      async {
    BuildContext context;
    Buddy buddy; 
    Object avatarTag;
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return BuddyDetailsPage(buddy, avatarTag: avatarTag);
        },
      ),
    );
  }
}