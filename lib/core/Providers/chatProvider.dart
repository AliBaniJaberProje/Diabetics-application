import 'dart:io';
import 'package:ali_muntaser_final_project/core/Model/doctorChatStruct.dart';
import 'package:ali_muntaser_final_project/core/Model/messageStruct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ChatProvider with ChangeNotifier {
  ///----------------------------data-------------------------------------------
  var _firebaseRef = FirebaseDatabase().reference();
  DoctorChatStruct _doctor;


  String _imgUrlPatient;
  String _idPatient;

  int numberMessagesNotRead = 0;

  final _imagePicker = ImagePicker();
  Timestamp _lastAccessTimeDoctor;
  List<MessageStruct> _chat = [];



  ///--------------------------functions----------------------------------------
  ///

  set doctor(DoctorChatStruct value) {
    _doctor = value;
  }
  DoctorChatStruct get doctor => _doctor;
  // ignore: unnecessary_getters_setters
  String get usernameDoctor => this._doctor.name;
  // ignore: unnecessary_getters_setters
  String get idDoctor => this._doctor.id;
  // ignore: unnecessary_getters_setters
  String get idPatient => _idPatient;
  // ignore: unnecessary_getters_setters
  String get imgUrlDoctor => this._doctor.imgUrl;
  // ignore: unnecessary_getters_setters
  String get imgUrlPatient => _imgUrlPatient;
  // ignore: unnecessary_getters_setters

  // ignore: unnecessary_getters_setters
  set idPatient(String value) {
    _idPatient = value;
  }
  // ignore: unnecessary_getters_setters

  // ignore: unnecessary_getters_setters
  set imgUrlPatient(String value) {
    _imgUrlPatient = value;
  }
  // ignore: unnecessary_getters_setters

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


  // ignore: missing_return
  Future<String> getImageUrlToSend(ImageSource src) async {
    File imageToSend;
    final pickedFile = await _imagePicker.getImage(source: src);
    if (pickedFile != null) {
      imageToSend = File(pickedFile.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child(Timestamp.now().microsecondsSinceEpoch.toString() + ".jpg");
      await ref.putFile(imageToSend);
      final url = await ref.getDownloadURL();
      return url;
    }
  }

  void sendMessage({String data, String type}) {
    _firebaseRef
        .child("allChat")
        .child(_idPatient)
        .child(this._doctor.id)
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
        .child(_idPatient)
        .child(this._doctor.id)
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
        .child(_idPatient)
        .child(this._doctor.id)
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
        .child(_idPatient)
        .child(this._doctor.id)
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

  ///--------------------------------done---------------------------------------
}
