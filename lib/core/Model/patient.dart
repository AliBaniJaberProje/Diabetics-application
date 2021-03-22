import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  String _id;
  String _username;
  String gender;
  String location;
  DateTime _dateBirth;
  Timestamp _diagnosisYear;
  String phoneNumber;
  String _diabtesType;
  String _injectionType;
  String _capsuleType;
  double length;
  double weight;

  String imgurl;

  Patient(
      {String id,
      String username,
      String idCurantDoctur,
      String imgurl,
      String phoneNumber,
      String location,
      double length,
      double weight,
      DateTime dateBirth,
      String diabtesType,
      Timestamp diagnosisYear,
      String injectionType,
      String capsuleType,
      List<dynamic> lastDoctor}) {
    this._id = id;
    this._username = username;

    this.imgurl = imgurl;
    this.phoneNumber = phoneNumber;
    this.location = location;
    this.length = length;
    this.weight = weight;
    this._dateBirth = dateBirth;
    this._diabtesType = diabtesType;

    this._diagnosisYear = diagnosisYear;
    this._injectionType = injectionType;
    this._capsuleType = capsuleType;
  }

  Timestamp get diagnosisYear => _diagnosisYear;

  DateTime get dateBirth => _dateBirth;
  String get diabtesType => _diabtesType;

  String get username => _username;
  String get id => _id;
  String get injectionType => _injectionType;
  String get capsuleType => _capsuleType;
}
