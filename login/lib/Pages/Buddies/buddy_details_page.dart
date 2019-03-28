import 'package:flutter/material.dart';
import 'package:login/footer/buddy_detail_footer.dart';
import 'package:login/header/buddy_detail_header.dart';
import 'package:login/Pages/Buddies/buddy_detail_body.dart';
import 'package:login/Pages/Buddies/buddy.dart';

import 'package:meta/meta.dart';

class BuddyDetailsPage extends StatefulWidget {
  BuddyDetailsPage(
    this.buddy, {
    @required this.avatarTag,
  });

  final Buddy buddy;
  final Object avatarTag;

  @override
  _BuddyDetailsPageState createState() => new _BuddyDetailsPageState();
}

class _BuddyDetailsPageState extends State<BuddyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          const Color(0xFF413070),
          const Color(0xFF2B264A),
        ],
      ),
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new BuddyDetailHeader(
                widget.buddy,
                avatarTag: widget.avatarTag,
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new BuddyDetailBody(widget.buddy),
              ),
              new BuddyShowcase(widget.buddy),
            ],
          ),
        ),
      ),
    );
  }
}
