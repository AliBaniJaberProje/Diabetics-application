

import 'dart:convert';

import 'package:ali_muntaser_final_project/core/Providers/food_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ChartData {
   String text;
   double data;
   Color color;
  ChartData(this.text, this.data, this.color);
}

class FoodItemHistory{
  final double ch;
  final double proten ;
  final double fat;
  final int amount;
  final String name;
  final String img;
  Color color;
  Color shadowColor;
  FoodItemHistory({this.ch, this.proten, this.fat, this.amount,this.name,this.img,this.color,this.shadowColor});

}



class FoodHistoryProvider  with ChangeNotifier {

  bool loading=false;
  String initTitle="قم باختيار اليوم لمعرفة الاصناف";
  String initTextChart="قم باختيار اليوم لمعرفة نسب العناصر الغذائية";


  List<ChartData> chartData = [
    ChartData("كربوهيدرات", 0, Colors.purple.shade300),
    ChartData("دهون", 0, Colors.amber.shade300),
    ChartData("بروتين", 0, Colors.green.shade300),
  ];


  List<FoodItemHistory> foodHistoryDataTable=[];

  Future<bool> setNewDateAndSendRequest({String year, String month , String day} )async{

    loading=true;
    notifyListeners();
    initTitle="الاصناف المتناولة في تاريخ $year-$month-$day";
    initTextChart="نسب العناصر الغذائية المتناولة في يوم $year-$month-$day";
    print(year +"-"+ month+"-" + day);
    notifyListeners();
    foodHistoryDataTable.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //https://jaber-server.herokuapp.com
    http.Response response = await http.get("https://jaber-server.herokuapp.com/foodHistory/$year/$month/$day",headers: {'x-auth-token': prefs.get('jwt')});

    if(response.statusCode==200){

     var result= jsonDecode(response.body) ;
     for(int i=0;i<result["allFood"].length;i++){
       print(result);
       foodHistoryDataTable.add(
           FoodItemHistory(
             ch:double.parse(result["allFood"][i]["Carbohydrate"]),
             proten:double.parse(result["allFood"][i]["Protein"]) ,
             amount: result["allFood"][i]["amount"],
             fat:double.parse(result["allFood"][i]["fat"]),
             img:result["allFood"][i]["img"] ,
             name: result["allFood"][i]["name"],
             color: getColorForThisFruteBorder(result["allFood"][i]["name"]),
             shadowColor: getColorForThisFrute(result["allFood"][i]["name"])
           )
       );
     }

     chartData[0].data=result["total"]["Carbohydrate"]*1.0;
     chartData[1].data=result["total"]["fat"]*1.0;
     chartData[2].data=result["total"]["Protein"]*1.0;

    }
    loading=false;
    notifyListeners();

  }

  void clearData(){
    initTitle="قم باختيار اليوم لمعرفة الاصناف";
    initTextChart="قم باختيار اليوم لمعرفة نسب العناصر الغذائية";
    this.foodHistoryDataTable.clear();
  }


}