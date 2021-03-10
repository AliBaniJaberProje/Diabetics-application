class DoctorChatStruct {
  String _id;
  String _name;
  String _imgUrl;
  bool _online;
  int _numberMessages;

  DoctorChatStruct(
      {String id,
      String name,
      String imgUrl,
      bool online,
      int numberMessages}) {
    this._id = id;
    this._name = name;
    this._imgUrl = imgUrl;
    this._online=online;
    this._numberMessages = numberMessages;
  }

  DoctorChatStruct.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["username"];
    _imgUrl = json["imgURL"];
    _online = json["isOnline"];
    _numberMessages = json["numberMessage"];
  }



  // ignore: unnecessary_getters_setters
  bool get online => _online;

  int get numberMessages => _numberMessages;

  String get imgUrl => _imgUrl;

  String get name => _name;

  String get id => _id;

  bool isOnline() {
   return this._online;
  }

}
