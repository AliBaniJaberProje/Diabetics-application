import 'dart:io';

import 'package:ali_muntaser_final_project/core/Model/patient.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/updateProfileInfo_Servers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class ProfileProvider with ChangeNotifier {
  Patient _patient = new Patient();
  //-----------------------------------------data-------------------------
  bool _updateWeight = false;
  bool _updateLength = false;
  bool _updatePhone = false;
  bool _updateLocation = false;
  File _imagePerson;
  final imagePicker = ImagePicker();

  ///----------------------------- private method-------------------------------
  bool _isValidPhoneNumber(String phoneNumber)  {
    if(phoneNumber.isEmpty)return false;
    if(phoneNumber==this._patient.phoneNumber)return false ;
    if(phoneNumber.length<10) return false;
    final numericRegex =
    RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(phoneNumber);


  }
  bool _isValidWeight(double value){
    if(value==this._patient.weight)return false;
    if(value<10)return false;
    return true;

  }
  bool _isValidLength(double value){
    if(value==this._patient.length)return false;
    if(value<10)return false;
    return true;
  }
  bool _isValidLocation(String loation){
    if(loation==this._patient.location)return false;
    if(loation.isEmpty) return false;
    if(loation.length<3) return false ;
    return true;

  }


  ///------------------------------------------ methods ------------------------
  // ignore: unnecessary_getters_setters
  Patient get patient =>_patient;

  String getCapsuleType(){
    return this._patient.capsuleType;
  }
  String getInjectionType(){
    return this._patient.injectionType;
  }
  String getDiagnosisYear(){
    return DateFormat.yMMMd().format(this._patient.diagnosisYear.toDate()).toString();
  }

  // ignore: unnecessary_getters_setters
  set person(Patient value) {
    _patient = value;
  }

  void setPhoneNumber(String phoneNumber) {
    if(_isValidPhoneNumber(phoneNumber)){
      //
      sendUpdateProfilePatientRequest(key:"phoneNumber",value: phoneNumber).then((value) {
        print("done operation ");
      });
      this._patient.phoneNumber = phoneNumber;
    }
    
  }


  void setWeight(double weight) {
    if(_isValidWeight(weight)){
      sendUpdateProfilePatientRequest(key:"weight",value:weight.toString()).then((value) {
        print("done operation ");
      });
      _patient.weight = weight;
      notifyListeners();
    }
  }

  void setLength(double length) {
    if(_isValidLength(length)){
      sendUpdateProfilePatientRequest(key:"weight",value:length.toString()).then((value) {
        print("done operation ");
      });
      _patient.length = length;
      notifyListeners();
    }

  }

  String getUserName() {
    return this._patient.username;
  }

  double getWeight() {
    return this._patient.weight;
  }

  double getLength() {
    return this._patient.length;
  }

  String getImgUrl() {
    return this._patient.imgurl;
  }

  void setImgUrl(String imgurl){
    this._patient.imgurl=imgurl;
    notifyListeners();
  }

  String getIdCurantDoctor(){
    return this._patient.idCurantDoctur;
  }

  DateTime getDateBirth() {
    DateTime data = this._patient.dateBirth.toDate();
    return data;
  }

  String getPhoneNumber() {
    return this._patient.phoneNumber;
  }

  String getId() {
    return this._patient.id;
  }

  String getLocation() {
    return this._patient.location;
  }

  File getImagePerson() {
    return this._imagePerson;
  }

  bool getUpdateWeight() {
    return this._updateWeight;
  }

  bool getUpdateLength() {
    return this._updateLength;
  }

  bool getUpdatePhone() {
    return this._updatePhone;
  }

  bool getUpdateLocation() {
    return this._updateLocation;
  }

  String getDiabetesType() {
    return this._patient.diabtesType;
  }

  Future getImage(ImageSource src) async {
    this._imagePerson = null;
    final pickedFile = await imagePicker.getImage(source: src);
    if (pickedFile != null) {
      this._imagePerson = File(pickedFile.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(this._patient.id + ".jpg");
      await ref.putFile(this._imagePerson);
      final url = await ref.getDownloadURL();

      await FirebaseDatabase().reference()
          .child("users")
          .child(this.getId())
          .update({'imgurl': url});
      this.setImgUrl(url);

      notifyListeners();
    }

  }

  void setLocation(String location) {
    if(_isValidLocation(location)){
      _patient.location = location;
      sendUpdateProfilePatientRequest(key:"location",value:location).then((value) {
        print("done operation ");
      });
      notifyListeners();
    }

  }

  void toggleUpdateWeight() {
    this._updateWeight = !this._updateWeight;
    notifyListeners();
  }

  void toggleUpdateLength() {
    this._updateLength = !this._updateLength;
    notifyListeners();
  }

  void toggleUpdatePhone() {
    this._updatePhone = !this._updatePhone;
    notifyListeners();
  }

  void toggleUpdateLocation() {
    this._updateLocation = !this._updateLocation;
    notifyListeners();
  }

}
