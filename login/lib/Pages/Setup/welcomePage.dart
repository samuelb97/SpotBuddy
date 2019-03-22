import 'package:flutter/material.dart';
import 'package:login/Pages/Setup/logIn.dart';
import 'package:login/Pages/Setup/signUp.dart';
import 'package:login/prop-config.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headers.spotBuddy),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assets.image),
            fit: BoxFit.fitWidth,
          ),
        ),
        
        child: Container(
          /*this is a decoration for a box that encompasses the two buttons. wont work at same time as background image
          height: 180,
          width: 310,
          decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(18))
            ),
          */
          //child: IntrinsicWidth( only works in Center class not Container??
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                  onPressed: NavigateToSignIn,
                  child: Text(prompts.login),
                ),
                RaisedButton(
                  onPressed: NavigateToSignUp,
                  child: Text('     ' + prompts.signup + '     '),
                ),
              ],
            ),
          ),
          //),
       ),
     );
  }

  void NavigateToSignIn(){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => LoginPage(),
        fullscreenDialog: true
      )
    );
  }

  void NavigateToSignUp(){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
        fullscreenDialog: true
      )
    );
  }

}