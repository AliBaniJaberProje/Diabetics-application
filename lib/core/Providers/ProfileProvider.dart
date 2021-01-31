import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PersonProfile {
  String username = "بيان منذر ";
  double weight = 55.6;
  double length = 75;
  DateTime dateBirth = DateTime.now();
  String phoneNumber = "0598420284";
  String location = "عقربا ";
  String id = "1122334455";
  String diabetesType = "النوع الاول ";
  File imagePerson = null;
  String imgurl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWtMDksH9GzFdMinyAkGbtLJNx6xynLETTNN5akjxirL3QD5Rj";
}

class ProfileProvider with ChangeNotifier {
  PersonProfile _person = new PersonProfile();
  //-----------------------------------------data-------------------------
  bool _updateweight = false;
  bool _updatelength = false;
  bool _updatephone = false;
  bool _updatelocation = false;

  final imagepicker = ImagePicker();
  //------------------------------------------ methods ------------------------
  void setPhoneNumber(String newName) {
    this._person.phoneNumber = newName;
  }

  void setUserName(String name) {
    _person.username = name;
    notifyListeners();
  }

  void setWeight(double weight) {
    _person.weight = weight;
    notifyListeners();
  }

  void setLength(double length) {
    _person.length = length;
    notifyListeners();
  }

  String getUserName() {
    return this._person.username;
  }

  double getWeight() {
    return this._person.weight;
  }

  double getLength() {
    return this._person.length;
  }

  String getImgUrl() {
    return this._person.imgurl;
  }

  void setImgUrl(String imgurl) {
    this._person.imgurl = imgurl;
  }

  String getDateBirth() {
    return this._person.dateBirth.year.toString() +
        "-" +
        this._person.dateBirth.month.toString() +
        "-" +
        this._person.dateBirth.day.toString();
  }

  String getPhoneNumber() {
    return this._person.phoneNumber;
  }

  String getId() {
    return this._person.id;
  }

  String getLocation() {
    return this._person.location;
  }

  File getImagePerson() {
    return this._person.imagePerson;
  }

  bool getUpdateweight() {
    return this._updateweight;
  }

  bool getUpdatelength() {
    return this._updatelength;
  }

  bool getUpdatephone() {
    return this._updatephone;
  }

  bool getUpdatelocation() {
    return this._updatelocation;
  }

  String getDiabetesType() {
    return this._person.diabetesType;
  }

  Future getImage(ImageSource src) async {
    _person.imagePerson = null;
    final pickedfile = await imagepicker.getImage(source: src);
    if (pickedfile != null) {
      _person.imagePerson = File(pickedfile.path);
    }
    notifyListeners();
  }

  void setLocation(String location) {
    _person.location = location;
    notifyListeners();
  }

  void togoleUpdateWeight() {
    this._updateweight = !this._updateweight;
    notifyListeners();
  }

  void togoleUpdateLength() {
    this._updatelength = !this._updatelength;
    notifyListeners();
  }

  void togoleUpdatPhone() {
    this._updatephone = !this._updatephone;
    notifyListeners();
  }

  void togoleUpdatlocation() {
    this._updatelocation = !this._updatelocation;
    notifyListeners();
  }
}
