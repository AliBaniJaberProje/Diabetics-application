class DoctorChatStruct {
  String _id;
  String _name;
  String _imgUrl;
  String _online;
  int _numberMessages;

  DoctorChatStruct(
      {String id,
      String name,
      String imgUrl,
      String online,
      int numberMessages}) {
    this._id = id;
    this._name = name;
    this._imgUrl = imgUrl;
    this._online=online;
    this._numberMessages = numberMessages;
  }

  DoctorChatStruct.fromJson(dynamic json) {
    _id = json["userid"];
    _name = json["username"];
    _imgUrl = json["imgurl"];
    _online = json["status"];
    _numberMessages = json["numberMessage"];
  }



  // ignore: unnecessary_getters_setters
  String get online => _online;

  int get numberMessages => _numberMessages;

  String get imgUrl => _imgUrl;

  String get name => _name;

  String get id => _id;

  // ignore: unnecessary_getters_setters
  set online(String value) {
    _online = value;
  }

}
