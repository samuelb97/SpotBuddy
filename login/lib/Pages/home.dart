import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  
  Home({
    Key key,
    @required this.user
  }) : super(key: key);

  final FirebaseUser user;
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('SpotBuddy'),
        backgroundColor: Colors.lightGreen,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.
          collection('users').
          document(widget.user.uid).
          snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<DocumentSnapshot> snapshot
        ){
          if(snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return Center(
                child: Text(
                  'Welcome to SpotBuddy ${snapshot.data['name']}'
                ),
              );
          } //Switch
        },
      ),
    );
  }
}