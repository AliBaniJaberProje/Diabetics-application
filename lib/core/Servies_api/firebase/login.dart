import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Patient {
  String _id;
  String _username;
  String _idCurantDoctur;
  String _imgurl;

  List<dynamic> _lastdoctor = [];
  String getFromLastDoctor(int index) {
    return this._lastdoctor[index];
  }

  Patient(this._id, this._username, this._idCurantDoctur, this._imgurl,
      this._lastdoctor);
}

class UsersFirebase {
  var _firebaseRef = FirebaseDatabase().reference();

  getRif() {
    return _firebaseRef;
  }

  Future<Map<String,dynamic>> isAuthorized(String userid, String password)  async {
    var fbm = FirebaseMessaging();
    Map<String,dynamic> return_data=new Map<String,dynamic>();
    _firebaseRef.child("users").child(userid).once().then(
      (DataSnapshot snapshot) async {
        try {
          if (snapshot.value["password"].toString() == password &&
              snapshot.value["usertype"] == "patient") {
            Map<dynamic, dynamic> lastdoctor =
                snapshot.value["lastdocturs"] as Map;

            List<dynamic> lastDoctorsList = lastdoctor.values.toList();

            Patient patient = Patient(
                snapshot.value["userid"],
                snapshot.value["username"],
                snapshot.value["curant_doctor_id"],
                snapshot.value["imgurl"],
                lastDoctorsList);

           await fbm.getToken().then(
              (token) {
                _firebaseRef
                    .child("users")
                    .child(snapshot.value["userid"])
                    .update(
                  {"token": token},
                ).then((value) {
                  return_data["status"]="yes";
                  return_data["patient"]=patient;
                  print(return_data);
                });
              },
            );





          } else {
            print("no not login user");
            return_data["status"]="no";
            return   return_data ;
          }
        } catch (e) {
          print("exaption");
          return_data["status"]="no";
          return return_data;
        }
      },
    );
  }
}
