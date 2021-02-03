import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

/// done--------------------------
///
///

class ChatProvider with ChangeNotifier {
  String _sendIdUser;

  String _reacevidDoctors;

  String _imgurlSender;
  String _imgurlRecever;
  String _usernameDoctur;//
  Timestamp _timestamplastaccess;

  void setTimeLastAccessChat(Timestamp timestamp){
    this._timestamplastaccess=timestamp;
    notifyListeners();

  }
  Timestamp getTimeLastAccessChat(){
    return this._timestamplastaccess;
  } 

  bool _online;

  void setUserNameDoctor(String username) {
    this._usernameDoctur = username;
  }

  String getUserNameDoctor() {
    return this._usernameDoctur;
  }

  // ChatProvider({
  //   this.sendIdUser,
  //   this.reacevidDoctors,
  //   this.imgurlSender,
  //   this.imgurlRecever,
  //   this.online,
  // });

  String getIdSender(){
    return this._sendIdUser;
  }

  void setImgUrlSender(String imgurlsender) {//
    this._imgurlSender = imgurlsender;
  }

  void setImgRecever(String imgrecev) {//
    this._imgurlRecever = imgrecev;
  }

  void setSenderId(String idsender) {
    this._sendIdUser = idsender;
  }

  void setReceverId(String idrecever) {
    this._reacevidDoctors = idrecever;
  }

  void setOnline() {
    this._online = true;
  }

  void setOfline() {
    this._online = false;
  }

  String getReceverId() {
    return this._reacevidDoctors;
  }

  String getImgUrlSender() {//
    return this._imgurlSender;
  }

  String getImgUrlRecever() {//
    return this._imgurlRecever;
  }

  bool isOnline() {
    return this._online;
  }


}
