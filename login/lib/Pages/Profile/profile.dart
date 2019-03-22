import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/Pages/Profile/updateprofile.dart';
import 'package:login/prop-config.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({
    Key key,
    @required this.user
  }) : super(key: key);

  final FirebaseUser user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              onPressed: NavigateToUpdateProfile,
              child: Text(prompts.updateProfile),
          ),
          RaisedButton(
              onPressed: () {},
              child: Text(widget.user.email),
          ),
        ],
      ),
      ),
      ),
    );
  }
  void NavigateToUpdateProfile() {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => UpdateProfilePage(user: widget.user),
        fullscreenDialog: true
      )
    );
  }

}