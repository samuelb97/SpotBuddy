import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:login/analtyicsController.dart';
import 'package:login/userController.dart';
import 'package:login/src/settings/supportView.dart';
import 'package:login/src/settings/controller.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({
    Key key,
    this.analControl,
    @required this.user
  }) : super(key: key);

  final userController user;
  final analyticsController analControl;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              onPressed: () {},
              child: Text(Headers.settings),
          ),
          ButtonTheme( 
              minWidth: 250,
            child: RaisedButton(
              color: Colors.green[800],
              splashColor: Colors.green[300],
              textTheme: ButtonTextTheme.primary,
              padding: EdgeInsets.all(20.0),
              elevation: 6,
              shape: BeveledRectangleBorder(
                side: BorderSide(
                  width: 2.0, 
                  color: Colors.deepPurple[800],
                ), 
                borderRadius: BorderRadius.circular(10), 
              ),
              onPressed: () { 
                      Controller.navigateToSupport();
              },
              child: Text(Prompts.support),
          ),
          )
        ],
      ),
    );
  

  
}