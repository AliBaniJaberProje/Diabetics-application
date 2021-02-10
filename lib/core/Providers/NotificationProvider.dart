import 'package:ali_muntaser_final_project/core/Model/NotificationStruct.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class NotificationsProvider with ChangeNotifier {

  ///------------------------------data-----------------------------------------
  int notificationNumber=0;

  var _firebaseRef = FirebaseDatabase().reference();

  List<NotificationStruct> _notificationsList = [];

  ///-----------------------------functions-------------------------------------

  void _addNotificationToList(dynamic jsonNotification) {
    this._notificationsList.add(NotificationStruct.fromJson(jsonNotification));
    notifyListeners();
  }

  void _processResult(Map data) {

    List item = [];
    data.forEach((index, data) {
      item.add({"key": index, ...data});
    });
    item.sort((b, a) {
      return int.parse(a['timestamp'].toString()).compareTo(
        int.parse(
          b['timestamp'].toString(),
        ),
      );
    });
    this.notificationNumber=0;
    for (int i = 0; i < item.length; i++) {
      if(item[i]["status"]!="seen")
         this.notificationNumber++;
      _addNotificationToList(item[i]);

    }
    notifyListeners();
  }

  ///----------------------------public functions-------------------------------

  getFireRif() => _firebaseRef;

  void startStreamNotification(String idUser) {
    try {
      _firebaseRef
          .child('notifications')
          .child(idUser)
          .onValue
          .listen((event) {
        this._notificationsList.clear();
        //this.notificationNumber = event.snapshot.value["numbernutification"];
        Map data = event.snapshot.value["notification"];
        _processResult(data);
        notifyListeners();
      });
    } catch (e) {
      print("error in  conection  stream");
    }
  }

  NotificationStruct getNotificationOf(int index){
    return _notificationsList[index];
  }

  void updateStatusToSeen(String userId,String notificationId){
    _firebaseRef.child("notifications").child(userId).child("notification").child(notificationId).update({
       "status":"seen"
    });
  }

  void deleteNotification(String userId,String notificationId){
    _firebaseRef.child("notifications").child(userId).child("notification").child(notificationId).remove();
  }

  int getNumberNotification(){
    return this._notificationsList.length;
  }

  ///--------------------------------done---------------------------------------

}
