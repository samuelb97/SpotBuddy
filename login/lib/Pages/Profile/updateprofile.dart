import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/Pages/home.dart';
import 'package:login/prop-config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfilePage extends StatefulWidget {

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  UpdateProfilePage({
    Key key,
    @required this.user,
    this.analytics, 
    this.observer
  }) : super(key: key);

  final FirebaseUser user;

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> { 
    static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics); 
  String _name, _age, _gender, _occupation, _mobile;
  final GlobalKey<FormState> 
    _formkey = GlobalKey<FormState>();
     //need to link this to specific UID
  int genderBtnValue = 0;

  @override
  Widget build(BuildContext context) {
    _currentScreen();
    Firestore.instance.collection('users').document(widget.user.uid).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(prompts.updateYourProfile),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                
                TextFormField(
                  decoration: InputDecoration(hintText: widget.user.uid),
                  maxLength: 32,
                  validator: validateName,
                  onSaved: (input) => _name = input,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: user_info.age),
                  maxLength: 2,
                  validator: validateAge,
                  onSaved: (input) => _age = input,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio (
                      value: 0,
                      groupValue: genderBtnValue,
                      onChanged: _handleGenderValueChange,
                    ),
                    Text(user_info.gender0),
                    Radio (
                      value: 1,
                      groupValue: genderBtnValue,
                      onChanged: _handleGenderValueChange,
                    ),
                    Text(user_info.gender1),
                    Radio (
                      value: 2,
                      groupValue: genderBtnValue,
                      onChanged: _handleGenderValueChange,
                    ),
                    Text(user_info.gender2),
                  ]
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: user_info.occupation),
                  maxLength: 32,
                  validator: validateOccupation,
                  onSaved: (input) => _occupation = input,
                ),
                TextFormField(
                    decoration: InputDecoration(hintText: user_info.mobileNumber),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: validateMobile,
                    onSaved: (input) => _mobile = input,
                ),
                SizedBox(height: 15.0),
                RaisedButton(
                  onPressed: (){
                    _sendAnalytics1();
                    _update();
                  },
                  child: Text(user_info.update),
                )
              ],
            ),
          )
        )
      )
    );
  }

  Future<Null> _currentScreen() async{
    await widget.analytics.setCurrentScreen(
      screenName: 'update_profile_page',
      screenClassOverride: 'UpdateProfilePageOver'
    );
  }

  Future<Null> _sendAnalytics1() async{
    await widget.analytics.logEvent(
      name: 'profile_update_successful',
      parameters: <String,dynamic>{}
    );
  }

  Future<void> _update() async {
    switch (genderBtnValue) {
      case 0:
        _gender = user_info.gender0;
        break;
      case 1:
        _gender = user_info.gender1;
        break;
      case 2:
        _gender = user_info.gender2;
        break;
      default:
        _gender = user_info.gender0;
        break;
    }
    final formState = _formkey.currentState;
    final DocumentReference documentReference =
      Firestore.instance.document(path.user + widget.user.uid);
    if(formState.validate()){
      formState.save();
      print("name: $_name");
      Map<String, String> data = <String, String>{
      "name": _name,
      "occupation": _occupation,
      "age" : _age,
      "mobile" :_mobile,
      "gender" :_gender,
    };
    documentReference.updateData(data)
      .whenComplete(() {
        print(prompts.updateDoc);
      }).catchError((e) => print(e));
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
    }else if (!regExp.hasMatch(value)) {
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
    } else if(value.length != 10){
      return requirements.mobile_valid_1;
    }else if (!regExp.hasMatch(value)) {
      return requirements.mobile_valid_2;
    }
    return null;
  }
  void _handleGenderValueChange(int value) {
    setState(() {
      genderBtnValue = value;
      print(user_info.gender + " $genderBtnValue");
    });
  }
}