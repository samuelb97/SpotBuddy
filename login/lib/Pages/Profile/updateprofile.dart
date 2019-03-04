import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/Pages/home.dart';

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
                    Text('Male'),
                    Radio (
                      value: 1,
                      groupValue: genderBtnValue,
                      onChanged: _handleGenderValueChange,
                    ),
                    Text('Female'),
                    Radio (
                      value: 2,
                      groupValue: genderBtnValue,
                      onChanged: _handleGenderValueChange,
                    ),
                    Text('Other'),
                  ]
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Occupation'),
                  maxLength: 32,
                  validator: validateOccupation,
                  onSaved: (input) => _occupation = input,
                ),
                TextFormField(
                    decoration: InputDecoration(hintText: 'Mobile Number'),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: validateMobile,
                    onSaved: (input) => _mobile = input,
                ),
                SizedBox(height: 15.0),
                RaisedButton(
                  onPressed: _update,
                  child: Text('Update'),
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
        _gender = 'male';
        break;
      case 1:
        _gender = 'female';
        break;
      case 2:
        _gender = 'other';
        break;
      default:
        _gender = 'male';
        break;
    }
    final formState = _formkey.currentState;
    final DocumentReference documentReference =
      Firestore.instance.document("users/${widget.user.uid}");
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
        print("Document Updated");
      }).catchError((e) => print(e));
    }
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }
  String validateAge(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Age is Required";
    }else if (!regExp.hasMatch(value)) {
      return "Age must be digits";
    }
    return null;
  }
  String validateOccupation(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Occupation is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Occupation must be a-z and A-Z";
    }
    return null;
  }
  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if(value.length != 10){
      return "Mobile number must 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }
  void _handleGenderValueChange(int value) {
    setState(() {
      genderBtnValue = value;
      print("GenderValue: $genderBtnValue");
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