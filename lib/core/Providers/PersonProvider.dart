import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../Model/Person.dart';
import '../Servies_api/doctorsToShowInChat.dart';

class PersonChatProvider with ChangeNotifier {
  List<Person> _douctursList = [];

  Person getDoctur(int index) {
    return _douctursList[index];
  }

void clearPreavesDoctors(){
  this._douctursList.clear();
}

  Person getDocturWherId(String id) {
    for (int i = 0; i < this._douctursList.length; i++) {
      if (this._douctursList[i].getId() == id) return this._douctursList[i];
    }
  }

  int _numberofmsgNotification = 0;

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

  PersonChatProvider() {
    // addDoctur(
    //   id: "1",
    //   name: "   د. اسامة جميل",
    //   imgurl:
    //       "https://i.pinimg.com/originals/aa/7c/82/aa7c829eb316ab1d077a5768188ee622.jpg",
    //   lastaccesstime: DateTime.parse("2021-01-28"),
    //   numbermsg: 6,
    //   status: Status.OFLINE,
    //   typeuser: TypeUser.DOCTURUSER,
    //   lastmsg: "نعم صحيح",
    //   timeLastMsg: DateTime.parse("2021-01-28"),
    // );
    // addDoctur(
    //   id: "2",
    //   name: "د. احمد عبدالحق",
    //   imgurl:
    //       "https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_960_720.jpg",
    //   lastaccesstime: DateTime.parse("2021-01-29"),
    //   numbermsg: 1,
    //   status: Status.ONLINE,
    //   typeuser: TypeUser.DOCTURUSER,
    //   lastmsg: "قم بممارسة نشاط رياضي",
    //   timeLastMsg: DateTime.parse("2021-01-29"),
    // );
    // addDoctur(
    //   id: "3",
    //   name: "   د انسام محمد",
    //   imgurl:
    //       "https://qodebrisbane.com/wp-content/uploads/2019/07/This-is-not-a-person-2-1.jpeg",
    //   lastaccesstime: DateTime.parse("2021-01-30 23:40:30"),
    //   numbermsg: 4,
    //   status: Status.ONLINE,
    //   typeuser: TypeUser.DOCTURUSER,
    //   lastmsg: "قم بمراجعتي بالمركز الطبي",
    //   timeLastMsg: DateTime.parse("2021-01-30 23:30:30"),
    // );
    // addDoctur(
    //   id: "4",
    //   name: "   د ايمان محمد",
    //   imgurl:
    //       "https://qodebrisbane.com/wp-content/uploads/2019/07/This-is-not-a-person-2-1.jpeg",
    //   lastaccesstime: DateTime.parse("2021-01-30 23:40:30"),
    //   numbermsg: 2,
    //   status: Status.ONLINE,
    //   typeuser: TypeUser.DOCTURUSER,
    //   lastmsg: "قم بمراجعتي بالمركز الطبي",
    //   timeLastMsg: DateTime.parse("2020-01-03 23:30:30"),
    // );

    // notifyListeners();
  }

  Future<void> fetchDoctors() async {
    //var user;
    // StoragToPassDotorsId.lastDocturids[i]

    for (int i = 0; i < StoragToPassDotorsId.lastDocturids.length; i++) {
       print(StoragToPassDotorsId.lastDocturids[i]);
      String idDoctur= StoragToPassDotorsId.lastDocturids[i];
      print(idDoctur);
         var user =
        await FirebaseFirestore.instance.collection("users").doc(idDoctur).get();
          this.addDoctur(
            id: user["userId"],
            name:  user["username"],
            imgurl: user["imgurl"],
            lastaccesstime: user["lastAccessTime"],
            numbermsg: 3,
            status: user["status"]=="online"?Status.ONLINE:Status.OFLINE,
            lastmsg: "قم بمراجعتي",
            timeLastMsg:DateTime.now()

          );
          notifyListeners();
    }
  }
}
