
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/firebase/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/Providers/ProfileProvider.dart';
import 'NotificationsItem.dart';


class NotificationsScreen extends StatefulWidget {
  @override
  _Notififcationstate createState() => _Notififcationstate();

}
class _Notififcationstate extends State<NotificationsScreen> {
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
  context.read<NotificationsProvider>().getNotificatioFirebaseStre("123456789");
  }

  @override

  Widget build(BuildContext context) {
    // var NotificationsList =
    //     context.watch<NotificationsProvider>().NotificationsList;
    NotificationsFirebase _notificationsFirebase = new NotificationsFirebase();


    //


    return Container(
      // color: Colors.purple.withOpacity(.3),
      child: StreamBuilder(
          stream: _notificationsFirebase.getNotificatioFirebaseStre("123456789"),
          builder: (context, snap) {

            if(snap.connectionState==ConnectionState.waiting){
                    return Text(";fds");
            }else {
              if (snap.hasData &&
                  !snap.hasError &&
                  snap.data.snapshot.value != null) {
                Map data = snap.data.snapshot.value;
                List<dynamic> item = [];
               // print(data);
                data["notification"].forEach((index, data) {
                  item.add({"key": index, ...data});
                });
                //print();

               // context.read<NotificationsProvider>().getNotificationFromFirebase();
                item.sort((b, a) {
                  return int.parse(a['timestamp'].toString()).compareTo(
                    int.parse(
                      b['timestamp'].toString(),
                    ),
                  );
                });

                //"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Pierre-Person.jpg/800px-Pierre-Person.jpg"



                return ListView.builder(
                  itemBuilder: (ctx, i) => NotificationWidgetAli(
                    mykey: "i78",
                    title:item[i]["title"],
                    body: item[i]["body"],
                    timestamp: Timestamp.fromMicrosecondsSinceEpoch(item[i]["timestamp"]),
                    status: item[i]["status"],
                    imgurl: item[i]["imgsender"],

                  ),
                  itemCount:item.length,
                );
              }
              return null;
            }
          }),
    );
  }
}
