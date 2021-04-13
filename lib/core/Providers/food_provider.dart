import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  bool loadingState = false;

  Color _getColorForThisFrute(String foodName) {
    switch (foodName) {
      case "ريحان":
        return Colors.green.shade100;
      case "كزبرة":
        return Colors.green.shade100;
      case "خس":
        return Colors.green.shade100;
      case "بقدونس":
        return Colors.green.shade100;
      case "جرجير":
        return Colors.green.shade100;
      case "سبانخ":
        return Colors.green.shade100;
      case "ورق عنب":
        return Colors.green.shade100;

      case "تين ":
        return Colors.purple.shade100;
      case 'تفاح':
        return Colors.red.shade100;
      case 'بندورة':
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
      case "خيار":
        return Colors.green.shade100;
      case "أناناس":
        return Colors.amber.shade200;
      case "فرولة ":
        return Colors.pink.shade100;
      case "موز":
        return Colors.yellow.shade100;
      case "كرز":
        return Colors.red.shade100;
      case "جزر":
        return Colors.orange.shade100;
      case "بروكلي":
        return Colors.green.shade100;
      case "باذنجان":
        return Colors.deepPurple.shade100;
      case "ثوم":
        return Colors.yellow.shade50;
      case "فلفل":
        return Colors.red.shade100;
      case "بصل":
        return Colors.amber.shade50;
      case "عناب":
        return Colors.red.shade100;
      case "جوافة":
        return Colors.lightGreenAccent.shade100;
      case "جريفوت":
        return Colors.yellow.shade100;
      case "مانجا":
        return Colors.amber.shade100;
      case "اسكدنيا":
        return Colors.orangeAccent.shade100;
      case "رمان":
        return Colors.red.shade100;
      case "برقوق":
        return Colors.deepPurple.shade100;
      case "ذرة":
        return Colors.yellow.shade100;
      case "ليمون":
        return Colors.yellow.shade100;
      case "بامية":
        return Colors.greenAccent.shade100;
      case "افوكادوا":
        return Colors.greenAccent.shade100;
      case "يقطين":
        return Colors.orangeAccent.shade100;
      case "زنجبيل":
        return Colors.yellow.shade100;
      case "لفت":
        return Colors.deepPurple.shade100;
      case "فجل":
        return Colors.pink.shade100;
      case "فطر":
        return Colors.brown.shade100;
      case "قرنبيط":
        return Colors.white60;
      case "زيت الزيتون":
        return Colors.yellow.shade100;
      case "زبده":
        return Colors.orange.shade50;
      case "سمنة":
        return Colors.brown.shade50;
        return Colors.yellowAccent;
      case "عصير الكرز":
        return Colors.red.shade100;
      case "كرز":
        return Colors.red.shade100;
      case "تمر هندي":
        return Colors.brown.shade200;
      case " لموناضه":
        return Colors.yellow.shade200;
    }
    return Colors.white;
  }

  Color _getColorForThisFruteBorder(String foodName) {
    switch (foodName) {
      case "ريحان":
        return Colors.green;
      case "كزبرة":
        return Colors.green;
      case "خس":
        return Colors.green;
      case "بقدونس":
        return Colors.green;
      case "جرجير":
        return Colors.green;
      case "سبانخ":
        return Colors.green;
      case "ورق عنب":
        return Colors.green;

      case "عصير الكرز":
        return Colors.red;
      case "تمر هندي":
        return Colors.brown;
      case " لموناضه":
        return Colors.yellow;

      case "سمنة":
        return Colors.brown;
      case "زيت الزيتون":
        return Colors.yellowAccent;
      case "زبده":
        return Colors.orangeAccent;
      case "فجل":
        return Colors.pink;
      case "فطر":
        return Colors.brown;
      case "يقطين":
        return Colors.orangeAccent;
      case "زنجبيل":
        return Colors.yellow;
      case "لفت":
        return Colors.deepPurple;
      case "قرنبيط":
        return Colors.white60;
      case "افوكادوا":
        return Colors.greenAccent;
      case "بامية":
        return Colors.greenAccent;
      case "ليمون":
        return Colors.yellow;
      case "ذرة":
        return Colors.yellow;
      case "برقوق":
        return Colors.deepPurple;
      case "رمان":
        return Colors.red;
      case "مانجا":
        return Colors.redAccent;
      case "جريفوت":
        return Colors.yellow;
      case "جوافة":
        return Colors.lightGreenAccent;
      case "عناب":
        return Colors.red;
      case "اسكدنيا":
        return Colors.orangeAccent;
      case "تين ":
        return Colors.purple;
      case 'تفاح':
        return Colors.red;
      case 'بندورة':
        return Colors.red;
      case "بروكلي":
        return Colors.green;
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
      case "موز":
        return Colors.yellow;
      case "كرز":
        return Colors.red;
        return Colors.yellowAccent;
      case "جزر":
        return Colors.orange;
      case "خيار":
        return Colors.green;
      case "باذنجان":
        return Colors.deepPurple;
      case "ثوم":
        return Colors.yellow;
      case "فلفل":
        return Colors.red;
      case "بصل":
        return Colors.amber;
    }
    return Colors.purple;
  }

  void sendRequestAndGetFoodList(String value) async {
    print("sendRequestAndGetFoodList");
    loadingState = true;
    notifyListeners();
    String url = "http://192.168.0.112:3000/food/";
    if (value == "منتجات الألبان والبيض") {
      url += "eggs_and_milk";
    } else if (value == "فواكه") {
      url += "fruits";
    } else if (value == "الدهون والزيوت") {
      url += "oils_and_fats";
    } else if (value == "اللحوم و الأسماك") {
      url += "meat";
    } else if (value == "خضروات") {
      url += "vegetable";
    } else if (value == "المشروبات") {
      url += "drink";
    } else if (value == "الورقيات") {
      url += "foliar";
    } else if (value == "البقوليات والمكسرات") {
      url += "legumes";
    } else if (value == "النشويات") {
      url += "starche";
    } else {
      this.foodList.clear();
      notifyListeners();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(url,headers: {"x-auth-token":prefs.getString('jwt')});
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
      loadingState = false;
      notifyListeners();
    }
  }


}
