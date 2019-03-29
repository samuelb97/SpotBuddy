import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:login/analtyicsController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:login/userController.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MessagesPage extends StatefulWidget {
  MessagesPage({Key key, this.analControl, @required this.user})
      : super(key: key);

  final userController user;
  final analyticsController analControl;

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document['id'] == widget.user.uid) {
      print('\n\nDoc ID IF HIT\n\n');
      return Container();
    } else {
      print('\n\nDoc ID ELSE HIT\n\n');
      return Container(
        child: FlatButton(
          // onPressed: () {
          //   Navigator.push(
          //       context,
          //      MaterialPageRoute(
          //           builder: (context) => Chat(
          //                 peerId: document.documentID,
          //                 peerAvatar: document['photoUrl'],
          //             )));
          // },
          color: Colors.grey,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: <Widget>[
              Material(
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                        ),
                        width: 50.0,
                        height: 50.0,
                        padding: EdgeInsets.all(15.0),
                      ),
                  imageUrl:
                      "assets/dog.jpg", //TODO:profile pic image url from database
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${document['name']}',
                          style: TextStyle(color: Colors.black),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'test',
                          style: TextStyle(color: Colors.black),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.user.load_data_from_firebase();
    widget.analControl.currentScreen(Screens.search, Screens.searchOver);

    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) =>
                    buildItem(context, snapshot.data.documents[index]),
                itemCount: snapshot.data.documents.length,
              );
            }
          },
        ),
      )
    );
  }
}
