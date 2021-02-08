import 'package:ali_muntaser_final_project/core/Model/NotificationStruct.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// class NotificationsItem extends StatelessWidget {
//   final int id;
//   final String title;
//   final String auther;
//   final DateTime dateTime;
//   final STATUSR_NR state;
//
//   const NotificationsItem(
//       {this.id, this.title, this.auther, this.dateTime, this.state});
//
//   @override
//   Widget build(BuildContext ctx) {
//     return Container(
//       width: double.infinity,
//       height: 80,
//       color: state == STATUSR_NR.NOT_READ
//           ? Colors.grey.withOpacity(.6)
//           : Colors.white,
//       alignment: Alignment.center,
//       child: Dismissible(
//         child: InkWell(
//           child: ListTile(
//             title: Column(
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("${title}"),
//                 Text(
//                     "${dateTime.year}-${dateTime.month}-${dateTime.day}-${dateTime.hour}-${dateTime.minute}-${dateTime.second}"),
//               ],
//             ),
//             trailing: Container(
//               child: CircleAvatar(
//                 radius: 30,
//                 backgroundColor: Colors.purple.withOpacity(.5),
//                 child: Text(
//                   "${auther}",
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.black54,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//           onTap: () {
//             ctx.read<NotificationsProvider>().setNotificationReadedDone(id);
//           },
//         ),
//         key: Key("${id}"),
//         onDismissed: (DismissDirection direction) {
//           ctx.read<NotificationsProvider>().deleteNotifcation(id);
//           Scaffold.of(ctx).showSnackBar(SnackBar(
//             backgroundColor: Colors.purple,
//             content: Container(
//               child: Text(
//                 "تم حذف اشعار من ${auther}",
//                 textAlign: TextAlign.end,
//               ),
//             ),
//           ));
//         },
//       ),
//     );
//   }
// }
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
bool flag=true;


class NotificationWidgetAli extends StatelessWidget {

  String mykey;
  String title;
  Timestamp timestamp;
  String imgurl;
  String body;
  String status;
  int numbernotification;
  DateTime convertTimeStampToDateTime(Timestamp time) => time.toDate();

  String getTimeSendFormat(Timestamp time) {
    DateTime t=time.toDate();
    if (DateTime.now().year == t.year &&
        DateTime.now().month == t.month &&
        DateTime.now().day == t.day) {
      return  new DateFormat.Hms().format(t).toString();
    } else {
      return  new DateFormat.yMMMd().format(t).toString();
    }
  }
  NotificationWidgetAli({
    this.mykey,
    this.title,
    this.imgurl,
    this.timestamp,
    this.body,
    this.status,

});


  Widget build(BuildContext context) {
    Color unseenColor=HexColor("#db75c5");
    Color seenColor=HexColor("#f77fee");


    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

      Container(
      height: 90,
      decoration: new BoxDecoration(

          color:this.status=="seen"? seenColor:unseenColor,

      ),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

           Expanded(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                   Text(
                    this.title,
                    style: new TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                   SizedBox(
                    height: 8.0,
                  ),
                   Text(
                    "55",
                    style: new TextStyle(fontSize: 12.0, color: Colors.white70),
                  ),
                   SizedBox(
                    height: 10.0,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                       Column(
                        children: <Widget>[
                           Text(getTimeSendFormat(timestamp).toString(),
                              style: new TextStyle(
                                  fontSize: 8.0, color: Colors.white)),
                           Text('',
                              style: new TextStyle(
                                  fontSize: 10.0, color: Colors.white)),
                        ],
                      ),
                      //  Column(
                      //   children: <Widget>[
                      //      Text('2342',
                      //         style: new TextStyle(
                      //             fontSize: 12.0, color: Colors.white)),
                      //      Text('Like',
                      //         style:  TextStyle(
                      //             fontSize: 10.0, color: Colors.white)),
                      //   ],
                      // ),
                      //  Column(
                      //   children: <Widget>[
                      //      Text('2342',
                      //         style: new TextStyle(
                      //             fontSize: 12.0, color: Colors.white)),
                      //      Text('Followed',
                      //         style:  TextStyle(
                      //             fontSize: 10.0, color: Colors.white)),
                      //   ],
                      // )
                    ],
                  )
                ],
              )),

          new Padding(
            padding: new EdgeInsets.only(left: 10.0, right: 10.0),
            child: CircularProfileAvatar(
              this.imgurl,
              radius: 35.0,
              placeHolder: (context, url) => Container(
                width: 100,
                height: 100,
                child:CircularProgressIndicator(strokeWidth: 10,) ,

              ),
            ),
          ),

          // new Padding(
          //     padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          //     child: new Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         new Text(
          //           '12°',
          //           style: new TextStyle(fontSize: 30.0, color: Colors.white70),
          //         ),
          //         new Text(
          //           'Ranking',
          //           style: new TextStyle(fontSize: 14.0, color: Colors.white70),
          //         ),
          //       ],
          //     ))
        ],
      ),
    ),
    Container(
      width: double.infinity,
      color: Colors.black,
      height: 1,
    )
      ]);

  }
}
