import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum STATUSR_NR { READ, NOT_READ }

class NotificationStruct {
  String _key;
  String _title;
  String _body;
  String _status;
  String _imgSender;
  Timestamp _timeSend;


  String get key => _key;

  NotificationStruct({
    String key,
    String imgsender,
    String body,
    String title,
    String status,
    Timestamp timestamp}){
    _key = key;
    _imgSender = imgsender;
    _body = body;
    _title = title;
    _status = status;
    _timeSend = timestamp;
  }

  String getformatTimeStamp(){
    DateTime time = this._timeSend.toDate();
    if (DateTime.now().year == time.year &&
        DateTime.now().month == time.month &&
        DateTime.now().day == time.day) {
      return new DateFormat.Hms().format(time).toString();
    } else {
      return new DateFormat.yMMMd().format(time).toString();
    }
  }

  String get title => _title;

  String get body => _body;

  String get status => _status;

  String get imgSender => _imgSender;

  Timestamp get timeSend => _timeSend;


  NotificationStruct.fromJson(dynamic json) {
    _key = json["key"];
    _imgSender = json["imgsender"];
    _body = json["body"];
    _title = json["title"];
    _status = json["status"];
    _timeSend = Timestamp.fromMicrosecondsSinceEpoch(json["timestamp"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["key"] = _key;
    map["imgsender"] = _imgSender;
    map["body"] = _body;
    map["title"] = _title;
    map["status"] = _status;
    map["timestamp"] = _timeSend;
    return map;
  }
}
