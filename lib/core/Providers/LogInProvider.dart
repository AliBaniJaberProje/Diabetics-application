
import 'package:ali_muntaser_final_project/core/Model/Person.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier {
  String _id;
  String _password;
  bool _visibil=false;
  bool _lodingLoginStatus=false;
  String doctorName="";


  void setid(String id) {
    this._id = id;
  }
  void setPassword(String password) {
    this._password = password;
  }
  Future<Person> isAuthorizedUser()async{
    
  }
  bool visibilStatePassword(){
    return this._visibil;
  }
  void toggleVisibilStatePassword(){
    this._visibil=!this._visibil;
    notifyListeners();
  }

  bool lodingLoginStatus(){
    return this._lodingLoginStatus;
  }
  void setLodingLoginStatus(){
    this._lodingLoginStatus=true;
    notifyListeners();
  }
  void reastLodingLoginStatus(){
    this._lodingLoginStatus=false;
    notifyListeners();
  }


}
