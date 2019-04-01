import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/analtyicsController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/analtyicsController.dart';
import 'package:login/userController.dart';
import 'package:login/src/welcome/signup/controller.dart';

class SignUpPage extends StatefulWidget {
  final analyticsController analControl;

  SignUpPage({Key key, this.analControl})
      : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends StateMVC<SignUpPage> {
  _SignUpPageState() : super(Controller()) {
    _con = Controller.con;
  }
  Controller _con;

  @override
  Widget build(BuildContext context) {
    widget.analControl.currentScreen('update_profile', 'updateProfileOver');
    return Scaffold(
        appBar: AppBar(
          title: Text(Prompts.signup),
          backgroundColor: Colors.lightGreen,
        ),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(15.0),
                child: Form(
                  key: _con.formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return Prompts.type_email;
                          }
                        },
                        onSaved: (input) => _con.set_email = input,
                        decoration: InputDecoration(labelText: Headers.email),
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input.length < 6) {
                            return Prompts.passwrd_valid;
                          }
                        },
                        onSaved: (input) => _con.set_password = input,
                        decoration: InputDecoration(labelText: Prompts.passwrd),
                        obscureText: true,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: Userinfo.fullName),
                        maxLength: 32,
                        //validator: _con.validateName,
                        onSaved: (input) => _con.set_name = input,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: Userinfo.age),
                        maxLength: 2,
                        //validator: _con.validateAge,
                        onSaved: (input) => _con.set_age = input,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: 0,
                              groupValue: _con.genderBtnValue,
                              onChanged: handleGenderValueChange,
                            ),
                            Text(Userinfo.gender0),
                            Radio(
                              value: 1,
                              groupValue: _con.genderBtnValue,
                              onChanged: handleGenderValueChange,
                            ),
                            Text(Userinfo.gender1),
                            Radio(
                              value: 2,
                              groupValue: _con.genderBtnValue,
                              onChanged: handleGenderValueChange,
                            ),
                            Text(Userinfo.gender2),
                          ]),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: Userinfo.occupation),
                        maxLength: 32,
                        //validator: _con.validateOccupation,
                        onSaved: (input) => _con.set_occupation = input,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: Userinfo.mobileNumber),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        //validator: _con.validateMobile,
                        onSaved: (input) => _con.set_mobile = input,
                      ),
                      SizedBox(height: 15.0),
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
                            //shape: OutlineInputBorder(),  //add this to shape above
                            //shape: Border.all(width: 2.0, color: Colors.grey[400]),
                            onPressed: () {
                              widget.analControl.sendAnalytics('profileUpdate');
                              widget.analControl.sendAnalytics('new_sign_up');
                              widget.analControl
                                  .currentScreen('sign_up', 'SignUpOver');
                              Controller.signUp(
                                  context, widget.analControl);
                            },
                            child: Text(Prompts.signup),
                          ))
                    ],
                  ),
                ))));
  }

  void handleGenderValueChange(int value) {
    setState(() {
      _con.set_gender = value;
      print(Userinfo.gender + " ${_con.genderBtnValue}");
    });
  }
}