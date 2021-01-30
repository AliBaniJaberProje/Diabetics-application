import 'package:ali_muntaser_final_project/core/Model/Person.dart';
import 'package:flutter/foundation.dart';

class Message {
  String _id;
  String _title;
  Person _from;
  Person _to;
  DateTime _timeSend;
  DateTime _timeReceved;
  DateTime _timeshow;
  bool _seen;

  Message(this._id, this._title, this._from, this._to, this._timeSend,
      this._timeReceved, this._timeshow, this._seen);

  bool get seen => this._seen;

  set seen(bool value) {
    this._seen = value;
  }

  DateTime get timeshow => this._timeshow;

  set timeshow(DateTime value) {
    this._timeshow = value;
  }

  DateTime get timeReceved => this._timeReceved;

  set timeReceved(DateTime value) {
    this._timeReceved = value;
  }

  DateTime get timeSend => this._timeSend;

  set timeSend(DateTime value) {
    this._timeSend = value;
  }

  Person get to => this._to;

  set to(Person value) {
    this._to = value;
  }

  Person get from => this._from;

  set from(Person value) {
    this._from = value;
  }

  String get title => this._title;

  set title(String value) {
    this._title = value;
  }

  String get id => this._id;

  set id(String value) {
    this._id = value;
  }
}
