import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/src/welcome/login/controller.dart';
import 'package:login/analtyicsController.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class LoginPage extends StatefulWidget {

  final analyticsController analControl;

  LoginPage({this.analControl});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage> {
  _LoginPageState() : super(Controller()){
    _con = Controller.con;
  }
  Controller _con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Prompts.login),
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: _con.formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
               if(input.isEmpty){
                 return Prompts.type_email;
               } 
              },
              onSaved: (input) => _con.set_email = input,
              decoration: InputDecoration(
                labelText: Headers.email
              ),
            ),
             TextFormField(
              validator: (input) {
               if(input.length < 6){
                 return Prompts.passwrd_valid;
               } 
              },
              onSaved: (input) => _con.set_password = input,
              decoration: InputDecoration(
                labelText: Prompts.passwrd
              ),
              obscureText: true,
            ),
            ButtonTheme( 
              minWidth: 250,
            child: RaisedButton(
              color: Colors.green[800],
              splashColor: Colors.green[300],
              textTheme: ButtonTextTheme.primary,
              padding: EdgeInsets.all(20.0),
              elevation: 6,
              shape: BeveledRectangleBorder(
                side: BorderSide(
                  width: 2.0, 
                  color: Colors.grey[400],
                ), 
                borderRadius: BorderRadius.circular(10), 
              ),
              onPressed: () {
                widget.analControl.currentScreen(
                  Screens.login, 
                  Screens.loginOver);
                Controller.signIn(context, widget.analControl);
              },
              child: Text(Prompts.login),
            )
            ),
          ],
        ),
      ),
    );
  }
}