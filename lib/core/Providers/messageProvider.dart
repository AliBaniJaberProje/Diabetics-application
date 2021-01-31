import 'package:ali_muntaser_final_project/core/Model/Message.dart';
import 'package:ali_muntaser_final_project/core/Model/Person.dart';
import 'package:flutter/cupertino.dart';

class MessageProvider with ChangeNotifier {
  Person _docturToChat=null;
  int id = 1;

  void setDocturToChat({@required Person doctur}) {
    this._docturToChat = doctur;
    ///////// send api to get chat and put in list
  }
  int getNumberOfMsg(){
    return this._MessageChat.length;
  }

  List<Message> _MessageChat = [];

  void sendMessage({String title, Person to, DateTime timesend}) {
    this._MessageChat.add(
          new Message(
              this.id.toString(), title, to ,timesend, null, null, false),
        );
        this.id++;
  }

  Message getMessage(int index) {
    return this._MessageChat[index];
  }

  MessageProvider() {
    this.sendMessage(
    title: "انا طبيبك ",
      to: this._docturToChat,
      timesend: DateTime.parse("2021-01-31 01:30:30"),
    );
     this.sendMessage(
    title: "كيف صحتك",
      to: this._docturToChat,
      timesend: DateTime.parse("2021-01-31 01:30:30"),
    );
    this.sendMessage(
      title: "مرحبا",
      to: this._docturToChat,
      timesend: DateTime.now(),
    );
    this.sendMessage(
      title: ":كيفك دكتور",
      to: this._docturToChat,
      timesend: DateTime.now(),
    );
    this.sendMessage(
      title: "شو الاخبار",
      to: this._docturToChat,
      timesend: DateTime.now(),
    );
    notifyListeners();
  }
}
