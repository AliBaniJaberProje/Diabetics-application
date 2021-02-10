import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Patient {
  String _id;
  String _username;
  String _idCurantDoctur;
  String _imgurl;
  String _phoneNumber;
  String _location;
  double _length;
  double _weight;
  Timestamp _dateBirth;
  String _diabtesType;

  List<dynamic> _lastdoctor = [];
  String getFromLastDoctor(int index) {
    return this._lastdoctor[index];
  }

  Patient(
      this._id,
      this._username,
      this._idCurantDoctur,
      this._imgurl,
      this._phoneNumber,
      this._location,
      this._length,
      this._weight,
      this._dateBirth,
      this._diabtesType,
      this._lastdoctor);

  List<dynamic> get lastdoctor => _lastdoctor;

  Timestamp get dateBirth => _dateBirth;

  String get diabtesType => _diabtesType;

  double get weight => _weight;

  double get length => _length;

  String get location => _location;

  String get phoneNumber => _phoneNumber;

  String get imgurl => _imgurl;

  String get idCurantDoctur => _idCurantDoctur;

  String get username => _username;

  String get id => _id;
}

class UsersFirebase {
  var _firebaseRef = FirebaseDatabase().reference();

  getRif() {
    return _firebaseRef;
  }

  Future<Map<String, dynamic>> isAuthorized(
      String userid, String password) async {
    var fbm = await FirebaseMessaging();
    Map<String, dynamic> return_data = new Map<String, dynamic>();

    var p = _firebaseRef.child("users").child(userid).once();
    return await p.then(
      (DataSnapshot snapshot) async {
        try {
          if (snapshot.value["password"].toString() == password &&
              snapshot.value["usertype"] == "patient") {
            List<dynamic> lastdoctor = snapshot.value["lastdocturs"] as List;

            List<dynamic> lastDoctorsList = lastdoctor.toList();
            for(int i=1;i<lastDoctorsList.length;i++){
              lastDoctorsList[i-1]=lastDoctorsList[i];
            }

            Patient patient = Patient(
                snapshot.value["userid"],
                snapshot.value["username"],
                snapshot.value["curant_doctor_id"],
                snapshot.value["imgurl"],
                snapshot.value["phoneNumber"],
                snapshot.value["location"],
                double.parse(snapshot.value["height"]),
                double.parse(snapshot.value["weight"]),
                Timestamp.fromMicrosecondsSinceEpoch(
                    snapshot.value["dateBirth"]),
                snapshot.value["diabtesType"],
                lastDoctorsList);

            var token = await fbm.getToken();

            var instans = await _firebaseRef
                .child("users")
                .child(snapshot.value["userid"]);
            await instans.update(
              {"token": token},
            );

            return_data["status"] = "yes";
            return_data["patient"] = patient;
            return await return_data;
          } else {
            print("no not login user");
            return_data["status"] = "no";
            return return_data;
          }
        } catch (e) {
          print("exaption ali");
          return_data["status"] = "no";
          return return_data;
        }
      },
    );
  }
}
