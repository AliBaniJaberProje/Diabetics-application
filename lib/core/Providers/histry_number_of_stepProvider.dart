

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ali_muntaser_final_project/core/Providers/food-history-provider.dart';


class NumberOfStepHistory with ChangeNotifier{

  final List<ChartData> chartData=[];

  void clearData(){
    this.chartData.clear();
    title="قم باختيار التاريخ";
    totalTitel="";
    isEmpty=false;
  }
  String title="قم باختيار التاريخ";
  String totalTitel="";
  bool loading=false;
  double total=0;
  bool isEmpty=false;
  void fetchAllInDate(String year , String month)async{

    try{
      title="رسم بياني لنشاط الرياضي في شهر $month - $year";

      loading=true;
      chartData.clear();
      totalTitel="";

      notifyListeners();
      total=0;
      isEmpty=false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response=await http.get("https://jaber-server.herokuapp.com/steps/$year/$month",headers: {"x-auth-token":prefs.getString('jwt')});
      print(jsonDecode(response.body));
      var resultData=(jsonDecode(response.body))["msg"];
      totalTitel="المجموع لشهر $month-$year";
      if(resultData.length==0){
        isEmpty=true;
        notifyListeners();
      }

      for(int i=0;i<resultData.length;i++){

        total+=resultData[i]["numberStep"]*1.0;
        chartData.add(ChartData(resultData[i]["date"],resultData[i]["numberStep"]*1.0,null));
      }
      loading=false;
      notifyListeners();
    }catch(e){
      isEmpty=true;
      notifyListeners();
    }

  }

}
