import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestProvider with ChangeNotifier {
  // String url =
  //     "https://ali-muntaser-project-default-rtdb.firebaseio.com/chat.json";

  Stream<dynamic> feachdata() async* {
    try {
      var _firebaseRef = FirebaseDatabase()
          .reference()
          .child('chat')
          .child("123")
          .child("7410")
          .child("messages")
          .child("chat");

      yield* _firebaseRef.onValue;

    // _ref.once().then((DataSnapshot snap) {
    //   // var keys = snap.value.keys;
    //   // var data = snap.value;
   
    //   // for (var key in keys) {
        
    //   //   print(data[key]);
        
    //   // }

    // });
      

    //  final res = http.get(url).asStream();
      //yield res;
      
      // res.listen((event) {
        
      //   print(event.body);
      // });
      // // final data = json.decode(res) as Map<String,dynamic> ;
      // res.asyncMap((event) {
        
      //   print(event.body);
      // });

    } catch (e) {
      print("error");
    }
  }
}
