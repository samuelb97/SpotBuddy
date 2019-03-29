import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/src/welcome/signup/controller.dart';
import 'package:login/analtyicsController.dart';

class SignUpPage extends StatefulWidget {

  final analyticsController analControl;

  SignUpPage({this.analControl});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends StateMVC<SignUpPage> {
  _SignUpPageState() : super(Controller()){
    _con = Controller.con;
  }
  Controller _con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Prompts.signup),
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: _con.formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
               if(input.isEmpty){
                 return Prompts.name;
               } 
              },
              onSaved: (input) => _con.set_name = input,
              decoration: InputDecoration(
                labelText: Headers.username
              ),
            ),
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
            RaisedButton(
              onPressed: () {
                widget.analControl.sendAnalytics('new_sign_up');
                widget.analControl.currentScreen('sign_up', 'SignUpOver');
                Controller.signUp(context, widget.analControl);
              },
              child: Text(Prompts.signup),
            )
          ],
        ),
      ),
    );
  }
}