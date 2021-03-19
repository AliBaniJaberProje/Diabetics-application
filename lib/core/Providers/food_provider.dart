

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class FoodItem2{
  String id;
  String name;
  String  img ;
  Color color;
  Color borderColor;

  FoodItem2({this.id, this.name,this.img, this.color, this.borderColor});

}

class FoodProvider2 with ChangeNotifier{


  List<FoodItem2> foodList=[];

  Color _getColorForThisFrute(String foodName){

    switch(foodName){
      case "تين ": return Colors.purple.shade100;
      case 'تفاح' : return Colors.red.shade50;
      case 'برتقال':return Colors.orange.shade50;
      case 'عنب':return Colors.purple.shade100;
      case "خوخ": return Colors.orangeAccent.shade100;
      case "مشمش":return Colors.orange.shade100;
      case  "بطيخ":return Colors.pink.shade100;
      case "شمام":return Colors.orangeAccent.shade100;
      case "كيوي ": return Colors.green.shade100;
      case "انناس":return Colors.yellow.shade100;
      case "فرولة " :return Colors.pink.shade50;
       return Colors.yellowAccent;

    }

  }

  Color _getColorForThisFruteBorder(String foodName){

    switch(foodName){
      case "تين ": return Colors.purple;
      case 'تفاح' : return Colors.red;
      case 'برتقال':return Colors.orange;
      case 'عنب':return Colors.purple;
      case "خوخ": return Colors.orangeAccent;
      case "مشمش":return Colors.orange;
      case  "بطيخ":return Colors.pink;
      case "شمام":return Colors.orangeAccent;
      case "كيوي ": return Colors.green;
      case "انناس":return Colors.yellow;
      case "فرولة " :return Colors.pink;
      return Colors.yellowAccent;

    }

  }


  void sendRequestAndGetFoodList(String value)async{
    print("sendRequestAndGetFoodList");

    if(value=="فواكه"){

     http.Response response=await http.get("http://192.168.0.112:3000/food");
     if(response.statusCode==200){
       foodList.clear();
       final resultResponse=jsonDecode(response.body) as List;
        for(int i=0;i<resultResponse.length;i++){
          foodList.add(new FoodItem2(id :resultResponse[i]['id'] , name :resultResponse[i]['name'] , img :resultResponse[i]['img'],color:_getColorForThisFrute(resultResponse[i]['name'].toString()),borderColor: _getColorForThisFruteBorder(resultResponse[i]['name'].toString()) ),);
        }
       notifyListeners();
     }

    }else{
      this.foodList.clear();
      notifyListeners();
    }

  }

}