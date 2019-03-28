import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/prop-config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfilePage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  UpdateProfilePage(
      {Key key, @required this.user, this.analytics, this.observer})
      : super(key: key);
  final FirebaseUser user;
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  String _name, _age, _gender, _occupation, _mobile;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  int genderBtnValue = 0;

  // Map<String, dynamic> userDetails = {};
  // Future<Null> getUser() async {
  //   await Firestore.instance
  //       .collection(Database.users)
  //       .document(widget.user.uid)  // Your user Document Name
  //       .get()
  //       .then((val) {
  //     userDetails.addAll(val.data);
  //   }).whenComplete(() {
  //     setState(() {});
  //   });
  // }
  String firstName = "";
  String lastName = "";
  // void getInfo() async {
  //   var user = await FirebaseAuth.instance.currentUser();
  //   var userQuery = Firestore.instance
  //       .collection(Database.users)
  //       .document(widget.user.uid)
  //       .get();
  // }

  @override
  void initState() {
    super.initState();
    //getInfo();
  }

  @override
  Widget build(BuildContext context) {
    _currentScreen();
    Firestore.instance.collection("users").document(widget.user.uid).snapshots();
    String userid = widget.user.uid;
    //Firestore.instance.collection('users').document(userid).snapshots();
    //String testname = DocumentSnapshot.fullName;
    //final notesReference = Firestore.instance.collection('users').document(userid).snapshots();

    return Scaffold(
        appBar: AppBar(
          //title: Text(Prompts.updateYourProfile),
          //title: Text("${userDetails.length+1}"),             //testing pull from database here
          title: Text(firstName),
          backgroundColor: Colors.lightGreen,
        ),
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
            }

            // SingleChildScrollView(
            //   child: Container(
            //     padding: EdgeInsets.all(25),
            //     child: Form(
            //       key: _formkey,
            //       child: Column(
            //         children: <Widget>[
            //           Text(
            //             "Your Account ID: $userid",
            //             style: TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 14.0,
            //                     fontWeight: FontWeight.bold,
            //                     ),
            //           ),
            //           TextFormField(
            //             decoration: const InputDecoration(
            //               icon: const Icon(Icons.person),
            //               hintText: Prompts.name,
            //               labelText: Userinfo.fullName,
            //             ),
            //             maxLength: 32,
            //             validator: validateName,
            //             onSaved: (input) => _name = input,
            //           ),
            //           TextFormField(
            //             decoration: InputDecoration(
            //               icon: const Icon(Icons.calendar_today),
            //               hintText: Prompts.age,
            //               labelText: Userinfo.age,
            //             ),
            //             maxLength: 2,
            //             validator: validateAge,
            //             onSaved: (input) => _age = input,
            //           ),
            //           Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Radio (
            //                 value: 0,
            //                 groupValue: genderBtnValue,
            //                 onChanged: _handleGenderValueChange,
            //               ),
            //               Text(Userinfo.gender0),
            //               Radio (
            //                 value: 1,
            //                 groupValue: genderBtnValue,
            //                 onChanged: _handleGenderValueChange,
            //               ),
            //               Text(Userinfo.gender1),
            //               Radio (
            //                 value: 2,
            //                 groupValue: genderBtnValue,
            //                 onChanged: _handleGenderValueChange,
            //               ),
            //               Text(Userinfo.gender2),
            //             ]
            //           ),
            //           TextFormField(
            //             decoration: InputDecoration(
            //               icon: const Icon(Icons.work),
            //               hintText: Prompts.occupation,
            //               labelText: Userinfo.occupation,
            //               ),
            //             maxLength: 32,
            //             validator: validateOccupation,
            //             onSaved: (input) => _occupation = input,
            //           ),
            //           TextFormField(
            //               decoration: InputDecoration(
            //                 icon: const Icon(Icons.phone),
            //                 hintText: Prompts.mobileNumber,
            //                 labelText: Userinfo.mobileNumber,
            //                 ),
            //               keyboardType: TextInputType.phone,
            //               maxLength: 10,
            //               validator: validateMobile,
            //               onSaved: (input) => _mobile = input,
            //           ),
            //           ButtonTheme(
            //             minWidth: 250,
            //             child: RaisedButton(
            //               color: Colors.green[800],
            //               splashColor: Colors.green[300],
            //               textTheme: ButtonTextTheme.primary,
            //               padding: EdgeInsets.all(20.0),
            //               elevation: 6,
            //               shape: BeveledRectangleBorder(
            //                 side: BorderSide(
            //                 width: 2.0,
            //                 color: Colors.grey[400],
            //               ),
            //               borderRadius: BorderRadius.circular(10),
            //               ),
            //               onPressed: (){
            //                 _sendAnalytics1();
            //                 _update();
            //               },
            //               child: Text(Userinfo.update),
            //             ),
            //           )
            //         ],
            //       ),
            //     )
            //   )
            // )
            ));
  }

  Future<Null> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: Screens.updateProfile,
      screenClassOverride: Screens.updateOver
    );
  }

  Future<Null> _sendAnalytics1() async {
    await widget.analytics.logEvent(
      name: Events.profileUpdated,
      parameters: <String,dynamic>{}
    );
  }

  Future<void> _update() async {
    switch (genderBtnValue) {
      case 0:
        _gender = Userinfo.gender0;
        break;
      case 1:
        _gender = Userinfo.gender1;
        break;
      case 2:
        _gender = Userinfo.gender2;
        break;
      default:
        _gender = Userinfo.gender0;
        break;
    }
    final formState = _formkey.currentState;
    final DocumentReference documentReference =
        Firestore.instance.document(Path.user + widget.user.uid);
    if (formState.validate()) {
      formState.save();
      print("name: $_name");
      Map<String, String> data = <String, String>{
        "name": _name,
        "occupation": _occupation,
        "age": _age,
        "mobile": _mobile,
        "gender": _gender,
      };
      documentReference.updateData(data).whenComplete(() {
        print(Prompts.updateDoc);
      }).catchError((e) => print(e));
    }
  }

  String validateName(String value) {
    RegExp regExp = new RegExp(Pattern.characters);
    if (value.length == 0) {
      return Requirements.name;
    } else if (!regExp.hasMatch(value)) {
      return Requirements.range;
    }
    return null;
  }

  String validateAge(String value) {
    RegExp regExp = new RegExp(Pattern.integers);
    if (value.length == 0) {
      return Requirements.age;
    } else if (!regExp.hasMatch(value)) {
      return Requirements.age_valid;
    }
    return null;
  }

  String validateOccupation(String value) {
    RegExp regExp = new RegExp(Pattern.characters);
    if (value.length == 0) {
      return Requirements.occupation;
    } else if (!regExp.hasMatch(value)) {
      return Requirements.occupation_valid;
    }
    return null;
  }

  String validateMobile(String value) {
    RegExp regExp = new RegExp(Pattern.integers);
    if (value.length == 0) {
      return Requirements.mobile;
    } else if (value.length != 10) {
      return Requirements.mobile_valid_1;
    } else if (!regExp.hasMatch(value)) {
      return Requirements.mobile_valid_2;
    }
    return null;
  }

  void _handleGenderValueChange(int value) {
    setState(() {
      genderBtnValue = value;
      print(Userinfo.gender + " $genderBtnValue");
    });
  }
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  return ListTile(
    title: Row(
      children: [
        Expanded(
          child: Text(
            document['name'],
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xffdd),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            document['votes'].toString(),
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ],
    ),
  );
}
