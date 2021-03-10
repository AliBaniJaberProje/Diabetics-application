import 'package:ali_muntaser_final_project/core/Model/patient.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/PatientServes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _urlSignIn ="https://jaber-server.herokuapp.com/auth/patient/signIn";
  String _jwt;

  String get jwt => _jwt;
  void clearJWT() {
    this._jwt = null;
  }

  Future<bool> isAuthorizedPatient(
      String id, String password) async {
    http.Response response = await http.post(this._urlSignIn, body: {'id': id, 'password': password});

    var fbm = await FirebaseMessaging();
    var phoneToken = await fbm.getToken();

    /// token phone
    Map<String, dynamic> return_data = new Map<String, dynamic>();
    print(response.body);
    if (response.statusCode == 200) {
      final patientData = jsonDecode(response.body);

      // List<dynamic> lastdoctor = patientData["patient"]["lastDoctor"] as List;
      //
      // List<dynamic> lastDoctorsList = lastdoctor.toList();
      // for (int i = 1; i < lastDoctorsList.length; i++) {
      //   lastDoctorsList[i - 1] = lastDoctorsList[i];
      //
      // }
      //
      // Patient patient = Patient(
      //   id: patientData["patient"]["id"],
      //   username: patientData["patient"]["username"],
      //   idCurantDoctur: patientData["patient"]["currentDoctor"],
      //   imgurl: patientData["patient"]["imgURL"],
      //   phoneNumber: patientData["patient"]["phoneNumber"],
      //   location: patientData["patient"]["location"],
      //   length: double.parse(patientData["patient"]["length"].toString()),
      //   weight: double.parse(patientData["patient"]["weight"].toString()),
      //   dateBirth: Timestamp.fromMicrosecondsSinceEpoch(
      //       int.parse(patientData["patient"]["birthDate"].toString()),),
      //   diabtesType: patientData["patient"]["diabetesType"],
      //   lastDoctor: lastDoctorsList,
      //   diagnosisYear: Timestamp.fromMicrosecondsSinceEpoch(
      //       int.parse(patientData["patient"]["diagnosisYear"]),),
      //   injectionType: patientData["patient"]["injectionType"],
      //   capsuleType: patientData["patient"]["capsuleType"],
      // );

     // return_data["status"] = "yes";
    //  return_data["patient"] = patient;
    //   print(patient);

      this._jwt = patientData["token"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', this._jwt);



      sendUpdateProfilePatientRequest(key:"phoneToken",value: phoneToken).then((value) => print("operation done "));
      return true;

    } else {
      return false;
     // return_data["status"] = "no";
    }
    //return false;
  }




}
