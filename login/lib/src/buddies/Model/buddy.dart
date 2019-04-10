import 'dart:convert';
import 'package:meta/meta.dart';

class Buddy {
  Buddy({
    @required this.avatar,
    @required this.name,
    @required this.email,
    @required this.location,
    @required this.age,
    @required this.occupation,
  });

  final String avatar;
  final String age;
  final String name;
  final String email;
  final String occupation;
  final String location;

  static List<Buddy> allFromResponse(String response) {
    var decodedJson = json.decode(response).cast<String, dynamic>();

    return decodedJson['results']
        .cast<Map<String, dynamic>>()
        .map((obj) => Buddy.fromMap(obj))
        .toList()
        .cast<Buddy>();
  }

  static Buddy fromMap(Map map) {
    var name = map['name'];

    return new Buddy(
      avatar: map['picture']['large'],
      name: '${_capitalize(name['first'])} ${_capitalize(name['last'])}',
      email: map['email'],
      age: map['age'],
      occupation: map['occupation'],
      location: _capitalize(map['location']['state']),
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
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
                imageUrl: 'assets/dog.jpg',
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
                        'About me: ${document['aboutMe'] ?? 'Not available'}',
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
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat(
                        peerId: document.documentID,
                        peerName: document['name'],
                        peerAvatar: document['photoUrl'],
                        analControl: analControl,
                        user: user,
                      ),
                  fullscreenDialog: true));
        },
        color: Colors.grey[700],
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
    );
  }
  }

}