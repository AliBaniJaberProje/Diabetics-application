import 'package:ali_muntaser_final_project/core/Model/doctorChatStruct.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class DoctorChatProvider with ChangeNotifier {

  ///-------------------------------------data ---------------------------------
  List<DoctorChatStruct> _doctors=[];

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
   var _doctors=await _firebaseRef.child("users").child(_currentDoctorId).once();
   _processResult(_doctors.value);
   print(this._doctors[0].imgUrl);

   for(int i=0;i<_previousDoctors.length;i++){
     print(_previousDoctors[i]);
     _doctors=await _firebaseRef.child("users").child(_previousDoctors[i]).once();
     _processResult(_doctors.value);
   }

    
  }

  DoctorChatStruct getDotorAt(int index){
    return this._doctors[index];
  }

  int numberOfDoctor()=>this._doctors.length;

  ///----------------------------------done-------------------------------------

}
