import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MessageStruct with ChangeNotifier {
  String _id;
  String _typeMessage;
  String _data;
  Timestamp _timeSend;
  bool _isSeen;
  bool _isMe;

  bool isImageMessage() {
    return this._typeMessage == "image";
  }

  String getTimeSendFormat(){
    DateTime time = this._timeSend.toDate();
    if (DateTime.now().year == time.year &&
        DateTime.now().month == time.month &&
        DateTime.now().day == time.day) {
      return new DateFormat.Hms().format(time).toString();
    } else {
      return new DateFormat.yMMMd().format(time).toString();
    }
  }
  MessageStruct(
      {String id,
      String typeMessage,
      String data,
      Timestamp timeSend,
      bool isSeen,
      bool isMe}) {
    this._id = id;
    this._typeMessage = typeMessage;
    this._data = data;
    this._timeSend = timeSend;
    this._isSeen = isSeen;
    this._isMe = isMe;
  }
  void setSeen(){
    this._isSeen=true;
  }
  void unseen(){
    this._isSeen=false;
  }
  bool get isMe => _isMe;

  bool get isSeen => _isSeen;

  Timestamp get timeSend => _timeSend;

  String get data => _data;

  String get typeMessage => _typeMessage;

  String get id => _id;
}
