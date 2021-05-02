import 'package:ali_muntaser_final_project/core/Model/patient.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/PatientServes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  ///https://jaber-server.herokuapp.com/auth/patient/signIn
  String _urlSignIn ="https://jaber-server.herokuapp.com/auth/patient/signIn";
  String _jwt;

  String userId;
  String password;



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
      this.userId=id;

      print("\n\n\n\n\n\n\n\n\n");
      print( patientData);
      print("\n\n\n\n\n\n\n\n\n");
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
