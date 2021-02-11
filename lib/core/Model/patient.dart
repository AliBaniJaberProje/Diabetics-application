import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Patient {
  String _id;
  String _username;
  String _idCurantDoctur;
  String _imgurl;
  String _phoneNumber;
  String _location;
  double _length;
  double _weight;
  Timestamp _dateBirth;
  String _diabtesType;

  List<dynamic> _lastdoctor = [];
  String getFromLastDoctor(int index) {
    return this._lastdoctor[index];
  }

  Patient(
      {String id,
      String username,
      String idCurantDoctur,
      String imgurl,
      String phoneNumber,
      String location,
      double length,
      double weight,
      Timestamp dateBirth,
      String diabtesType,
      List<dynamic> lastDoctor}) {
    this._id=id;
    this._username=username;
    this._idCurantDoctur=idCurantDoctur;
    this._imgurl=imgurl;
    this._phoneNumber=phoneNumber;
    this._location=location;
    this._length=length;
    this._weight=weight;
    this._dateBirth=dateBirth;
    this._diabtesType=diabtesType;
    this._lastdoctor=lastDoctor;


  }


  set imgurl(String value) {
    _imgurl = value;
  }

  List<dynamic> get lastdoctor => _lastdoctor;

  Timestamp get dateBirth => _dateBirth;

  String get diabtesType => _diabtesType;

  double get weight => _weight;

  double get length => _length;

  String get location => _location;

  String get phoneNumber => _phoneNumber;

  String get imgurl => _imgurl;

  String get idCurantDoctur => _idCurantDoctur;

  String get username => _username;

  String get id => _id;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  set location(String value) {
    _location = value;
  }

  set length(double value) {
    _length = value;
  }

  set weight(double value) {
    _weight = value;
  }
}
