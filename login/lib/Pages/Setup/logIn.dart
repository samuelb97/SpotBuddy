import 'package:flutter/material.dart';
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
        title: Text('Log In'),
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
              child: Text('Log In'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email, 
          password: _password,
        );
        if(user.isEmailVerified){
            Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => Home(user: user)
            )
          );
        }
        else {
          _ShowEmailNotVerifiedAlert(user);
        }
      }
      catch(e){
        print(e.message);
      }
    }
  }

  void _ShowEmailNotVerifiedAlert(FirebaseUser user){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Email not Verified'),
          content: Text(
            'Your email has not been verified '
            'please click the verification link sent to '
            '${user.email}'
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Resend Email'),
              onPressed: () {
                user.sendEmailVerification();
              },
            ),
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    
  }
}