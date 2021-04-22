import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class SuqarReadingHistoryProvider with ChangeNotifier {

  int month = 4;
  int year = 2021;

  String url = "https://jaber-server.herokuapp.com/dailyReading/";
  String titleTable = "فحوصات السكري لشهر  2021-1";

  List<SalesData> arr1 = [];
  List<SalesData> arr2 = [];
  List<SalesData> arr3 = [];
  List<SalesData> arr4 = [];

  List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();

  Future<void> fetchData() async {
    DateTime d = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    titleTable = "${d.year}-${d.month}فحوصات السكري لشهر ";
    http.Response response = await http.get(
        "https://jaber-server.herokuapp.com/dailyReading/${d.year}/${d.month}",
        headers: {'x-auth-token': prefs.get('jwt')});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      for (int index = 0; index < result.length; index++) {

        temps.add({
          "التاريخ": "$year"+"-"+result[index]["date"],
          "قبل الافطار":  result[index]["inputInfo"][0]["value"],
          "بعد الافطار بساعتين":  result[index]["inputInfo"][1]["value"],
          "بعد الغداء بساعتين":  result[index]["inputInfo"][2]["value"],
          "بعد العشاء بساعتين":  result[index]["inputInfo"][3]["value"],
        });

        arr1.add(SalesData(result[index]["date"],
            result[index]["inputInfo"][0]["value"] * 1.0));
        arr2.add(SalesData(result[index]["date"],
            result[index]["inputInfo"][1]["value"] * 1.0));
        arr3.add(SalesData(result[index]["date"],
            result[index]["inputInfo"][2]["value"] * 1.0));
        arr4.add(SalesData(result[index]["date"],
            result[index]["inputInfo"][3]["value"] * 1.0));
      }
      print(response.body);
    }

    notifyListeners();
  }

  void setDateToSelect(int month, int year){
    this.month=month;
    this.year=year;
    titleTable = "$year-$monthفحوصات السكري لشهر ";
    clearData();
    notifyListeners();
  }

  void clearData(){
    DateTime d = DateTime.now();
    arr1.clear();
    arr2.clear();
    arr3.clear();
    arr4.clear();
    temps.clear();
    titleTable = "${d.year}-${d.month}فحوصات السكري لشهر ";
  }

  Future<void> reFetchData()async {
    titleTable = "$year-$monthفحوصات السكري لشهر ";


    SharedPreferences prefs = await SharedPreferences.getInstance();

    titleTable = "$year-$monthفحوصات السكري لشهر ";
    http.Response response = await http.get(
        "https://jaber-server.herokuapp.com/dailyReading/${this.year}/${this.month}",
        headers: {'x-auth-token': prefs.get('jwt')});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      for (int index = 0; index < result.length; index++) {

        temps.add({
          "التاريخ": "$year"+"-"+result[index]["date"],
          "قبل الافطار":  result[index]["inputInfo"][0]["value"],
          "بعد الافطار بساعتين":  result[index]["inputInfo"][1]["value"],
          "بعد الغداء بساعتين":  result[index]["inputInfo"][2]["value"],
          "بعد العشاء بساعتين":  result[index]["inputInfo"][3]["value"],
        });


        arr1.add(SalesData(result[index]["date"],
            result[index]["inputInfo"][0]["value"] * 1.0));
        arr2.add(SalesData(result[index]["date"],
            result[index]["inputInfo"][1]["value"] * 1.0));
        arr3.add(SalesData(result[index]["date"],
            result[index]["inputInfo"][2]["value"] * 1.0));
        arr4.add(SalesData(result[index]["date"],
            result[index]["inputInfo"][3]["value"] * 1.0));
      }


      print(response.body);
    }

    notifyListeners();


  }

}
