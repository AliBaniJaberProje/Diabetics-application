

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
const urlToUpdate="https://jaber-server.herokuapp.com/patient/updateInfo";

Future<bool> sendUpdateProfilePatientRequest ({String key,String value})async{
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt=await prefs.getString("jwt");
   print({key:value}.toString());
   http.Response response=await http.patch(urlToUpdate,headers: {"x-auth-token":jwt},body: {key:value});
   print(response);
    print(response.body);
   if(response.statusCode==200){

     return true;
   }
   return false;

  }catch(e){
    print("error");
    return false;
  }
}


Future<Map<String,dynamic>> getIdAndIdCurrentDoctor()async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  http.Response response=await http.get("https://jaber-server.herokuapp.com/patient/getIdCurrentDoctorAndMyId",headers: {"x-auth-token":prefs.getString('jwt')});
  print("\n\n\n"+prefs.getString('jwt')+"\n\n\n");
  if(response.statusCode==200){
    return jsonDecode(response.body)["patient"];
  }else{
    return {"msg":"error"};
  }

}

