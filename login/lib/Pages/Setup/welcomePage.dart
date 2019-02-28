import 'package:flutter/material.dart';
import 'package:login/Pages/Setup/logIn.dart';
import 'package:login/Pages/Setup/signUp.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpotBuddy'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              onPressed: NavigateToSignIn,
              child: Text('Log In'),
          ),
          RaisedButton(
              onPressed: NavigateToSignUp,
              child: Text('Sign Up'),
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