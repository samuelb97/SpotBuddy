import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/Pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {  
  String _email, _password;
  final GlobalKey<FormState> 
    _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Form(
        key: _formkey,
        //TODO: implement key
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
               if(input.isEmpty){
                 return 'Please type and email';
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
              onPressed: signIn,
              child: Text('Sign in'),

            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        final FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email:_email, 
          password: _password,
        );
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => Home()
          )
        );
          //TODO: Navigate to home
      }
      catch(e){
        print(e.message);
      }
      

    }
   
  }
}