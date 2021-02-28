import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class MessagesProvider with ChangeNotifier {
  //---------------------------------------data--------------------------

  String _imgURLSender;
  String _imgURLRecever;
  String _usernameDoctor;
  String _senderIdPatient;
  String _receiverIdDoctor;
  bool _online;

  var _firebaseRef = FirebaseDatabase().reference();

  //----------------------------------------privet data-----------------

  final imagepicker = ImagePicker();

  //-------------------------------------methods------------------------

  void setUserNameDoctor(String username) {
    this._usernameDoctor = username;
  }

  void setImgUrlSender(String imgurlsender) {
    this._imgURLSender = imgurlsender;
  }

  get firebaseRefRoot => _firebaseRef;

  void setImgRecever(String imgrecev) {
    this._imgURLRecever = imgrecev;
  }

  void setSenderId(String idsender) {
    this._senderIdPatient = idsender;
  }

  void setReceverId(String idrecever) {
    this._receiverIdDoctor = idrecever;
  }

  void setStatusRecever(bool status) {
    this._online = status;
  }

  String getReceverId() {
    return this._receiverIdDoctor;
  }

  String getImgUrlSender() {
    return this._imgURLSender;
  }

  String getImgUrlRecever() {
    return this._imgURLRecever;
  }

  String getUserNameDoctor() {
    return this._usernameDoctor;
  }

  String getIdSenderPatient() {
    return this._senderIdPatient;
  }

  bool isOnline() {
    return this._online;
  }

  // ignore: missing_return
  Stream<Event> fetchStreamMessages(String idSender, String idReceiver) {
    try {
      return _firebaseRef
          .child('chat')
          .child(idSender)
          .child(idReceiver)
          .child("messages")
          .child("chat")
          .onValue;
    } catch (e) {
      print("error in  conection  stream");
    }
  }

  Future<String> getImageUrlToSend(ImageSource src) async {
    File imageToSend ;
    final pickedfile = await imagepicker.getImage(source: src);
    if (pickedfile != null) {
      imageToSend = File(pickedfile.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child(Timestamp.now().microsecondsSinceEpoch.toString() + ".jpg");
      await ref.putFile(imageToSend);
      final url = await ref.getDownloadURL();
      return url;
    }
  }

  void sendMessage(
      String idSender, String idReceiver, String data, String typeMessage) {
    this
        ._firebaseRef
        .child('chat')
        .child(idSender)
        .child(idReceiver)
        .child("messages")
        .child("chat")
        .push()
        .set({
         'type':typeMessage,
        'isPatient': true,
        'message': data,
        'timestamp': Timestamp.now().microsecondsSinceEpoch,
    });
  }
}
