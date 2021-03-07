

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