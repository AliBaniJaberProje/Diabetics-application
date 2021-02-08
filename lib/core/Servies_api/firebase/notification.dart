


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class NotificationsFirebase with ChangeNotifier{
  int numbernotification;


  var _firebaseRef = FirebaseDatabase().reference();

  getFireRif()=>_firebaseRef;


  Stream<Event> getNotificatioFirebaseStre(String id) {
    try {
      return _firebaseRef
          .child('notifications').child(id).onValue;

    } catch (e) {
      print("error in  conection  stream");
    }
  }

  Future<int> getNumberNotification(String id) async {
    try {
      var ref=await _firebaseRef
          .child('notifications').child(id).child("numbernutification").once();
      return ref.value;

    } catch (e) {
      print("error in  conection  stream");
    }
  }







}