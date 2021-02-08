
import 'dart:async';

import 'package:ali_muntaser_final_project/core/Model/NotificationStruct.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsProvider with ChangeNotifier {
  int NotificationsNumber = 8;
  int _NotificationsNumberNotReaded=10;

  List<NotificationStruct> NotificationsList = [];


  var _firebaseRef = FirebaseDatabase().reference();

  getFireRif()=>_firebaseRef;




  Stream<List> getNotificatioFirebaseStre(String id) {
    try {
      print("in try");
 _firebaseRef

          .child('notifications').child("123456789").onValue.listen((event) {
            
           // _firebaseRef.child('notifications').child("123456789").child("notification").child("numbernutification")
            print(event.snapshot.value["numbernutification"]);
            this.NotificationsNumber=event.snapshot.value["numbernutification"];
            var t=event.snapshot.value;
            notifyListeners();
            List<dynamic> item = [];

 });




    } catch (e) {
      print("error in  conection  stream");
    }
  }


  int getNotReadNotificationNumber(){
    return _NotificationsNumberNotReaded;
  }
  void setNotificationReadedDone(int id){

    // for(int i =0; i<NotificationsList.length;i++){
    //   if(NotificationsList[i].id==id && NotificationsList[i].statusR_NR==STATUSR_NR.NOT_READ){
    //     NotificationsList[i].statusR_NR=STATUSR_NR.READ;
    //     _NotificationsNumberNotReaded--;
    //     break;
    //   }
    // }
    notifyListeners();
  }


  // void addNotification(int id, String title, String auther, STATUSR_NR status,
  //     DateTime dateTime) {
  //   NotificationsList.add(new NotificationStruct(
  //       id: id,
  //       title: title,
  //       auther: auther,
  //       statusR_NR: status,
  //       dateTime: dateTime));
  //
  //   this.NotificationsNumber++;
  //   this._NotificationsNumberNotReaded++;
  //   notifyListeners();
  // }
  //
  // void deleteNotifcation(int id){
  //   for(int i =0; i<NotificationsList.length;i++){
  //     if(NotificationsList[i].id==id){
  //       if(NotificationsList[i].statusR_NR==STATUSR_NR.READ){
  //         NotificationsNumber--;
  //       }
  //       else if(NotificationsList[i].statusR_NR==STATUSR_NR.NOT_READ){
  //         NotificationsNumber--;
  //         _NotificationsNumberNotReaded--;
  //       }
  //       NotificationsList.removeAt(i);
  //
  //     }
  //   }
  //
  //   notifyListeners();
  // }



}