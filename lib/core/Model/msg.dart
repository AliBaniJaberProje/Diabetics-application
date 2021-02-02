import 'package:ali_muntaser_final_project/core/Model/Person.dart';
import 'package:intl/intl.dart';

class Msg {
  String message;
  bool isme;
  DateTime timesend;
  bool isShow;
  //Person doctur;

  Msg({this.message, this.isme, this.timesend, this.isShow});

  String getMessage() {
    return this.message;
  }

  bool isMe() {
    return this.isme;
  }

//new DateFormat.MMMd().format(this._timeLastMsg)
  String getTimeSendFormat() {
    String timeFormat = "";
    if (DateTime.now().year == this.timesend.year &&
        DateTime.now().month == this.timesend.month &&
        DateTime.now().day == this.timesend.day) {
      timeFormat = new DateFormat.MMMd().format(this.timesend).toString();
    }
    if (DateTime.now().day - 1 == this.timesend.day) {
      timeFormat = "امس";
    }
    if (DateTime.now().year == this.timesend.year &&
        DateTime.now().month == this.timesend.month) {
      timeFormat = new DateFormat.MMMd().format(this.timesend).toString();
    } else {
      timeFormat = new DateFormat.yMMMd().format(this.timesend).toString();
    }
    return timeFormat;
  }

  // void setDocturToChat(Person doctur) {
  //   this.doctur = doctur;
  // }
}
