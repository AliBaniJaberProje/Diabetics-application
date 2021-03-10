import 'dart:io';

import 'package:ali_muntaser_final_project/core/Model/messageStruct.dart';
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

  set online(bool value) {
    _online = value;
  }

  final _imagePicker = ImagePicker();
  Timestamp _lastAccessTimeDoctor;
  List<MessageStruct> _chat = [];
  int numberMessagesNotRead = 0;


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




  MessageStruct getMessageAt({int index}) => _chat[index];
  // ignore: unnecessary_getters_setters

  int getNumberMessages() {
    return _chat.length;
  }


  ///----------------------------public functions-------------------------------

  void getNumberOfMessagesFromDoctor(String patientId,String doctorId){
    _firebaseRef
        .child("allChat")
        .child(patientId)
        .child(doctorId)
        .child("messages")
        .child('countMessages').child("numberFromDoctors").onValue.listen((event) {
      this.numberMessagesNotRead=event.snapshot.value;
      notifyListeners();
    });
  }


  void sendMessage({String data, String type}) {
    _firebaseRef
        .child("allChat")
        .child(_senderIdPatient)
        .child(_receiverIdDoctor)
        .child("messages")
        .child('chat')
        .push()
        .set({
      "data": data,
      "isPatient": true,
      "timestamp": Timestamp.now().microsecondsSinceEpoch,
      "type": type
    });
    updateAccessTimePatient();
  }

  void updateAccessTimePatient() {
    var rif = _firebaseRef
        .child("allChat")
        .child(_senderIdPatient)
        .child(_receiverIdDoctor)
        .child("messages");

    rif.child('time').update(
        {"lastAccessTimePatient": Timestamp.now().microsecondsSinceEpoch});
    rif.child("countMessages").update({"numberFromDoctors": 0});
  }

  void clearChatWhenClose() {
    this._chat.clear();
  }

  void startStreamChat() {
    _firebaseRef
        .child("allChat")
        .child(_senderIdPatient)
        .child(_receiverIdDoctor)
        .child("messages")
        .child('chat')
        .orderByChild("timestamp")
        .onChildAdded
        .listen(
          (event) {
        var obj = event.snapshot.value;
        print(obj);
        _chat.insert(
          0,
          MessageStruct(
            id: "event.snapshot.value[]",
            typeMessage: obj["type"],
            isMe: obj["isPatient"],
            timeSend: Timestamp.fromMicrosecondsSinceEpoch(obj["timestamp"]),
            data: obj["data"],
            isSeen: _lastAccessTimeDoctor.microsecondsSinceEpoch >=
                obj["timestamp"],
          ),
        );
        notifyListeners();
      },
    );
  }

  void startListenLastAccessTimeDoctor() {
    _firebaseRef
        .child("allChat")
        .child(_senderIdPatient)
        .child(_receiverIdDoctor)
        .child("messages")
        .child('time')
        .child("lastAccessTimeDoctor")
        .onValue
        .listen((event) {
      _lastAccessTimeDoctor =
          Timestamp.fromMicrosecondsSinceEpoch(event.snapshot.value);

      for (int i = 0; i < _chat.length; i++) {
        if (_lastAccessTimeDoctor.microsecondsSinceEpoch >=
            _chat[i].timeSend.microsecondsSinceEpoch) {
          _chat[i].setSeen();
        } else {
          this.numberMessagesNotRead++;
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

}
