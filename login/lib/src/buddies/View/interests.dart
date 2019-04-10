import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:login/analtyicsController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/src/messages/msgController.dart';
import 'package:login/userController.dart';

class InterestPage extends StatefulWidget {
  InterestPage({Key key, this.analControl, @required this.user})
      : super(key: key);

  final userController user;
  final analyticsController analControl;

  @override
  State createState() => _InterestPageState();
}

class _InterestPageState extends StateMVC<InterestPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            // List
            Container(
              child: StreamBuilder(
                stream: Firestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemExtent: 10.0,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('entry example.');
                        },
                      itemCount: snapshot.data.documents.length,
                    );
                  
                }
              ),
            ),
 
          ],
        ),
    );
  }
}