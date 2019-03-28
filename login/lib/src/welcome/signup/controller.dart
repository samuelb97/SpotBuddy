import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/src/welcome/login/view.dart';
import 'package:login/analtyicsController.dart';

class Controller extends ControllerMVC {
  factory Controller() {
    if (_this == null) _this = Controller._();
    return _this;
  }
  static Controller _this;

  Controller._();

  GlobalKey<FormState> get formkey => _formkey;

  static final GlobalKey<FormState> 
    _formkey = GlobalKey<FormState>();

  static String email, password, name;

  set set_email(String _email){
    email = _email;
  }
  set set_password(String _password){
    password = _password;
  }
  set set_name(String _name){
    name = _name;
  }


  static Controller get con => _this;
  
  static Future<void> signUp(BuildContext context, analyticsController analControl) async {
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, 
          password: password,
        );
        String uid = user.uid;
        Firestore.instance.collection("users").document("$uid")
          .setData({"email" : "$email","name" : null,"age" : null,"gender" : null,
              "occupation" : null,"mobile" : null,"username" : "$name"});
        user.sendEmailVerification();
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => LoginPage(analControl: analControl)
          )
        );
      }
      catch(e){
        print(e.message);
      }
    }
  }
}