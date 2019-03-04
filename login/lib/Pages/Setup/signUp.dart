import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/Pages/Setup/logIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: Text('Sign Up'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Form(
        key: _formkey,
        //TODO: implement key
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
               if(input.isEmpty){
                 return 'Enter Your Name';
               } 
              },
              onSaved: (input) => _name = input,
              decoration: InputDecoration(
                labelText: 'Username'
              ),
            ),
            TextFormField(
              validator: (input) {
               if(input.isEmpty){
                 return 'Please type your email';
               } 
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
             TextFormField(
              validator: (input) {
               if(input.length < 6){
                 return 'Password must be longer than 6 characters';
               } 
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signUp,
              child: Text('Sign Up'),

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
          .setData({"email" : "$_email"});
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