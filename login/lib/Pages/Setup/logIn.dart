import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/Pages/home.dart';
import 'package:login/prop-config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class LoginPage extends StatefulWidget {

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  LoginPage({this.analytics, this.observer});

  //  static FirebaseAnalytics analytics2 = FirebaseAnalytics();
  //static FirebaseAnalyticsObserver observer2 =
  //    FirebaseAnalyticsObserver(analytics: analytics2);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {  
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  String _email, _password;
  final GlobalKey<FormState> 
    _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prompts.login),
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
               if(input.isEmpty){
                 return prompts.type_email;
               } 
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: headers.email
              ),
            ),
             TextFormField(
              validator: (input) {
               if(input.length < 6){
                 return prompts.passwrd_valid;
               } 
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: prompts.passwrd
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: (){
                _currentScreen();
                signIn();
              },
              child: Text(prompts.login),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _currentScreen() async{
    await widget.analytics.setCurrentScreen(
      screenName: 'login_page',
      screenClassOverride: 'Log_inPageOver'
    );
  }

  Future<Null> _sendAnalytics1() async{
    await widget.analytics.logEvent(
      name: 'login_successful',
      parameters: <String,dynamic>{}
    );
  }

  Future<Null> _sendAnalytics2() async{
    await widget.analytics.logEvent(
      name: 'email_verification_needed',
      parameters: <String,dynamic>{}
    );
  }


  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email, 
          password: _password,
        );
        if(user.isEmailVerified){
            _sendAnalytics1();
            //TODO: Add option to push to update profile page
            //TODO: Create document in users collection with document title = user.uid
            Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => Home(user: user, analytics: analytics, observer: observer)
            )
          );
        }
        else {
          _sendAnalytics2();
          _ShowEmailNotVerifiedAlert(user);
        }
      }
      catch(e){
        print(e.message);
      }
    }
  }

  void _ShowEmailNotVerifiedAlert(FirebaseUser user){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(prompts.email_verif),
          content: Text(
            prompts.email_err_1 +
            prompts.email_err_2 +
            '${user.email}'
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(headers.resend),
              onPressed: () {
                user.sendEmailVerification();
              },
            ),
            FlatButton(
              child: Text(headers.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    
  }
}