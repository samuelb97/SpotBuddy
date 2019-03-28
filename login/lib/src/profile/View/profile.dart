import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/prop-config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login/analtyicsController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/src/profile/Controller/profileController.dart';

class ProfilePage extends StatefulWidget {

  ProfilePage({
    Key key,
    this.analControl,
    @required this.user
  }) : super(key: key);

  final FirebaseUser user;
  final analyticsController analControl;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends StateMVC<ProfilePage> {
  _ProfilePageState() : super(Controller()){
    _con = Controller.con;
  }
  Controller _con;

  @override
  Widget build(BuildContext context) {
    widget.analControl.currentScreen(Screens.profile, Screens.profileOver);
    return Scaffold(
      body: Center(
      child: IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .7,
            width: MediaQuery.of(context).size.width *.7,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.4219999, -122.0862462),
                zoom: 8
              ),
              onMapCreated: (GoogleMapController controller) {
                
              },
            ),
          ),
          RaisedButton(
              onPressed: (){
                widget.analControl.sendAnalytics(Events.update);
                _con.NavigateToUpdateProfile(context, widget.analControl, widget.user);
              },
              child: Text(Prompts.updateProfile),
          ),
        ],
      ),
      ),
      ),
    );
  }
}

