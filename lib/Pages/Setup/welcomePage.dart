import 'package:flutter/material.dart';
import 'package:login/Pages/Setup/logIn.dart';
import 'package:login/Pages/Setup/signUp.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:login/prop_config.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headers.spotBuddy),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              onPressed: NavigateToSignIn,
              child: Text(prompts.login),
          ),
          RaisedButton(
              onPressed: NavigateToSignUp,
              child: Text(prompts.signup),
          ),
        ],
      ),
    );
  }

  void NavigateToSignIn(){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => LoginPage(),
        fullscreenDialog: true
      )
    );
  }

  void NavigateToSignUp(){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
        fullscreenDialog: true
      )
    );
  }

}