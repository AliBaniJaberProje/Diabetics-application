import 'package:ali_muntaser_final_project/core/Model/Person.dart';
import 'package:intl/intl.dart';

class Msg {
  String _message;
  bool _isMe;
  DateTime _timesend;
  bool _isShow;
  Person _doctur;

  Msg(this._message, this._isMe, this._timesend, this._isShow, this._doctur);

  String getMessage() {
    return this._message;
  }

  bool isMe() {
    return this._isMe;
  }

//new DateFormat.MMMd().format(this._timeLastMsg)
  String getTimeSendFormat() {
    String timeFormat = "";
    if (DateTime.now().year == this._timesend.year &&
        DateTime.now().month == this._timesend.month &&
        DateTime.now().day == this._timesend.day) {
      timeFormat = new DateFormat.MMMd().format(this._timesend).toString();
    }
    if (DateTime.now().day - 1 == this._timesend.day) {
      timeFormat = "امس";
    }
    if (DateTime.now().year == this._timesend.year &&
        DateTime.now().month == this._timesend.month) {
      timeFormat = new DateFormat.MMMd().format(this._timesend).toString();
    } else {
      timeFormat = new DateFormat.yMMMd().format(this._timesend).toString();
    }
    return timeFormat;
  }

  void setDocturToChat(Person doctur) {
    this._doctur = doctur;
  }
}
