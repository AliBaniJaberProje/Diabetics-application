
import 'dart:convert';

import 'package:ali_muntaser_final_project/core/Model/DailyReadingItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class DailyReadingProvider with ChangeNotifier{

  String idUser;
  String imgUrlDoctor;
  void clearListDailyReading(){
    this.listDailyReading.clear();
  }
    
  DateTime timeforthisreading ;

  Future<void> fetchDailyReading() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt= prefs.get('jwt');
    http.Response res=await http.post("https://jaber-server.herokuapp.com/dailyReading/add",headers: {'x-auth-token':jwt});
    var result=jsonDecode(res.body)['msg'];
    if(res.statusCode==201){
       res=await http.post("https://jaber-server.herokuapp.com/dailyReading/add",headers: {'x-auth-token':jwt});
       result=jsonDecode(res.body)['msg'];
    }
    for(int i=0;i<4;i++){
      listDailyReading.insert(i,new DailyReadingItem(
        id: '${i+1}',
        take:!result[0]['inputInfo'][i]['taken'],
        value:result[0]['inputInfo'][i]['value']*1.0,
        timestamp:Timestamp.fromMillisecondsSinceEpoch(result[0]['inputInfo'][i]['timestamp']),
      ));

    }
    return ;
    // notifyListeners();

  }

  List<DailyReadingItem> listDailyReading=[];

  void addNewNotification(String body, String imgsender){
    FirebaseDatabase().reference()
        .child('notifications')
        .child(this.idUser).child('notification').push()
        .set({
      "body": body,
      "imgsender": imgsender,
      'status':'notseen',
      "timestamp": Timestamp.now().microsecondsSinceEpoch,
      "title": "type"
    });
  }

  void setTimeForThisReading(DateTime t) {
    this.timeforthisreading = t;

  }

  void setValueAndTake(int id, double val) async{
    var fbm = await FirebaseMessaging();
    var phoneToken = await fbm.getToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt= prefs.get('jwt');
    http.post("https://jaber-server.herokuapp.com/dailyReading",headers: {'x-auth-token':jwt},body: {
      'idReading':(id+1).toString(),
      'value':val.toString()
    }).then((res){
      var result=jsonDecode(res.body)['msg'];
      if(result.toString().contains("قبل الأفطار") || result.toString().contains("بعد الأفطار بساعتين") || result.toString().contains("بعد الغداء بساعتين")||result.toString().contains("بعد العشاء بساعتين")){
        addNewNotification("لم تنتظم بفحوصات السكري اليوم ","https://jaber-server.herokuapp.com/images/reaction/warning.png");
        FirebaseDatabase().reference()
            .child('pushNotification').push().set({
             "token":phoneToken,
             "title":"تنبيه",
              "body":"لم تنتظم بفحوصات السكري اليوم "
        });
      }

      print(result);
    });


         this.listDailyReading[id].value = val;
         this.listDailyReading[id].take = false;

        print(val);
        notifyListeners();
  }

  // void updateValueAndTake(int id, double val) {
  //
  //
  //
  //     if (listDailyReading[id].id == id && !listDailyReading[id].take) {
  //       this.listDailyReading[id].value = val;
  //       print("listDailyReading[id].id"+id.toString()+"!listDailyReading[id].take"+val.toString());
  //
  //     }
  //
  //   notifyListeners();
  // }

}