import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum STATUSR_NR { READ, NOT_READ }

class NotificationStruct {
  int id;
  String title;
  String body;
  String imgsender;
  Timestamp timesend;

  NotificationStruct({this.id, this.title, this.body, this.imgsender, this.timesend});

  String getformatTimeStamp(){
    DateTime time = this.timesend.toDate();
    if (DateTime.now().year == time.year &&
        DateTime.now().month == time.month &&
        DateTime.now().day == time.day) {
      return new DateFormat.Hms().format(time).toString();
    } else {
      return new DateFormat.yMMMd().format(time).toString();
    }
  }


}
