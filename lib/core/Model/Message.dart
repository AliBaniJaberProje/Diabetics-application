import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Message {
  String message;
  bool isme;
  Timestamp timesend;
  bool isShow;
  String typemessage;



  Message({this.message, this.isme, this.timesend, this.isShow,this.typemessage});

  String getMessage() {
    return this.message;
  }
  bool isImageMessage(){
    return this.typemessage=='image';
  }
  String getTypeMessage(){
    return this.typemessage;
  }

  bool isMe() {
    return this.isme;
  }

  String getTimeSendFormat() {
    DateTime time = this.timesend.toDate();
    if (DateTime.now().year == time.year &&
        DateTime.now().month == time.month &&
        DateTime.now().day == time.day) {
      return new DateFormat.Hms().format(time).toString();
    } else {
      return new DateFormat.yMMMd().format(time).toString();
    }
  }
}
