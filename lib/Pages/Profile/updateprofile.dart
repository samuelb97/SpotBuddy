import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/Pages/home.dart';
import 'package:login/prop_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfilePage extends StatefulWidget {

  UpdateProfilePage({
    Key key,
    @required this.user
  }) : super(key: key);

  final FirebaseUser user;

 @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {  
  String _name, _age, _gender, _occupation, _mobile;
  final GlobalKey<FormState> 
    _formkey = GlobalKey<FormState>();
     //need to link this to specific UID
  int genderBtnValue = 0;

  bool _validate = false;

  final DocumentReference documentReference =
      Firestore.instance.document("users/testing");   //need to link this to specific UID  
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Your Profile'),
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
                  decoration: InputDecoration(hintText: 'Full Name'),
                  maxLength: 32,
                  validator: validateName,
                  onSaved: (input) => _name = input,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Age'),
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
                  onPressed: _update,
                  child: Text(user_info.update),
                )
              ],
            ),
          )
        )
      )
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
      Firestore.instance.document("users/${widget.user.uid}");
    if(formState.validate()){
      formState.save();
      print(user_info.fullName +" $_name");
      Map<String, String> data = <String, String>{
     user_info.fullName: _name,
      user_info.occupation: _occupation,
      user_info.age : _age,
      user_info.mobileNumber :_mobile,
      user_info.gender :_gender,
    };
    documentReference.updateData(data)
      .whenComplete(() {
        print(prompts.updateDoc);
      }).catchError((e) => print(e));
    }
  }

  String validateName(String value) {
    RegExp regExp = new RegExp(pattern.characters);
    if (value.length == 0) {
      return requirements.name;
    } else if (!regExp.hasMatch(value)) {
      return requirements.range;
    }
    return null;
  }
  String validateAge(String value) {
    RegExp regExp = new RegExp(pattern.integers);
    if (value.length == 0) {
      return requirements.age;
    }else if (!regExp.hasMatch(value)) {
      return requirements.age_valid;
    }
    return null;
  }
  String validateGender(String value) {
    RegExp regExp = new RegExp(pattern.characters);
    if (value.length == 0) {
      return requirements.gender;
    }else if (!regExp.hasMatch(value)) {
      return requirements.gender_valid;
    }
    return null;
  }
  String validateOccupation(String value) {
    RegExp regExp = new RegExp(pattern.characters);
    if (value.length == 0) {
      return requirements.occupation;
    } else if (!regExp.hasMatch(value)) {
      return requirements.occupation_valid;
    }
    return null;
  }
  String validateMobile(String value) {
    RegExp regExp = new RegExp(pattern.integers);
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
      print( user_info.gender + " $genderBtnValue");
    });
  }
/*
  _sendToServer() {
    if (_formkey.currentState.validate()) {
      // No any error in validation
      _formkey.currentState.save();
      print("Name $_name");
      print("Age $_age");
      print("Gender $_gender");
      print("Occupation $_occupation");
      print("Mobile $_mobile");
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
*/
} 