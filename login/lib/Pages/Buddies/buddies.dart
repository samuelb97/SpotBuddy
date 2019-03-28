import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:login/Pages/Buddies/buddy_details_page.dart';
import 'package:login/Pages/Buddies/buddy.dart';

class BuddiesPage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  BuddiesPage({Key key, @required this.user, this.analytics, this.observer})
      : super(key: key);

  final FirebaseUser user;
  @override
  _BuddiesPageState createState() => _BuddiesPageState();
}

class _BuddiesPageState extends State<BuddiesPage> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  List<Buddy> _buddies = [];

  @override
  void initState() {
    super.initState();
    _loadBuddies();
  }

  Future<void> _loadBuddies() async {
    http.Response response =
        await http.get('https://randomuser.me/api/?results=25');

    setState(() {
      _buddies = Buddy.allFromResponse(response.body);
    });
  }

  Widget _buildBuddyListTile(BuildContext context, int index) {
    var buddy = _buddies[index];

    return new ListTile(
      onTap: () => _navigateToBuddyDetails(buddy, index),
      leading: new Hero(
        tag: index,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(buddy.avatar),
        ),
      ),
      title: new Text(buddy.name),
      subtitle: new Text(buddy.email),
    );
  }

  void _navigateToBuddyDetails(Buddy buddy, Object avatarTag) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new BuddyDetailsPage(buddy, avatarTag: avatarTag);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_buddies.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: _buddies.length,
        itemBuilder: _buildBuddyListTile,
      );
    }

    return new Scaffold(
      body: content,
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     _currentScreen();
//     String userid = widget.user.uid;
//     return Scaffold(
//         body: StreamBuilder(
//             stream: Firestore.instance.collection('users').snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) return const Text('loading....');
//               return ListView.builder(
//                 itemExtent: 80.0,
//                 itemCount: snapshot.data.documents.length,
//                 itemBuilder: (context, index) =>
//                     _buildListItem(context, snapshot.data.documents[index]),
//               );
//             }));
//   }

// //   Future<Null> _currentScreen() async {
// //     await widget.analytics.setCurrentScreen(
// //       screenName: Screens.buddies,
// //       screenClassOverride: Screens.buddiesOver
// //     );
// //   }

// //   Future<Null> _sendAnalytics1() async{
// //     await widget.analytics.logEvent(
// //       name: Events.to_buddies,
// //       parameters: <String,dynamic>{}
// //     );
// //   }
// // }

// Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
//   return ListTile(
//     title: Row(
//       children: [
//         Container(
//             decoration: const BoxDecoration(
//               color: Color(0xffdd),
//             ),
//             padding: const EdgeInsets.all(10.0),
//             child: Column(children: <Widget>[
//               Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       document['name'].toString(),
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 30.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Column(
//                       children: <Widget>[
//                             RaisedButton(
//                               color: Colors.blue[800],
//                               splashColor: Colors.green[300],
//                               textTheme: ButtonTextTheme.primary,
//                               padding: EdgeInsets.all(5.0),
//                               elevation: 6,
//                               shape: BeveledRectangleBorder(
//                                 side: BorderSide(
//                                   width: 2.0,
//                                   color: Colors.grey[400],
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               onPressed: () {
//                                 //ADD: enter chat
//                               },
//                               child: Text(Buttons.chat),
//                             ),  
//                       ],
//                     )
//                   ]),
//             ])),
//       ],
//     ),
//   );
// }
