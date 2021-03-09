import 'dart:convert';

import 'package:ali_muntaser_final_project/core/Model/EventStruct.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


// String url="https://jaber-server.herokuapp.com/event/myEvent";

// Future<http.Response> getMyEventSelected()async{
//
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String jwt=await prefs.getString("jwt");
//   http.Response response= await http.get(url,headers: {"x-auth-token":jwt},);
//   return response;
//
// }

Future<http.Response> getAllEventInDay(DateTime dateTime)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();

  http.Response response=await http.post("http://192.168.0.112:3000/event/AvailableEvent",
      headers: {
        "x-auth-token": prefs.getString("jwt")
      },
      body: {
    "start":dateTime.toString(),
  });
  print(response.body);
 return response;

}

Future<int> setSelectedOfEventIForId(String idEvent) async {
 try{
   SharedPreferences prefs = await SharedPreferences.getInstance();

   http.Response response= await http.post(
       "http://192.168.0.112:3000/event/selectEvent",
       headers: {
         "x-auth-token": prefs.getString("jwt")
       },
       body: {
         "id": idEvent,
       });

   print(response.body);
   if(response.statusCode==401) return -1; /// error operation
   if(response.statusCode==200) return 1 ; /// selected operation done
   if(response.statusCode==400) return 0; /// this event was seleted

   return 0;
 }catch(e){

 }
}


Future<EventStruct> getEventSelectedInProfile()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  http.Response response= await http.get(
      "http://192.168.0.112:3000/event/getMyEvent",
      headers: {
        "x-auth-token": prefs.getString("jwt")
      },);
  var result=jsonDecode(response.body);

   try{
     return  new EventStruct(
       id:result["msg"]["_id"].toString(),
       isAvailable: result["msg"]["taken"]["available"],
       startEventTime: DateTime.parse(result["msg"]["startEventTime"]).add(Duration(hours: 2)),
       endEventTime:  DateTime.parse(result["msg"]["endEventTime"]).add(Duration(hours: 2)),
     );
   }catch(e){
     return  new EventStruct(
       id:"-1".toString(),
     );
   }


}

Future<String> deleteEventById(String idEvent) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

 http.Response response=await  http.delete("http://192.168.0.112:3000/event/${idEvent}",headers: {
    "x-auth-token": prefs.getString("jwt"),
  },);

 var result= jsonDecode(response.body);
 return result["msg"];

}



// Future<http.Response> getAllEventsInDate
