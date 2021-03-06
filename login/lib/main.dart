import 'package:flutter/material.dart';
import 'package:login/src/welcome/view.dart';
import 'package:login/prop-config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:login/analtyicsController.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() => runApp(MyApp());
  // This widget is the root of your application.

class MyApp extends StatelessWidget {
  Future <Map<PermissionGroup, PermissionStatus>> permissions = 
    PermissionHandler().
      requestPermissions([PermissionGroup.location]);
  
  Function() {
    print(PermissionStatus.values);
  }

  final _analyticsController = analyticsController();

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: headers.spotBuddy + prompts.login,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      navigatorObservers: <NavigatorObserver>[_analyticsController.observer],
      home: WelcomePage(
        thisAnalyticsController: _analyticsController),
    );
    return materialApp;
  }
}


