
import 'dart:convert';

import 'package:ali_muntaser_final_project/UI/Screens/doctor_appointments/Doctor_appointmentScreen.dart';
import 'package:ali_muntaser_final_project/core/Model/EventHistoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class EventHistory with ChangeNotifier{

  bool loading=false;

  List<EventHistoryModel> eventHistoryData=[];

  String titleMont="قم باختيار الشهر لمعرفة مراجعاتك خلاله";

  void sendHttpRequestToGetHistory(String year, String month)async{
    titleMont="مراجعات الطبيب خلال شهر $month - $year";
    eventHistoryData.clear();
    loading=true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response =await http.get("https://jaber-server.herokuapp.com/eventHistory/api/patient/$year/$month",headers: {'x-auth-token': prefs.get('jwt')});
      if(response.statusCode==200){
        var result=jsonDecode(response.body);
         for(int i=0;i<result.length;i++){
           eventHistoryData.add(EventHistoryModel(
               shadowColor: colorShadow[i%colorShadow.length],
               id:jsonDecode(response.body)[i]["idEvent"].toString() ,
           boderColor: color[i%color.length],
             dateEventTime: DateTime.parse(jsonDecode(response.body)[i]["startTime"]).year.toString()+"-"+DateTime.parse(jsonDecode(response.body)[i]["startTime"]).month.toString()+"-"+DateTime.parse(jsonDecode(response.body)[i]["startTime"]).day.toString(),
             doctorImg:jsonDecode(response.body)[i]["idDoctor"]["imgURL"],
             doctorName: jsonDecode(response.body)[i]["idDoctor"]["username"],
             note: jsonDecode(response.body)[i]["note"]
           ));
         }
        loading=false;

         notifyListeners();

      }

  }

  void clearData(){
    this.loading=false;
    this.titleMont="قم باختيار الشهر لمعرفة مراجعاتك خلاله";
    this.eventHistoryData.clear();
  }




  /// http request




}