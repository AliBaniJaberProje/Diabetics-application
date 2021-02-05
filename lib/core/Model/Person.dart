import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';


enum Status { ONLINE, OFLINE }
enum TypeUser { NURMALUSER, DOCTURUSER }

class Person {
  String _id;
  String _name;
  String _imgURL;
  Timestamp _lastAccessTime;
  String _lastmsg;
  int _numbermsg;
  Status _status;
  TypeUser _typeuser;
  DateTime _timeLastMsg;
 
  Person(
      this._id,
      this._name,
      this._imgURL,
      this._lastAccessTime,
      this._numbermsg,
      this._status,
      this._typeuser,
      this._lastmsg,
      this._timeLastMsg);



  void setLastmsg(String msg) {
    this._lastmsg = msg;
  }

  String getlastmsg() {
    return this._lastmsg;
  }

  bool isOnline() {
    if (this._status == Status.ONLINE) return true;
    return false;
  }

  bool isOfline() {
    if (this._status == Status.OFLINE) return true;
    return false;
  }

  void setTimeLastMsg(DateTime time) {
    this._timeLastMsg = time;
  }

  String getFormatLastMsgTime() {
    if (this._timeLastMsg.day == DateTime.now().day - 1) {
      return "امس            ";
    } else if (this._timeLastMsg.day == DateTime.now().day) {
      return this._timeLastMsg.hour.toString() +
          ":" +
          this._timeLastMsg.minute.toString() +
          "         ";
    } else if (this._timeLastMsg.year == DateTime.now().year) {
      return new DateFormat.MMMd().format(this._timeLastMsg) + "   ";
    } else {
      return new DateFormat.yMMMd().format(this._timeLastMsg);
    }
  }

  void setId(String id) {
    this._id = id;
  }

  String getId() {
    return this._id;
  }

  void setName(String name) {
    this._name = name;
  }

  String getName() {
    return this._name;
  }

  void setImgURL(String imgurl) {
    this._imgURL = imgurl;
  }

  String getImgURL() {
    return this._imgURL;
  }

  void setLastAccessTime(Timestamp time) {
    this._lastAccessTime = time;
  }

  Timestamp getLastAccessTime() {
    return this._lastAccessTime;
  }

  void setNumberMsg(int numbermsg) {
    this._numbermsg = numbermsg;
  }

  int getNumberMsg() {
    return this._numbermsg;
  }

  void setOnline() {
    this._status = Status.ONLINE;
  }

  void setOfline() {
    this._status = Status.OFLINE;
  }

  Status getStat() {
    return this._status;
  }

  void setDoctur() {
    this._typeuser = TypeUser.DOCTURUSER;
  }

  void setNormalUser() {
    this._typeuser = TypeUser.NURMALUSER;
  }

  TypeUser getTypeUser() {
    return this._typeuser;
  }
}
