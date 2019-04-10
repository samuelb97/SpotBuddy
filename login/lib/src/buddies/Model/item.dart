import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:login/analtyicsController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:login/userController.dart';
import 'package:login/src/messages/chat/chat.dart';
import 'package:login/src/buddies/Model/buddy.dart';
import 'package:login/src/buddies/Controller/controller.dart';
import 'package:login/src/buddies/View/details_page.dart';

Controller buddyController;
String photo;
Widget buildItem(
    BuildContext context, DocumentSnapshot document, userController user, analyticsController analControl) {
  if (document.documentID == user.uid) {
    return Container();
  } else {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Material(
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      width: 50.0,
                      height: 50.0,
                      padding: EdgeInsets.all(15.0),
                    ),
                imageUrl:'${document.data['photoUrl']}',
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
                        style: TextStyle(color: Colors.lightGreen),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    Container(
                      child: Text(
                        'About me: ${document['age']}',
                        style: TextStyle(color: Colors.lightGreen),
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
          onPressed: () => buddyController._navigateToBuddyDetails(document),
        
    
        color: Colors.grey[700],
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
    );
  }
}
/*
Future _navigateToBuddyDetails(
      DocumentSnapshot document) 
      async {
    BuildContext context;
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BuddyDetailsPage(document),
        fullscreenDialog: true
      )
    );
}
*/