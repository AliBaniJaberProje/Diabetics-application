import 'dart:convert';
import 'dart:io';

import 'package:ali_muntaser_final_project/core/Model/patient.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/PatientServes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



import 'dart:async';
import 'package:async/async.dart';

import 'package:flutter/material.dart';



import 'package:path/path.dart';


class ProfileProvider with ChangeNotifier {
  Patient _patient = new Patient();
  //-----------------------------------------data-------------------------
  bool _updateWeight = false;
  bool _updateLength = false;
  bool _updatePhone = false;
  bool _updateLocation = false;
  File _imagePerson;
  final imagePicker = ImagePicker();
  String doctorName;
  bool loadingNameInHome=true;

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
      sendUpdateProfilePatientRequest(key:"height",value:length.toString()).then((value) {
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



  DateTime getDateBirth() {
    DateTime data = this._patient.dateBirth;
    return data;
  }

  String getPhoneNumber() {
    return this._patient.phoneNumber;
  }

  // String getId() {
  //   return this._patient.id;
  // }

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
  File _image;
  Future getImage(ImageSource src) async {

    this._imagePerson = null;
    final pickedFile = await imagePicker.getImage(source: src);
    if (pickedFile != null) {


      this._imagePerson = File(pickedFile.path);

      var stream =
      new http.ByteStream(DelegatingStream.typed(_imagePerson.openRead()));
      var length = await _imagePerson.length();



      var uri = Uri.parse("https://jaber-server.herokuapp.com/imagesUpload/patient");

      var request = new http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = new http.MultipartFile('img', stream, length,
          filename: basename(_imagePerson.path));

      // add file to multipart
      request.files.add(multipartFile);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      request.headers.addAll({"x-auth-token":prefs.getString('jwt')});
      // send
      var response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        this.setImgUrl(jsonDecode(value)["imgUrl"]);
        print(value);
      });





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

  fetchData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  http.Response response=await  http.get("https://jaber-server.herokuapp.com/patient",headers: {"x-auth-token":prefs.getString("jwt")});
  if(response.statusCode==200){
    var patientData=  jsonDecode(response.body)["msg"];

    this._patient=new Patient(
        id: patientData["id"],
        username: patientData["username"],

        imgurl: patientData["imgURL"],
        phoneNumber: patientData["phoneNumber"],
        location: patientData["location"],
        length: double.parse(patientData["height"].toString()),
        weight: double.parse(patientData["weight"].toString()),
        dateBirth: DateTime.parse(patientData["birthDate"].toString()),
        diabtesType: patientData["diabetesType"],

        diagnosisYear: Timestamp.fromMicrosecondsSinceEpoch(
            int.parse(patientData["diagnosisYear"]),),
        // injectionType: patientData["injectionType"],
        // capsuleType: patientData["capsuleType"],
    );

  }
  }




}
