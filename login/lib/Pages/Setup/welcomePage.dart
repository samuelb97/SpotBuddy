import 'package:flutter/material.dart';
import 'package:login/Pages/Setup/logIn.dart';
import 'package:login/Pages/Setup/signUp.dart';
import 'package:login/prop-config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


class WelcomePage extends StatefulWidget {

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  WelcomePage({this.analytics, this.observer});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Headers.spotBuddy),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.image),
            fit: BoxFit.fitWidth,
          ),
        ),
        
        child: Container(
          /*this is a decoration for a box that encompasses the two buttons. wont work at same time as background image
          height: 180,
          width: 310,
          decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(18))
            ),
          */
          //child: IntrinsicWidth( only works in Center class not Container??
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    _sendAnalytics1();
                    navigateToSignIn();
                  },
                  child: Text(Prompts.login),
                ),
                RaisedButton(
                  onPressed: (){
                    _sendAnalytics2();
                    navigateToSignUp();
                  },
                  child: Text('     ' + Prompts.signup + '     '),
                ),
              ],
            ),
          ),
          //),
       ),
     );
  }

  Future<Null> _currentScreen() async{
    await widget.analytics.setCurrentScreen(
      screenName: screens.welcome,
      screenClassOverride: screens.welcomeOver
    );
  }

  Future<Null> _sendAnalytics1() async{
    await widget.analytics.logEvent(
      name: events.login,
      parameters: <String,dynamic>{}
    );
  }

  Future<Null> _sendAnalytics2() async{
     await widget.analytics.logEvent(
      name: events.signup,
      parameters: <String,dynamic>{}
    );
  }

  void navigateToSignIn(){
    _currentScreen();
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => LoginPage(analytics: analytics, observer: observer),
        fullscreenDialog: true
      )

    );
  }

  void navigateToSignUp(){
    _currentScreen();
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SignUpPage(analytics: analytics, observer: observer),
        fullscreenDialog: true
      )
    );
   
  }

}