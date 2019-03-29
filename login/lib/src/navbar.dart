import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:login/src/buddies/Controller/buddies.dart';
import 'package:login/src/profile/View/profile.dart';
import 'package:login/src/search/search.dart';
import 'package:login/src/settings/settings.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:login/prop-config.dart';
import 'package:login/analtyicsController.dart';

class Home extends StatefulWidget {

  Home({
    Key key,
    this.analControl,
    @required this.user
  }) : super(key: key);

  final FirebaseUser user;
  final analyticsController analControl;
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _index = 0;
  TabController _controller;


  List<String> pages = [
    Headers.profile,
    Headers.search,
    Headers.buddies,
    Headers.settings,
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
        vsync: this,
        length: pages.length,
        initialIndex: _index
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(Headers.spotBuddy),
        backgroundColor: Colors.lightGreen,
      ),
      body: TabBarView(
        controller: _controller,
        children: pages.map((title) {
          switch (title) {
<<<<<<< HEAD
            case headers.profile:
              widget.analControl.sendAnalytics('nav_to_profile');
<<<<<<< HEAD
<<<<<<< HEAD
              return ProfilePage(user: user_data, analControl: widget.analControl);
=======
            case Headers.profile:
              widget.analControl.sendAnalytics(Events.profile);
              return ProfilePage(user: widget.user, analControl: widget.analControl);
>>>>>>> 293d74ebd7b329e349a82df90d0226ffcf25624f
=======
              return ProfilePage(user: widget.user, analControl: widget.analControl);
>>>>>>> parent of f123d33... UserController
=======
              return ProfilePage(user: widget.user, analControl: widget.analControl);
>>>>>>> parent of f123d33... UserController
              break;
            
            case Headers.search:
              widget.analControl.sendAnalytics(Events.search);
              return SearchPage(user: widget.user, analControl: widget.analControl);
              break;

            case Headers.buddies:
              widget.analControl.sendAnalytics(Events.buddies);
              return BuddiesPage(user: widget.user, analControl: widget.analControl);
              break;

            case Headers.settings:
              widget.analControl.sendAnalytics(Events.settings);
              return SettingsPage(user: widget.user, analControl: widget.analControl);
              break;

            default:
              return ProfilePage(user: widget.user, analControl: widget.analControl);
              break;
          }
        }).toList(),
      ),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: (index) => setState(() {
            _index = index;
            _controller.animateTo(_index);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.portrait),
            title: Text(Headers.profile),
            activeColor: Colors.green,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text(Headers.search),
              activeColor: Colors.green,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text(Headers.buddies),
              activeColor: Colors.green,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text(Headers.settings),
              activeColor: Colors.green,
          ),
        ],
      )
    );
  }
}