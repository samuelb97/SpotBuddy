import 'package:flutter/material.dart';
import 'package:login/Pages/Setup/welcomePage.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
//import 'dart:async';
import 'package:login/prop-config.dart';

void main() => runApp(MyApp());
  // This widget is the root of your application.
class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: Headers.spotBuddy + Prompts.login,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: WelcomePage(analytics: analytics, observer: observer),
    );
    return materialApp;
  }
}


