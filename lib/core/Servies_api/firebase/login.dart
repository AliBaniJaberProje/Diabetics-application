import 'package:ali_muntaser_final_project/core/Model/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UsersFirebase {
  var _firebaseRef = FirebaseDatabase().reference();

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
            for (int i = 1; i < lastDoctorsList.length; i++) {
              lastDoctorsList[i - 1] = lastDoctorsList[i];
            }

            Patient patient = Patient(
                id: snapshot.value["userid"],
                username: snapshot.value["username"],
                idCurantDoctur: snapshot.value["curant_doctor_id"],
                imgurl: snapshot.value["imgurl"],
                phoneNumber: snapshot.value["phoneNumber"],
                location: snapshot.value["location"],
                length: double.parse(snapshot.value["height"]),
                weight: double.parse(snapshot.value["weight"]),
                dateBirth: Timestamp.fromMicrosecondsSinceEpoch(
                  snapshot.value["dateBirth"],
                ),
                diabtesType: snapshot.value["diabtesType"],
                lastDoctor: lastDoctorsList);

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
