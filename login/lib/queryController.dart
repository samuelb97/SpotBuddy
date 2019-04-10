import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:login/userController.dart';


class queryController{
  factory queryController(){
    if(_this == null) _this =queryController._();
    return _this;
  }
  static queryController _this;

  Geoflutterfire geo = Geoflutterfire();

  queryController._();

  static queryController get queryCon => _this;

  Future get_buddies_near(userController user) async{
    var users = Firestore.instance.collection('users');
    GeoFirePoint center = geo.point(latitude: user.latitude, longitude: user.longitude); //User's geolocation

    var usersRef = users.where("interests", arrayContains: user.interests);
    
    Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: usersRef).within(center: center, radius: user.range, field: 'location');
    
  }
}