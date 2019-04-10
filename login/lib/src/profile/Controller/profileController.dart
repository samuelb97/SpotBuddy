import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/prop-config.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/src/profile/View/updateView.dart';
import 'package:login/src/profile/View/editInterestsView.dart';
import 'package:login/analtyicsController.dart';
import 'package:login/userController.dart';
import 'package:location/location.dart';

class Controller extends ControllerMVC {
  factory Controller() {
    if (_this == null) _this = Controller._();
    return _this;
  }
  static Controller _this;

  Controller._();

  static Controller get con => _this;

  static Future<void> updateLocation(BuildContext context,
      analyticsController analControl, userController user) async {
    LocationData currentLocation;

    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print(e.message);
      }
      currentLocation = null;
    }
    String uid = user.uid;
    var geopoint =
        new GeoPoint(currentLocation.latitude, currentLocation.longitude);
    Firestore.instance
        .collection("users")
        .document("$uid")
        .updateData({"location": geopoint});
  }

  Future NavigateToUpdateProfile(BuildContext context,
      analyticsController analControl, userController user) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UpdateProfilePage(user: user, analControl: analControl),
            fullscreenDialog: true));
  }

  Future NavigateToEditInterests(BuildContext context,
      analyticsController analControl, userController user) async {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditInterestsPage(user: user, analControl: analControl),
            fullscreenDialog: true));
  }
}
