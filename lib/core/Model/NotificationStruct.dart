import 'package:flutter/foundation.dart';

enum STATUSR_NR { READ, NOT_READ }

class NotificationStruct {
  int id;
  String title;
  String auther;
  STATUSR_NR statusR_NR;
  DateTime dateTime;

  NotificationStruct(
      {@required this.id,
      @required this.title,
      @required this.auther,
      this.statusR_NR = STATUSR_NR.NOT_READ,
      this.dateTime  ,});
}
