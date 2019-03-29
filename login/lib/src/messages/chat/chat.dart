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
import 'package:login/src/messages/chat/view/view.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key, this.analControl, @required this.user}) : super(key: key);

  final userController user;
  final analyticsController analControl;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),
              // Sticker
              (isShowSticker ? buildSticker() : Container()),
              // Input content
              buildInput(),
            ],
          ),
          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }
}
