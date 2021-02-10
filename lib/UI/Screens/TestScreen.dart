// import 'package:ali_muntaser_final_project/core/Providers/MessagesProvider.dart';
// import 'package:ali_muntaser_final_project/core/Providers/TestProvider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class TestScreen extends StatefulWidget {
//   static String routName = "/TestScreen";
//   @override
//   _TestScreenState createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   int i=0;
//   @override
//   void initState() {
//     super.initState();
//
//     // context.read<TestProvider>().feachdata().then((value) {
//     //   print("7889451256");
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var _firebaseRef = FirebaseDatabase()
//         .reference()
//         .child('chat')
//         .child(context.read<MessagesProvider>().getIdSenderPatient())
//         .child(context.read<MessagesProvider>().getReceverId())
//         .child("messages")
//         .child("chat");
//
//     var _toaccess = FirebaseDatabase()
//         .reference()
//         .child('chat')
//         .child(context.read<MessagesProvider>().getIdSenderPatient())
//         .child(context.read<MessagesProvider>().getReceverId())
//         .child("messages")
//         .child("chat");
//
//     return Scaffold(
//       body: Center(
//         child: StreamBuilder(
//           stream: _firebaseRef.onValue,
//           builder: (context, snap) {
//             if (snap.hasData &&
//                 !snap.hasError &&
//                 snap.data.snapshot.value != null) {
//               Map data = snap.data.snapshot.value;
//               List item = [];
//
//               data.forEach((index, data) {
//                 item.add({"key": index, ...data});
//                 //chat=data["chat"];
//                  //print(data);
//               });
//
//               return ListView.builder(
//                 reverse: true,
//                 itemCount: item.length,
//                 itemBuilder: (context, index) {
//                    print(item);
//                    // item.sort((a, b) {
//                    //   return  int.parse(a['timestamp'].toString()).compareTo(int.parse(b['timestamp'].toString()));
//                    // });
//
//                    item.sort((b, a) {//--------------------------------
//                      return  int.parse(a['timestamp'].toString()).compareTo(int.parse(b['timestamp'].toString()));
//                    });
//
//
//                    //
//                    // BubbleMessage(
//                    //   msg: Msg(
//                    //     message: snap.data.docs[index]
//                    //     ["text"],
//                    //     isShow: true,
//                    //     isme: snap.data.docs[index]
//                    //     ["isPatient"],
//                    //     timesend: snap.data.docs[index]
//                    //     ["timeSend"],
//                    //   ),
//                    //
//                    //   //isPatient
//                    // )
//
//
//                    if (item[index]["key"] != "time") {
//                     return ListTile(
//                       title: Text(item[index]["message"].toString()),
//                       // trailing: Text(DateFormat("hh:mm:ss")
//                       //     .format(DateTime.fromMicrosecondsSinceEpoch(
//                       //         item[index]['timestamp'] * 1000))
//                       //     .toString()),
//                     );
//                   } else {
//                     return ListTile(
//                       title: Text("item[index][message]"),
//                       // trailing: Text(DateFormat("hh:mm:ss")
//                       //     .format(DateTime.fromMicrosecondsSinceEpoch(
//                       //         item[index]['timestamp'] * 1000))
//                       //     .toString()),
//                     );
//                   }
//                 },
//               );
//             } else
//               return Text("No data");
//           },
//
//         ),
//
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _toaccess.push().set(
//               {
//             "message":i++,
//             "timestamp":Timestamp.now().microsecondsSinceEpoch,
//              "isPatient":true
//
//           });
//         },
//         child: Icon(Icons.ac_unit),
//       ),
//     );
//   }
// }
