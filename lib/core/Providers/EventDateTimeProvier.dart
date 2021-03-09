import 'dart:convert';





import 'package:ali_muntaser_final_project/core/Model/EventStruct.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/eventServesAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class SlotDateTimeProvider with ChangeNotifier{
  List <EventStruct> listEventSloat=[];
  String dateName;

  DateTime dateTime;

  String getDateTime(){
    return this.dateName+"  " +this.dateTime.year.toString()+"-"+this.dateTime.month.toString()+"-"+this.dateTime.day.toString();
  }

  void clearAllEvents(){
    this.listEventSloat.clear();
  }


  Future<int> getAllEventInSelectedDateTime()async{
   // -1 == > لايوجد مواعيد
    // 0
    print(dateTime.toString());
    http.Response response=await getAllEventInDay(DateTime(dateTime.year,dateTime.month-1,dateTime.day,0,0,0,0,0));
    var result=jsonDecode(response.body);
    if(result["msg"].length==0){
      this.listEventSloat=[];
      return -1;
    }
    print(result);
    for(int i=0;i<result["msg"].length;i++){
      this.listEventSloat.add(
        new EventStruct(
          id:   result["msg"][i]["_id"].toString(),
          isAvailable: result["msg"][i]["taken"]["available"],
          startEventTime: DateTime.parse(result["msg"][i]["startEventTime"]).add(Duration(hours: 2)),
          endEventTime:  DateTime.parse(result["msg"][i]["endEventTime"]).add(Duration(hours: 2)),
        ),
      );
    }
    return 1;
    // DateTime start=  DateTime.parse(result["msg"][0]["startEventTime"]);
    // start= start.add(Duration(days: 1));
    // print(start.day.toString()+"  "+start.month.toString()+"  "+start.year.toString());
    // print(response.body);

     // for(int i=0;i<this.listEventSloat.length;i++){
     //   print(" i " + i.toString() + "startEventTime "+this.listEventSloat[i].startEventTime.toString() +" endEventTime " + this.listEventSloat[i].endEventTime.toString() );
     // }

  }

  void deleteEventById(String id){

    try{
      for(int i =0 ; i<listEventSloat.length;i++){
        if(listEventSloat[i].id==id){
          this.listEventSloat.removeAt(i);
          notifyListeners();
          return;
        }
      }
    }catch(e){
      print("//////////////////////////////////////////////////////////////////////////");
    }
  }

}