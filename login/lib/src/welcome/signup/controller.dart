import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/src/welcome/login/view.dart';
import 'package:login/analtyicsController.dart';
import 'package:login/prop-config.dart';
import 'package:login/userController.dart';

class Controller extends ControllerMVC {
  factory Controller() {
    if (_this == null) _this = Controller._();
    return _this;
  }
  static Controller _this;

  Controller._();

  static String email, password, name, age, gender, occupation, mobile;
  static int _genderBtnValue = 0;

  GlobalKey<FormState> get formkey => _formkey;

  static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  int get genderBtnValue => _genderBtnValue;

  set set_email(String _email) {
    email = _email;
  }
  set set_password(String _password) {
    password = _password;
  }
  set set_name(String _name) {
    name = _name;
  }
  set set_age(String _age) {
    age = _age;
  }
  set set_gender(int g_Val) {
    _genderBtnValue = g_Val;
  }
  set set_occupation(String _occupation) {
    occupation = _occupation;
  }
  set set_mobile(String _mobile) {
    mobile = _mobile;
  }

  static Controller get con => _this;

  Future<void> update(userController user) async {
    switch (_genderBtnValue) {
      case 0:
        gender = user_info.gender0;
        break;
      case 1:
        gender = user_info.gender1;
        break;
      case 2:
        gender = user_info.gender2;
        break;
      default:
        gender = user_info.gender0;
        break;
    }
    final formState = _formkey.currentState;
    final DocumentReference documentReference =
        Firestore.instance.document(path.user + user.uid);
    if (formState.validate()) {
      formState.save();
      print("name: $name");
      Map<String, String> data = <String, String>{
        "name": name,
        "occupation": occupation,
        "age": age,
        "mobile": mobile,
        "gender": gender,
      };
      documentReference.updateData(data).whenComplete(() {
        print(prompts.updateDoc);
      }).catchError((e) => print(e));
    }
  }

  static Future<void> signUp(BuildContext context,
      analyticsController analControl, userController user) async {
    switch (_genderBtnValue) {
      case 0:
        gender = user_info.gender0;
        break;
      case 1:
        gender = user_info.gender1;
        break;
      case 2:
        gender = user_info.gender2;
        break;
      default:
        gender = user_info.gender0;
        break;
    }
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = user.uid;
        Firestore.instance.collection("users").document("$uid").setData({
          "email": "$email",
          "name": null,
          "age": null,
          "gender": null,
          "occupation": null,
          "mobile": null,
          "username": "$name"
        });
        user.sendEmailVerification();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(analControl: analControl)));
        final DocumentReference documentReference =
            Firestore.instance.document(path.user + user.uid);
        if (formState.validate()) {
          formState.save();
          print("name: $name");
          Map<String, String> data = <String, String>{
            "name": name,
            "occupation": occupation,
            "age": age,
            "mobile": mobile,
            "gender": gender,
          };
          documentReference.updateData(data).whenComplete(() {
            print(prompts.updateDoc);
          }).catchError((e) => print(e));
        }
      } catch (e) {
        print(e.message);
      }
    }
  }

  String validateName(String value) {
    Pattern patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return requirements.name;
    } else if (!regExp.hasMatch(value)) {
      return requirements.range;
    }
    return null;
  }
  String validateAge(String value) {
    Pattern patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return requirements.age;
    } else if (!regExp.hasMatch(value)) {
      return requirements.age_valid;
    }
    return null;
  }
  String validateOccupation(String value) {
    Pattern patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return requirements.occupation;
    } else if (!regExp.hasMatch(value)) {
      return requirements.occupation_valid;
    }
    return null;
  }
  String validateMobile(String value) {
    Pattern patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return requirements.mobile;
    } else if (value.length != 10) {
      return requirements.mobile_valid_1;
    } else if (!regExp.hasMatch(value)) {
      return requirements.mobile_valid_2;
    }
    return null;
  }
}
