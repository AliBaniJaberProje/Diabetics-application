


import 'package:ali_muntaser_final_project/core/Model/NotificationStruct.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsItem extends StatelessWidget {
  final int id;
  final String title;
  final String auther;
  final DateTime dateTime;
  final STATUSR_NR state;

  const NotificationsItem(
      {this.id, this.title, this.auther, this.dateTime, this.state});

  @override
  Widget build(BuildContext ctx) {
    return Container(
      width: double.infinity,
      height: 80,
      color: state == STATUSR_NR.NOT_READ ? Colors.grey.withOpacity(.6) : Colors.white,
      alignment: Alignment.center,
      child: Dismissible(
        child: InkWell(
          child: ListTile(
            title: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${title}"),
                Text(
                    "${dateTime.year}-${dateTime.month}-${dateTime.day}-${dateTime.hour}-${dateTime.minute}-${dateTime.second}"),
              ],
            ),
            trailing: Container(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.purple.withOpacity(.5),
                child: Text(
                  "${auther}",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

          ),
          onTap: (){
            ctx.read<NotificationsProvider>().setNotificationReadedDone(id);
          },

        ),
        key: Key("${id}"),
        onDismissed: (DismissDirection direction){
          ctx.read<NotificationsProvider>().deleteNotifcation(id);
          Scaffold.of(ctx).showSnackBar(SnackBar(
            backgroundColor:  Colors.purple,
            content: Container(

                child: Text("تم حذف اشعار من ${auther}",textAlign: TextAlign.end,),),
          ));
        },

      ),
    );
  }
}
