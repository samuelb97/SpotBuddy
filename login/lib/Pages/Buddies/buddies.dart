import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/prop-config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  @override
  Widget build(BuildContext context) {
    _currentScreen();
    String userid = widget.user.uid;
    return Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('loading....');
              return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
              );
            }));
  }

  Future<Null> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: Screens.buddies,
      screenClassOverride: Screens.buddiesOver
    );
  }

  Future<Null> _sendAnalytics1() async{
    await widget.analytics.logEvent(
      name: Events.to_buddies,
      parameters: <String,dynamic>{}
    );
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  return ListTile(
    title: Row(
      children: [
        // Expanded(
        //   child: Text(
        //     "pls work",
        //     style: Theme.of(context).textTheme.headline,
        //   ),
        // ),
        Container(
            decoration: const BoxDecoration(
              color: Color(0xffdd),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      document['name'].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                            RaisedButton(
                              color: Colors.blue[800],
                              splashColor: Colors.green[300],
                              textTheme: ButtonTextTheme.primary,
                              padding: EdgeInsets.all(5.0),
                              elevation: 6,
                              shape: BeveledRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  color: Colors.grey[400],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              onPressed: () {
                                //ADD: enter chat
                              },
                              child: Text(Buttons.chat),
                            ),
                            

                            
                      ],
                    )
                  ]),
            ])),
      ],
    ),
  );
}
