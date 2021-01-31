import 'package:ali_muntaser_final_project/core/Model/Person.dart';
import 'package:ali_muntaser_final_project/core/Model/msg.dart';
import 'package:flutter/widgets.dart';

class MsgProvider with ChangeNotifier {
  List<Msg> _chat = [];
  Person _doctur;

  void setMsgFromServerForThisDoctur(Person doctur) {
    this._doctur = doctur;
  }

  Msg getMSG(int index) {
    return this._chat[this._chat.length-1-index];
  }

  Person getDocturToSendMsg() {
    return this._doctur;
  }

  int getNumberMsg() {
    return this._chat.length;
  }

  void sendMsgToDoctur({
    String message,
    bool isMe = true,
    DateTime dateTime,
    bool isShow = false,
  }) {
    this._chat.add(new Msg(message, isMe, dateTime, isShow, this._doctur));
  }

  MsgProvider() {
    this.sendMsgToDoctur(
      message: "مرحبا",
      isMe: false,
      dateTime: DateTime.now(),
      isShow: false,
    );
    this.sendMsgToDoctur(
      message: "انا طبيبك",
      isMe: false,
      dateTime: DateTime.now(),
      isShow: false,
    );
    this.sendMsgToDoctur(
      message: " اتمنا ان تلتزم بالوصفات الطبية",
      isMe: false,
      dateTime: DateTime.now(),
      isShow: false,
    );
    this.sendMsgToDoctur(
      message: "ان شالله",
      isMe: true,
      dateTime: DateTime.now(),
      isShow: false,
    );
    this.sendMsgToDoctur(
      message: "مع السلامة",
      isMe: true,
      dateTime: DateTime.now(),
      isShow: false,
    );


  }
}
