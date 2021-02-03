import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Msg {
  String message;
  bool isme;
  Timestamp timesend;
  bool isShow;
  bool samePreves = false;
  //Person doctur;

  Msg({this.message, this.isme, this.timesend, this.isShow, this.samePreves});

  bool isSamePreveas() {
    return this.samePreves;
  }

  String getMessage() {
    return this.message;
  }

  bool isMe() {
    return this.isme;
  }

//new DateFormat.MMMd().format(this._timeLastMsg)
  String getTimeSendFormat() {
    DateTime time = this.timesend.toDate();
    if (DateTime.now().year == time.year &&
        DateTime.now().month == time.month &&
        DateTime.now().day == time.day) {
      return new DateFormat.Hms().format(time).toString();
    } else {
      return new DateFormat.yMMMd().format(time).toString();
    }
    // if (DateTime.now().day - 1 == time.day) {
    //   timeFormat = "امس";
    // }
    // if (DateTime.now().year == time.year &&
    //     DateTime.now().month == time.month) {
    //   timeFormat = new DateFormat.MMMd().format(time).toString();
    // } else {
    //   timeFormat = new DateFormat.yMMMd().format(time).toString();
    // }
    // return timeFormat;
  }

  // void setDocturToChat(Person doctur) {
  //   this.doctur = doctur;
  // }
}
