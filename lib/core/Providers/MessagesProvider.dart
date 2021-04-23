import 'dart:async';
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
  //bool loading=false;

  set online(bool value) {
    _online = value;
  }

  final _imagePicker = ImagePicker();
  Timestamp _lastAccessTimeDoctor;
  List<MessageStruct> _chat = [];
  int numberMessagesNotRead = 0;


  var _firebaseRef = FirebaseDatabase().reference();

  StreamSubscription<Event> _messagesSubscription;
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

  int getNumberMessages() {
    return _chat.length;
  }

  ///----------------------------public functions-------------------------------

  void getNumberOfMessagesFromDoctor(String patientId,String doctorId){
    FirebaseDatabase().reference()
        .child("allChat")
        .child(patientId)
        .child(doctorId)
        .child("messages")
        .child('countMessages').child("numberFromDoctors").onValue.listen((event) {
      this.numberMessagesNotRead=event.snapshot.value;
      notifyListeners();
    });
  }

  void sendMessage({String data, String type}) async{

    print("\n\n\n\n\n\n\n");

    print(new DateTime.now().millisecondsSinceEpoch);

    print(DateTime.now().millisecondsSinceEpoch);

    print("\n\n\n\n\n\n\n");


    FirebaseDatabase().reference()
        .child("allChat")
        .child(_senderIdPatient)
        .child(_receiverIdDoctor)
        .child("messages")
        .child('chat')
        .push()
        .set({
      "data": data,
      "isPatient": true,
      "timestamp":new  DateTime.now().millisecondsSinceEpoch,
      "type": type
    });


    //
    // FirebaseDatabase().reference()
    //     .child("allChat")
    //     .child(_senderIdPatient)
    //     .child(_receiverIdDoctor)
    //     .child("messages")
    //     .child('chat')
    //     .push()
    //     .set({
    //   "data": data,
    //   "isPatient": true,
    //   "timestamp":new  DateTime.now().millisecondsSinceEpoch,
    //   "type": type
    // });

    var map=await FirebaseDatabase().reference()
        .child("allChat")
        .child(_senderIdPatient)
        .child(_receiverIdDoctor)
        .child("messages").child("countMessages").once();

    int numberFromPatient=map.value['numberFromPatient'];

    FirebaseDatabase().reference()
        .child("allChat")
        .child(_senderIdPatient)
        .child(_receiverIdDoctor)
        .child("messages").child("countMessages").update({
      "numberFromPatient":numberFromPatient+1

    });


  updateAccessTimePatient();
  }

  void updateAccessTimePatient() {
    var rif = FirebaseDatabase().reference()
        .child("allChat")
        .child(_senderIdPatient)
        .child(_receiverIdDoctor)
        .child("messages");

    rif.child('time').update(
        {"lastAccessTimePatient": (new DateTime.now().millisecondsSinceEpoch)   }  );
    rif.child("countMessages").update({"numberFromDoctors": 0});
  }

  void clearChatWhenClose() {
    this._chat.clear();
    this._messagesSubscription.cancel();
  }

  void clearChatWhenClose2() {
    this._chat.clear();

  }
  void startStreamChat() {
   // loading=true;
    _messagesSubscription= _firebaseRef
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

        _chat.insert(0,MessageStruct(
            id: Timestamp.fromMillisecondsSinceEpoch(obj["timestamp"]).toString(),
            typeMessage: obj["type"],
            isMe: obj["isPatient"],
            timeSend: Timestamp.fromMillisecondsSinceEpoch(obj["timestamp"]),
            data: obj["data"],
            isSeen: _lastAccessTimeDoctor.millisecondsSinceEpoch >=
                obj["timestamp"],
          ),);

        notifyListeners();
      },
    );
   // loading=false;
    //notifyListeners();

  }

  void startListenLastAccessTimeDoctor() {
    FirebaseDatabase().reference()
        .child("allChat")
        .child(_senderIdPatient)
        .child(_receiverIdDoctor)
        .child("messages")
        .child('time')
        .child("lastAccessTimeDoctor")
        .onValue
        .listen((event) {
      _lastAccessTimeDoctor =
          Timestamp.fromMillisecondsSinceEpoch(event.snapshot.value);

      for (int i = 0; i < _chat.length; i++) {
        if (_lastAccessTimeDoctor.millisecondsSinceEpoch >
            _chat[i].timeSend.millisecondsSinceEpoch) {
          _chat[i].setSeen();
        } else {
          this.numberMessagesNotRead++;
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void createColectionToThisDoctor(String idPatent,String idDoctor){
    _firebaseRef.child("allChat").child(idPatent).child(idDoctor).set({
        "messages":{
    "chat":{},
    "countMessages":{
    "numberFromDoctors":0,
    "numberFromPatient":0
    },
    "time":{
    "lastAccessTimeDoctor":0,
    "lastAccessTimePatient":0
    }
    }}
    );
  }

}
