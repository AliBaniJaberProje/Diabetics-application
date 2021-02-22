

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
const urlToUpdate="https://enigmatic-anchorage-82439.herokuapp.com/patient/update";

Future<bool> sendUpdateProfilePatientRequest ({String key,String value})async{
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt=await prefs.getString("jwt");

   http.Response response=await http.patch(urlToUpdate,headers: {"x-auth-token":jwt},body: {key:value});
   if(response.statusCode==200){
     return true;
   }
   return false;

  }catch(e){
    return false;
  }
}