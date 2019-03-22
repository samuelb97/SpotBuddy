import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/Pages/Setup/logIn.dart';
import 'package:login/Pages/Setup/signUp.dart';
import 'package:login/prop-config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


class SettingsPage extends StatefulWidget {

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  SettingsPage({
    Key key,
    @required this.user,
    this.analytics, 
    this.observer
  }) : super(key: key);

  final FirebaseUser user;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
              onPressed: () {
                _sendAnalytics1();
              },
              child: Text(headers.settings),
          ),
          RaisedButton(
              onPressed: () {},
              child: Text(widget.user.email),
          ),
        ],
      ),
    );
  }

  Future<Null> _currentScreen() async{
    await widget.analytics.setCurrentScreen(
      screenName: 'settings_page',
      screenClassOverride: 'SettingsPageOver'
    );
  }

  Future<Null> _sendAnalytics1() async{
    await widget.analytics.logEvent(
      name: 'to_settings',
      parameters: <String,dynamic>{}
    );
  }
}