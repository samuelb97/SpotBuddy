import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:login/src/buddies/buddies.dart';
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
    headers.profile,
    headers.search,
    headers.buddies,
    headers.settings,
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
        title: Text(headers.spotBuddy),
        backgroundColor: Colors.lightGreen,
      ),
      body: TabBarView(
        controller: _controller,
        children: pages.map((title) {
          switch (title) {
            case headers.profile:
              widget.analControl.sendAnalytics('nav_to_profile');
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
              return ProfilePage(user: user_data, analControl: widget.analControl);
<<<<<<< HEAD
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
=======
              return ProfilePage(user: widget.user, analControl: widget.analControl);
>>>>>>> parent of f123d33... UserController
=======
              return ProfilePage(user: widget.user, analControl: widget.analControl);
>>>>>>> parent of f123d33... UserController
=======
              return ProfilePage(user: widget.user, analControl: widget.analControl);
>>>>>>> parent of f123d33... UserController
=======
              return ProfilePage(user: widget.user, analControl: widget.analControl);
>>>>>>> parent of f123d33... UserController
=======
>>>>>>> parent of 1529e1e... Try
              break;
            
            case headers.search:
              widget.analControl.sendAnalytics('nav_to_search');
              return SearchPage(user: widget.user, analControl: widget.analControl);
              break;

            case headers.buddies:
              widget.analControl.sendAnalytics('nav_to_buddies');
              return BuddiesPage(user: widget.user, analControl: widget.analControl);
              break;

            case headers.settings:
              widget.analControl.sendAnalytics('nav_to_settings');
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
            title: Text(headers.profile),
            activeColor: Colors.green,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text(headers.search),
              activeColor: Colors.green,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text(headers.buddies),
              activeColor: Colors.green,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text(headers.settings),
              activeColor: Colors.green,
          ),
        ],
      )
    );
  }
}