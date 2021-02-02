import 'package:ali_muntaser_final_project/core/Model/Person.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StoragToPassDotorsId {
  static String idCurantDuctor;

  static String idcurantUser;

  static List<String> lastDocturids;
  // static List<Person> doctors = [];
  // static Future<List<Person>> fetchDoctors() async {
  //   var doctor;
  //   for (int i = 0; i < lastDocturids.length; i++) {
  //     doctor = await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(lastDocturids[i])
  //         .get();
  //     doctors.add(new Person(doctor["userId"], "", "", DateTime.now(), 1,
  //         Status.ONLINE, TypeUser.DOCTURUSER, "", DateTime.now()));
  //   }
  //   for (int i = 0; i < lastDocturids.length; i++) {
  //     print(doctors[i].getId());
  //   }
  //   return doctors;
    
  // }
}
