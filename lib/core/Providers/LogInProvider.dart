import 'package:flutter/cupertino.dart';

class LoginProvider with ChangeNotifier {
  String _id;
  String _password;

  void setid(String id) {
    this._id = id;
    print(this._id);
  }

  void setPassword(String password) {
    this._password = password;
    notifyListeners();
  }

  Future<bool> isAuthorizedUser()async{
    
  }
}
