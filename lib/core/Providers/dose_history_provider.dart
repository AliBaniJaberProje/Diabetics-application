


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class DoseHistoryProvider with ChangeNotifier{
  String jsonSample="";
  var json;
  bool loading=false;
  void fetchData(int month, int year)async{
    loading=true;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response response=await http.get("https://jaber-server.herokuapp.com/doseHistory/$month/$year",headers: {"x-auth-token":prefs.getString('jwt')});
    if(response.statusCode==200){
      jsonSample=response.body;
      json=jsonDecode(jsonSample);
      notifyListeners();
    }



    loading=false;

  }

}
