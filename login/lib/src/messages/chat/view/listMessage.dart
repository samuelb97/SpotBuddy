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

Widget buildListMessage() {
  return Flexible(
    child: groupChatId == ''
        ? Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
        : StreamBuilder(
            stream: Firestore.instance
                .collection('messages')
                .document(groupChatId)
                .collection(groupChatId)
                .orderBy('timestamp', descending: true)
                .limit(20)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
              } else {
                listMessage = snapshot.data.documents;
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) =>
                      buildItem(index, snapshot.data.documents[index]),
                  itemCount: snapshot.data.documents.length,
                  reverse: true,
                  controller: listScrollController,
                );
              }
            },
          ),
  );
}
