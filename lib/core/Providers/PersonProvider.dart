import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../Model/Person.dart';
import '../Servies_api/doctorsToShowInChat.dart';

class PersonChatProvider with ChangeNotifier {
  List<Person> _douctursList = [];
  int _numberofmsgNotification = 3;



  Person getDoctur(int index) {
    return _douctursList[index];
  }

  void clearPreavesDoctors() {
    this._douctursList.clear();
  }

  int getNumberDoctur() {
    return this._douctursList.length;
  }

  int getNumberMsgNotRead() {
    this._numberofmsgNotification = 0;
    for (int i = 0; i < this._douctursList.length; i++) {
      this._numberofmsgNotification =
          this._numberofmsgNotification + this._douctursList[i].getNumberMsg();
    }
    return this._numberofmsgNotification;
  }

  void addDoctur(
      {String id,
      String name,
      String imgurl,
      Timestamp lastaccesstime,
      int numbermsg,
      Status status,
      TypeUser typeuser,
      DateTime timeLastMsg,
      String lastmsg}) {
    _douctursList.add(
      new Person(id, name, imgurl, lastaccesstime, numbermsg, status, typeuser,
          lastmsg, timeLastMsg),
    );
  }

  void showmsgForthisDoctur(String id) {
    for (int i = 0; i < this._douctursList.length; i++) {
      if (this._douctursList[i].getId() == id) {
        this._douctursList[i].setNumberMsg(0);
        this._numberofmsgNotification = this._numberofmsgNotification -
            this._douctursList[i].getNumberMsg();
      }
    }
    notifyListeners();
  }

  Future<void> fetchDoctors() async {
    for (int i = 0; i < StoragToPassDotorsId.lastDocturids.length; i++) {
      String idDoctur = StoragToPassDotorsId.lastDocturids[i];
      var user = await FirebaseFirestore.instance
          .collection("users")
          .doc(idDoctur)
          .get();
      this.addDoctur(
          id: user["userId"],
          name: user["username"],
          imgurl: user["imgurl"],
          lastaccesstime: user["lastAccessTime"],
          numbermsg: 3,
          status: user["status"] == "online" ? Status.ONLINE : Status.OFLINE,
          lastmsg: "قم بمراجعتي",
          timeLastMsg: DateTime.now());
      notifyListeners();
    }
  }
}
