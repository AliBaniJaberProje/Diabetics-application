import 'package:ali_muntaser_final_project/core/Model/Person.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier {
  String _id;
  String _password;

  void setid(String id) {
    this._id = id;
  }
  void setPassword(String password) {
    this._password = password;
  }
  Future<Person> isAuthorizedUser()async{
    
  }
}
