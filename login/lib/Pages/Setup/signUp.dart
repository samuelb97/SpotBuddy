import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/Pages/Setup/logIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/prop-config.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password, _name;
  final GlobalKey<FormState> 
    _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prompts.signup),
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
               if(input.isEmpty){
                 return prompts.name;
               } 
              },
              onSaved: (input) => _name = input,
              decoration: InputDecoration(
                labelText: headers.username
              ),
            ),
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
              onPressed: signUp,
              child: Text(prompts.signup),

            )
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email:_email, 
          password: _password,
        );
        String uid = user.uid;
        Firestore.instance.collection("users").document("$uid")
          .setData({"email" : "$_email","name" : null,"age" : null,"gender" : null,
              "occupation" : null,"mobile" : null,"username" : "$_name"});
        user.sendEmailVerification();
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context) => LoginPage()
          )
        );
      }
      catch(e){
        print(e.message);
      }
    }
  }
}