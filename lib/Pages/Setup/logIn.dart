import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/Pages/home.dart';
import 'package:login/prop_config.dart';

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
        title: Text(prompts.login),
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
              onPressed: signIn,
              child: Text(prompts.login),
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
          title: Text(prompts.email_verif),
          content: Text(
            prompts.email_err_1 +
            prompts.email_err_2 +
            '${user.email}'
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(headers.resend),
              onPressed: () {
                user.sendEmailVerification();
              },
            ),
            FlatButton(
              child: Text(headers.close),
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