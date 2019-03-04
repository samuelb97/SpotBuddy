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
  bool _validate = false;
  final GlobalKey<FormState> 
    _formkey = GlobalKey<FormState>();
  final DocumentReference documentReference =
      Firestore.instance.document("users/testing");   //need to link this to specific UID
  
  void _update() {    //need to call variables in line 22
    Map<String, String> data = <String, String>{
      "name": _name,
      "occupation": "student",
      "age" : "21"
    };
    documentReference.updateData(data).whenComplete(() {
      print("Document Updated");
    }).catchError((e) => print(e));
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Your Profile'),
        backgroundColor: Colors.lightGreen,
      ),
      body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _formkey,
              autovalidate: _validate,
              child: FormUI(),
            ),
          ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Full Name'),
          maxLength: 32,
          validator: validateName,
          onSaved: (String val) {
            _name = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Age'),
          maxLength: 2,
          validator: validateAge,
          onSaved: (String val) {
            _age = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Gender'),
          maxLength: 12,
          validator: validateGender,
          onSaved: (String val) {
            _gender = val;
          },
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Occupation'),
          maxLength: 32,
          validator: validateOccupation,
          onSaved: (String val) {
            _occupation = val;
          },
        ),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Mobile Number'),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: validateMobile,
            onSaved: (String val) {
              _mobile = val;
            }),
        new SizedBox(height: 15.0),
        new RaisedButton(
          onPressed: _update,
          child: new Text('Update'),
        )
      ],
    );
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
  String validateGender(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Gender is Required";
    }else if (!regExp.hasMatch(value)) {
      return "Gender must be a-z and A-Z";
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