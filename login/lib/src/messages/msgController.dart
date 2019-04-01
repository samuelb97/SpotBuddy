import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
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
import 'dart:async';
import 'dart:io';

class MsgController extends ControllerMVC {
  factory MsgController() {
    if (_this == null) _this = MsgController._();
    return _this;
  }
  static MsgController _this;
  MsgController._();
  static MsgController get con => _this;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

}