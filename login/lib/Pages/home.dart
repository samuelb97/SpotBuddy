import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:login/Pages/Profile/profile.dart';
import 'package:login/Pages/Search/search.dart';
import 'package:login/Pages/Buddies/buddies.dart';
import 'package:login/Pages/Settings/settings.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:login/prop-config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class Home extends StatefulWidget {
  
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  Home({
    Key key,
    @required this.user,
    this.analytics,
    this.observer
  }) : super(key: key);

  final FirebaseUser user;
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _index = 0;
  TabController _controller;

    static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);




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
            case Headers.profile:
              _sendAnalytics1();
              return ProfilePage(user: widget.user,analytics: analytics, observer: observer);
              break;
            
            case Headers.search:
              _sendAnalytics2();
              return SearchPage(user: widget.user,analytics: analytics, observer: observer);
              break;

            case Headers.buddies:
              _sendAnalytics3();
              return BuddiesPage(user: widget.user,analytics: analytics, observer: observer);
              break;

            case Headers.settings:
              _sendAnalytics4();
              return SettingsPage(user: widget.user,analytics: analytics, observer: observer);
              break;

            default:
              return ProfilePage(user: widget.user,analytics: analytics, observer: observer);
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

  Future<Null> _sendAnalytics1() async{
    await widget.analytics.logEvent(
      name: Events.profile,
      parameters: <String,dynamic>{}
    );
  }

  Future<Null> _sendAnalytics2() async{
     await widget.analytics.logEvent(
      name: Events.search,
      parameters: <String,dynamic>{}
    );
  }

  Future<Null> _sendAnalytics3() async{
    await widget.analytics.logEvent(
      name: Events.buddies,
      parameters: <String,dynamic>{}
    );
  }

  Future<Null> _sendAnalytics4() async{
     await widget.analytics.logEvent(
      name: Events.settings,
      parameters: <String,dynamic>{}
    );
  }
}