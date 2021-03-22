import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodItem2 {
  String id;
  String name;
  String img;
  Color color;
  Color borderColor;

  FoodItem2({this.id, this.name, this.img, this.color, this.borderColor});
}

class FoodProvider2 with ChangeNotifier {
  List<FoodItem2> foodList = [];
  bool loadingState=false;

  Color _getColorForThisFrute(String foodName) {
    switch (foodName) {
      case "تين ":
        return Colors.purple.shade100;
      case 'تفاح':
        return Colors.red.shade100;
      case 'برتقال':
        return Colors.orange.shade50;
      case 'عنب':
        return Colors.purple.shade100;
      case "خوخ":
        return Colors.orangeAccent.shade100;
      case "مشمش":
        return Colors.orange.shade100;
      case "بطيخ":
        return Colors.pink.shade100;
      case "شمام":
        return Colors.orangeAccent.shade100;
      case "كيوي ":
        return Colors.green.shade100;
      case "أناناس":
        return Colors.amber.shade200;
      case "فرولة ":
        return Colors.pink.shade100;
      case "موز":return Colors.yellow.shade100;
      case "كرز" : return Colors.red.shade100;
      return Colors.yellowAccent;
    }
    return Colors.white;
  }

  Color _getColorForThisFruteBorder(String foodName) {
    switch (foodName) {
      case "تين ":
        return Colors.purple;
      case 'تفاح':
        return Colors.red;
      case 'برتقال':
        return Colors.orange;
      case 'عنب':
        return Colors.purple;
      case "خوخ":
        return Colors.orangeAccent;
      case "مشمش":
        return Colors.orange;
      case "بطيخ":
        return Colors.pink;
      case "شمام":
        return Colors.orangeAccent;
      case "كيوي ":
        return Colors.green;
      case "أناناس":
        return Colors.amber;
      case "فرولة ":
        return Colors.pink;
      case "موز":return Colors.yellow;
      case "كرز" : return Colors.red;
        return Colors.yellowAccent;
    }
    return Colors.purple;
  }

  void sendRequestAndGetFoodList(String value) async {
    print("sendRequestAndGetFoodList");
    loadingState=true;
    notifyListeners();
    String url="http://192.168.0.112:3000/food/";
    if(value=="منتجات الألبان والبيض"){
      url+="eggs_and_milk";

    }
    else if (value == "فواكه") {
      url+="fruits";
    }
    else if(value=="الدهون والزيوت"){
     url+="oils_and_fats";
    }else if(value=="اللحوم البيضاء"){
      url+="white_meat";
    }else if(value=="اللحوم الحمراء"){
      url+="red_meat";
    }
    else {
      this.foodList.clear();
      notifyListeners();
    }


      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        foodList.clear();
        final resultResponse = jsonDecode(response.body) as List;
        for (int i = 0; i < resultResponse.length; i++) {
          foodList.add(
            new FoodItem2(
                id: resultResponse[i]['id'],
                name: resultResponse[i]['name'],
                img: resultResponse[i]['img'],
                color:
                    _getColorForThisFrute(resultResponse[i]['name'].toString()),
                borderColor: _getColorForThisFruteBorder(
                    resultResponse[i]['name'].toString())),
          );
        }
        loadingState=false;
        notifyListeners();
      }

  }
}
