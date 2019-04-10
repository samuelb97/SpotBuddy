import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class userController{
  factory userController() {
    if (_this == null) _this = userController._();
    return _this;
  }
  static userController _this;

  userController._();

  static userController get userCon => _this;

  LocationData _location;
  static String _uid;
  static String _age;
  static String _gender;
  static String _mobile;
  static String _name;
  static String _occupation;
  static List _interests;
  static var _latitude;
  static var _longitude;

  set set_uid(String uid){
    _uid = uid;
  }

  String get uid => _uid;
  String get name => _name;
  String get age => _age;
  String get gender => _gender;
  String get mobile => _mobile;
  String get occupation => _occupation;
  List get interests => _interests;
  

  Future load_data_from_firebase() async {
    Firestore.instance.collection('users').document(_uid)
      .get().then((DocumentSnapshot){
        print('Load Data From Firebase');
        print(DocumentSnapshot.data['name'].toString());
        _age = DocumentSnapshot.data['age'].toString();
        _gender = DocumentSnapshot.data['gender'].toString();
        _mobile = DocumentSnapshot.data['mobile'].toString();
        _name = DocumentSnapshot.data['name'].toString();
        _occupation = DocumentSnapshot.data['occupation'].toString();
        _interests = DocumentSnapshot.data['interests'];
        print('Interests After Load: ${_interests[0]}');
      }
    );
  }

  Future<LatLng> getUserLocation() async {
    final _getLocation = Location();
    try {
      _location = await _getLocation.getLocation();
      final lat = _location.latitude;
      final lng = _location.longitude;
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      _location = null;
      return null;
    }
  }
}