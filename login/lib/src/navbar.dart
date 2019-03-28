import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:login/src/buddies/buddies.dart';
import 'package:login/src/profile/View/profile.dart';
import 'package:login/src/search/search.dart';
import 'package:login/src/settings/settings.dart';
import 'package:login/prop-config.dart';
import 'package:login/analtyicsController.dart';
import 'package:login/userController.dart';

class Home extends StatefulWidget {

  Home({
    Key key,
    this.analControl,
    @required this.user,
  }) : super(key: key);

  final FirebaseUser user;
  final analyticsController analControl;
  
  @override
  _HomeState createState() => _HomeState(user.uid);
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  _HomeState(this.uid){
    user_data = userController();
    user_data.set_uid = this.uid;
    user_data.load_data_from_firebase();
  }
  String uid;
  userController user_data;

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
              return ProfilePage(user: user_data, analControl: widget.analControl);
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
              return ProfilePage(user: user_data, analControl: widget.analControl);
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