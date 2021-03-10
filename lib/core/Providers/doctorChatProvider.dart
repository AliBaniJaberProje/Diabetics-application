import 'dart:convert';

import 'package:ali_muntaser_final_project/core/Model/doctorChatStruct.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class DoctorChatProvider with ChangeNotifier {

  ///-------------------------------------data ---------------------------------
  List<DoctorChatStruct> _doctors=[];

  String idPatient;
  String imgurlPatient;


  String _currentDoctorId;

  List<dynamic> _previousDoctors;

  var _firebaseRef = FirebaseDatabase().reference();
  ///----------------------------function---------------------------------------
  void _processResult(dynamic doctor){
    this._doctors.add(DoctorChatStruct.fromJson(doctor));
    notifyListeners();
  }


  String get currentDoctorId => _currentDoctorId;

  ///----------------------------public functions-------------------------------
  void setPreviousDoctors(List<dynamic> doctors){
    this._previousDoctors=doctors;

  }

  void setCurrentDoctorId(String doctorCurrentId){
    this._currentDoctorId=doctorCurrentId;
  }

  Future<void> fetchDoctors()async{
   this._doctors.clear();

   // var _doctors=await _firebaseRef.child("users").child(_currentDoctorId).once();
   // _processResult(_doctors.value);
   // print(this._doctors[0].imgUrl);
   //
   // for(int i=0;i<_previousDoctors.length;i++){
   //   print(_previousDoctors[i]);
   //   _doctors=await _firebaseRef.child("users").child(_previousDoctors[i]).once();
   //   _processResult(_doctors.value);
   // }


     SharedPreferences prefs = await SharedPreferences.getInstance();
     http.Response response=await http.get("https://jaber-server.herokuapp.com/patient/getIdDoctors",headers: {"x-auth-token":prefs.getString('jwt')});
      var resultDecoded=jsonDecode(response.body);
     if(response.statusCode==200){

       for(int i=0;i<(resultDecoded["doctorsInfo"] as List<dynamic>).length;i++){
         _processResult(resultDecoded["doctorsInfo"][i]);
       }
       int i=0;
       DoctorChatStruct curantDoctor;
       for(;i<this._doctors.length;i++){
         if(this._doctors[i].id==resultDecoded["patientInfo"]["currentDoctor"]){
            curantDoctor=this._doctors[i];
           _currentDoctorId=this._doctors[i].id;
           break;
         }
       }
       this._doctors.removeWhere((element) => element.id==this._currentDoctorId);
       this._doctors.insert(0, curantDoctor);
       this.idPatient=resultDecoded["patientInfo"]["id"];
       this.imgurlPatient=resultDecoded["patientInfo"]["imgURL"];
     }else{
       return {"msg":"error"};
     }


    
  }

  DoctorChatStruct getDotorAt(int index){
    return this._doctors[index];
  }

  int numberOfDoctor()=>this._doctors.length;

  ///----------------------------------done-------------------------------------

}
