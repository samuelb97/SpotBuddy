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
<<<<<<< HEAD
    widget.analControl.currentScreen('profile_page', 'ProfilePageOver');
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD

    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          const Color(0xFF413280),
          const Color(0xFF2B264A),
        ],
      ),
    );

=======
    widget.analControl.currentScreen(Screens.profile, Screens.profileOver);
>>>>>>> 293d74ebd7b329e349a82df90d0226ffcf25624f
    return Scaffold(
      body: Center(
        child: Container(
          decoration: linearGradient,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 120.0),
                height: MediaQuery.of(context).size.height * .25,
                child: Hero(
                  tag: "avatarTag",
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/dog.jpg"),
                    radius: 50.0,
                  ),
                ),
              ),
<<<<<<< HEAD
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                padding: EdgeInsets.all(10.0),
                child:Text(
                  '${widget.user.name}\n${widget.user.age}\n${widget.user.occupation}',
                  style: Theme.of(context).textTheme.body1
                    .merge(TextStyle(
                      color: Colors.white)
                    ),
                  textAlign:TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 70.0),
                height: MediaQuery.of(context).size.height * .26,
                width: MediaQuery.of(context).size.width * .4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: GoogleMap(
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(37.4219999, -122.0862462), zoom: 8),
                  onMapCreated: (GoogleMapController controller) {},
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  onPressed: () {
                    widget.analControl.sendAnalytics('to_update_profile');
                    _con.NavigateToUpdateProfile(
                        context, widget.analControl, widget.user);
                  },
                  child: Text(prompts.updateProfile),
                ),
              ),
            ],
=======
=======
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
>>>>>>> parent of f123d33... UserController
=======
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
>>>>>>> parent of f123d33... UserController
=======
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
>>>>>>> parent of f123d33... UserController
=======
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
>>>>>>> parent of f123d33... UserController
              onMapCreated: (GoogleMapController controller) {
                
              },
            ),
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
          ),
          RaisedButton(
              onPressed: (){
                widget.analControl.sendAnalytics(Events.update);
                _con.NavigateToUpdateProfile(context, widget.analControl, widget.user);
              },
              child: Text(Prompts.updateProfile),
>>>>>>> 293d74ebd7b329e349a82df90d0226ffcf25624f
=======
>>>>>>> parent of f123d33... UserController
=======
>>>>>>> parent of f123d33... UserController
          ),
          RaisedButton(
              onPressed: (){
=======
          ),
          RaisedButton(
              onPressed: (){
>>>>>>> parent of f123d33... UserController
                widget.analControl.sendAnalytics('to_update_profile');
                _con.NavigateToUpdateProfile(context, widget.analControl, widget.user);
              },
              child: Text(prompts.updateProfile),
          ),
=======
          ),
          RaisedButton(
              onPressed: (){
                widget.analControl.sendAnalytics('to_update_profile');
                _con.NavigateToUpdateProfile(context, widget.analControl, widget.user);
              },
              child: Text(prompts.updateProfile),
          ),
>>>>>>> parent of f123d33... UserController
        ],
      ),
      ),
      ),
    );
  }
}

