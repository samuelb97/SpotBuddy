import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:login/src/buddies/View/details_page.dart';
import 'package:login/src/buddies/Controller/controller.dart';
import 'package:login/src/buddies/Model/buddy.dart';
import 'package:login/src/buddies/Model/item.dart'; 
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/analtyicsController.dart';
import 'package:login/userController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BuddiesPage extends StatefulWidget {  
  BuddiesPage({
    Key key,
    this.analControl,
    this.buddy,
    @required this.user 
    
  })
      : super(key: key);
  final Buddy buddy;
  final userController user;
  final analyticsController analControl;

  @override
  _BuddiesPageState createState() => _BuddiesPageState();
}

class _BuddiesPageState extends StateMVC<BuddiesPage> {
  _BuddiesPageState() : super(Controller()) {
    buddyController = Controller.con;
  }
  Controller buddyController;
  
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
/*
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
*/
/*
  void _navigateToBuddyDetails(Buddy buddy, Object avatarTag) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new BuddyDetailsPage(buddy, avatarTag: avatarTag);
        },
      ),
    );
  }
*/



  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            // List
            Container(
              child: StreamBuilder(
                stream: Firestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) => buildItem(
                        context, 
                        snapshot.data.documents[index], 
                        widget.user,
                        widget.analControl
                      ),
                      itemCount: snapshot.data.documents.length,
                    );
                  }
                },
              ),
            ),

            // Loading
            Positioned(
              child: buddyController.isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent)),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    )
                  : Container(),
            )
          ],
        ),
    );
  }



/*
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
  */
}