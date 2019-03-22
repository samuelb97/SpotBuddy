import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/prop-config.dart';
import 'package:login/Pages/Setup/logIn.dart';
import 'package:login/Pages/Setup/signUp.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


class BuddiesPage extends StatefulWidget {

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  BuddiesPage({
    Key key,
    @required this.user,
    this.analytics, 
    this.observer
  }) : super(key: key);

  final FirebaseUser user;

  @override
  _BuddiesPageState createState() => _BuddiesPageState();
}

class _BuddiesPageState extends State<BuddiesPage> {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    _currentScreen();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              onPressed: () {},
              child: Text(headers.buddies),
          ),
          RaisedButton(
              onPressed: () {
                _sendAnalytics1();
              },
              child: Text(widget.user.email),
          ),
        ],
      ),
    );
  }

  Future<Null> _currentScreen() async{
    await widget.analytics.setCurrentScreen(
      screenName: 'buddies_page',
      screenClassOverride: 'BuddiesPageOver'
    );
  }

  Future<Null> _sendAnalytics1() async{
    await widget.analytics.logEvent(
      name: 'to_buddies',
      parameters: <String,dynamic>{}
    );
  }

}