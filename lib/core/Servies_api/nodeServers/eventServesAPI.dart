import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


String url="https://jaber-server.herokuapp.com/event/myEvent";

Future<http.Response> getMyEventSelected()async{

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String jwt=await prefs.getString("jwt");
  http.Response response= await http.get(url,headers: {"x-auth-token":jwt},);

  return response;


}

Future<http.Response> getAllEventInDay(DateTime dateTime)async{
  DateTime endDate=DateTime(dateTime.year,dateTime.month,dateTime.day,23,59,59,59,59);
  http.Response response=await http.post("http://192.168.0.112:3000/patient/test",body: {
    "start":dateTime.toString(),
    "end":endDate.toString(),
  });
 return response;


}






// Future<http.Response> getAllEventsInDate
