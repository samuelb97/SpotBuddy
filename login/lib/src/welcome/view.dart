import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/src/welcome/controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:login/analtyicsController.dart';

class WelcomePage extends StatefulWidget {

  final analyticsController thisAnalyticsController;

  WelcomePage({this.thisAnalyticsController});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends StateMVC<WelcomePage> {
  _WelcomePageState() : super(Controller());

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
            image: AssetImage("assets/dog.jpg"),
            fit: BoxFit.fitHeight,
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
                  onPressed: () {
                    widget.thisAnalyticsController.sendAnalytics(Events.login);
                    widget.thisAnalyticsController.currentScreen(Screens.welcome, Screens.welcomeOver);
                    Controller.NavigateToSignIn(context, widget.thisAnalyticsController);
                  },
                  child: Text(Prompts.login),
                ),
                RaisedButton(
                  onPressed: () {
                    widget.thisAnalyticsController.sendAnalytics(Events.signup);
                    widget.thisAnalyticsController.currentScreen(Screens.welcome, Screens.welcomeOver);
                    Controller.NavigateToSignUp(context, widget.thisAnalyticsController);
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
}