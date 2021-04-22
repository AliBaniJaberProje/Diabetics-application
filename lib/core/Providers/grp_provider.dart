

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class GRP_Item{
  double value;
  String dateTime;
  Color shadowColor;
  Color border;

  GRP_Item({this.value, this.dateTime, this.shadowColor, this.border});
}

List<dynamic> arrayColor=[

{
   "border":Colors.amber,
   "shade":Colors.amber.shade100
},{
    "border":Colors.green,
    "shade":Colors.green.shade100
  },{
    "border":Colors.orange,
    "shade":Colors.orange.shade100
  },{
    "border":Colors.purple,
    "shade":Colors.purple.shade100
  }
];

// Card_GRP(color: Colors.amber.shade100,borderColor: Colors.amber,dateGRP: "19-2-2021",valueGRP: "6.1",),
// Card_GRP(color: Colors.green.shade100,borderColor: Colors.green,dateGRP: "19-2-2021",valueGRP: "5.3",),
//
//
// Card_GRP(color: Colors.orange.shade100,borderColor: Colors.orange,dateGRP: "19-2-2021",valueGRP: "6.1",),
// Card_GRP(color: Colors.purple.shade100,borderColor: Colors.purple,dateGRP: "19-2-2021",valueGRP: "6.1",),


// ignore: camel_case_types
class GRP_history_Provider with ChangeNotifier{
  List<GRP_Item> GRP_list=[];
  String title="قم باختيار السنة لمعرفة فحوصات السكري خلالها";
  bool loading=false;

  void clearData(){
    loading=false;
    title="قم باختيار السنة لمعرفة فحوصات السكري خلالها";
    GRP_list.clear();
  }


  void sendHttpToGetDataGRP(String year)async{
    title="فحوصات السكري التراكمي خلال سنة $year";
    loading=true;
    notifyListeners();
    this.GRP_list.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response =await http.get("https://jaber-server.herokuapp.com/cumulative_diabetes/$year",headers: {'x-auth-token': prefs.get('jwt')});

    try{
      if(response.statusCode==200){
        var result=jsonDecode(response.body);
        for(int i=0;i<result.length;i++){
          DateTime dateTime=DateTime.parse(result[i]["date"]);
          GRP_list.add(
              GRP_Item(
                value: result[i]["value"]*1.0,
                dateTime:dateTime.year.toString()+"-" + dateTime.month.toString()+"-"+dateTime.day.toString(),
                shadowColor:arrayColor[i%4]["shade"],
                border: arrayColor[i%4]["border"],
              )
          );
        }
      }
    }catch(e){
      print(e);
    }

    loading=false;
    notifyListeners();
  }


}