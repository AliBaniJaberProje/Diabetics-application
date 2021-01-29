



import 'package:ali_muntaser_final_project/core/Model/NotificationStruct.dart';
import 'package:flutter/cupertino.dart';

class NotificationsProvider with ChangeNotifier {
  int NotificationsNumber = 10;
  int _NotificationsNumberNotReaded=10;

  List<NotificationStruct> NotificationsList = [
    new NotificationStruct(
        id: 1,
        title: "قلل من تناول السكريات ",
        auther: "التغذية",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
    new NotificationStruct(
        id: 2,
        title: "قم باجراء فحص القلب",
        auther: "الطبيب",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
    new NotificationStruct(
        id: 3,
        title: "قم بمراجعة الطبيب",
        auther: "التطبيق",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
    new NotificationStruct(
        id: 4,
        title: "قم بمراجعة الطبيب",
        auther: "التطبيق",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
    new NotificationStruct(
        id: 5,
        title: "قم بمراجعة الطبيب",
        auther: "التطبيق",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
    new NotificationStruct(
        id: 6,
        title: "قم بمراجعة الطبيب",
        auther: "التطبيق",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
    new NotificationStruct(
        id: 7,
        title: "قم بمراجعة الطبيب",
        auther: "التطبيق",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
    new NotificationStruct(
        id: 8,
        title: "قم بمراجعة الطبيب",
        auther: "التطبيق",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
    new NotificationStruct(
        id: 9,
        title: "قم بمراجعة الطبيب",
        auther: "التطبيق",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
    new NotificationStruct(
        id: 10,
        title: "قم بمراجعة الطبيب",
        auther: "التطبيق",
        statusR_NR: STATUSR_NR.NOT_READ,
        dateTime: DateTime.now()),
  ];

  int getNotReadNotificationNumber(){
    return _NotificationsNumberNotReaded;
  }
  void setNotificationReadedDone(int id){

    for(int i =0; i<NotificationsList.length;i++){
      if(NotificationsList[i].id==id && NotificationsList[i].statusR_NR==STATUSR_NR.NOT_READ){
        NotificationsList[i].statusR_NR=STATUSR_NR.READ;
        _NotificationsNumberNotReaded--;
        break;
      }
    }
    notifyListeners();
  }


  void addNotification(int id, String title, String auther, STATUSR_NR status,
      DateTime dateTime) {
    NotificationsList.add(new NotificationStruct(
        id: id,
        title: title,
        auther: auther,
        statusR_NR: status,
        dateTime: dateTime));

        this.NotificationsNumber++;
        this._NotificationsNumberNotReaded++;
        notifyListeners();
  }

  void deleteNotifcation(int id){
   for(int i =0; i<NotificationsList.length;i++){
     if(NotificationsList[i].id==id){
       if(NotificationsList[i].statusR_NR==STATUSR_NR.READ){
         NotificationsNumber--;
       }
       else if(NotificationsList[i].statusR_NR==STATUSR_NR.NOT_READ){
         NotificationsNumber--;
         _NotificationsNumberNotReaded--;
       }
       NotificationsList.removeAt(i);

     }
   }

   notifyListeners();
  }



}
