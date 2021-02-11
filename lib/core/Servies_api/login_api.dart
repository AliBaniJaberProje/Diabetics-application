import 'package:cloud_firestore/cloud_firestore.dart';


import 'doctorsToShowInChat.dart';

class LoginApiFireBase {
  String _imgurl = "";
  String getImgUrl() {
    return this._imgurl;
  }

  Future<bool> isLogin(
    String id,
    String password,
  ) async {
    var user =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    if (user["userId"] == id &&
        user["password"] == password &&
        user["usertype"] == "Patient") {
      this._imgurl = user["imgurl"];
      StoragToPassDotorsId.idCurantDuctor = user["curuntDoctur"];
      StoragToPassDotorsId.idcurantUser = user["userId"];

      StoragToPassDotorsId.lastDocturids = List.from(user["lastdocturs"]);
      StoragToPassDotorsId.lastDocturids.insert(0,user["curuntDoctur"]);
      return true;
    } else
      return false;
  }
}
