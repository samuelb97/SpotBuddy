import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:login/Pages/Profile/profile.dart';
import 'package:login/Pages/Search/search.dart';
import 'package:login/Pages/Buddies/buddies.dart';
import 'package:login/Pages/Settings/settings.dart';
import 'package:firebase_analytics/observer.dart';

class Home extends StatefulWidget {
  
  Home({
    Key key,
    @required this.user
  }) : super(key: key);

  final FirebaseUser user;
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _index = 0;
  TabController _controller;


  List<String> pages = [
    'Profile',
    'Search',
    'Buddies',
    'Settings',
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
        title: Text('SpotBuddy'),
        backgroundColor: Colors.lightGreen,
      ),
      body: TabBarView(
        controller: _controller,
        children: pages.map((title) {
          switch (title) {
            case 'Profile':
              return ProfilePage(user: widget.user);
              break;
            
            case 'Search':
              return SearchPage(user: widget.user);
              break;

            case 'Buddies':
              return BuddiesPage(user: widget.user);
              break;

            case 'Settings':
              return SettingsPage(user: widget.user);
              break;

            default:
              return ProfilePage(user: widget.user);
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
            title: Text('Profile'),
            activeColor: Colors.green,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
              activeColor: Colors.green,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Buddies'),
              activeColor: Colors.green,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              activeColor: Colors.green,
          ),
        ],
      )
    );
  }
}