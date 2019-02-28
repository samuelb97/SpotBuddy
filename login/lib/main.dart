import 'package:flutter/material.dart';
import 'package:login/Pages/Setup/welcomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

  // This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: 'SpotBuddy Login',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: WelcomePage(),
    );
    return materialApp;
  }
}


