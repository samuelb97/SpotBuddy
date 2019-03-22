import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/Pages/Profile/updateprofile.dart';
import 'package:login/prop-config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class ProfilePage extends StatefulWidget {

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  ProfilePage({
    Key key,
    @required this.user,
    this.analytics, 
    this.observer
  }) : super(key: key);

  final FirebaseUser user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    _currentScreen();
    return Scaffold(
      body: Center(
      child: IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              onPressed: (){
                _sendAnalytics1();
                NavigateToUpdateProfile();
              },
              child: Text(prompts.updateProfile),
          ),
          RaisedButton(
              onPressed: () {},
              child: Text(widget.user.email),
          ),
        ],
      ),
      ),
      ),
    );
  }

  Future<Null> _currentScreen() async{
    await widget.analytics.setCurrentScreen(
      screenName: 'profile_page',
      screenClassOverride: 'Pro_filePageOver'
    );
  }

  Future<Null> _sendAnalytics1() async{
    await widget.analytics.logEvent(
      name: 'to_update_profile',
      parameters: {}
    );
  }

  void NavigateToUpdateProfile() {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => UpdateProfilePage(user: widget.user),
        fullscreenDialog: true
      )
    );
  }

}