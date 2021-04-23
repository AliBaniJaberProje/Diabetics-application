import 'package:ali_muntaser_final_project/core/Model/NotificationStruct.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'NotificationsItem.dart';

class NotificationsScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    var _notificationsProvider = context.read<NotificationsProvider>();
    return Container(
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          NotificationStruct notification =
              _notificationsProvider.getNotificationOf(i);
          return Dismissible(
            key: Key(notification.key),
            child: InkWell(
              child: NotificationWidget(
                isAccept: notification.isAccept,
                mykey: notification.key,
                title: notification.title,
                body: notification.body,
                timestamp: notification.timeSend,
                status: notification.status,
                imgurl: notification.imgSender,
                isRequest:notification.isRequest,
                newDoctorId: notification.idNewDoctor,
                newDoctorName: notification.nameDoctorRequest,
              ),
              onTap: () => _notificationsProvider.updateStatusToSeen(
                  context.read<Auth>().userId, notification.key),
            ),

            onDismissed: (DismissDirection direction) {
              _notificationsProvider.deleteNotification(
                  context.read<Auth>().userId , notification.key);
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.purple,
                content: Container(
                  child: Text(
                    "تم حذف اشعار من ",
                    textAlign: TextAlign.end,
                  ),
                ),
              ));
            },
          );
        },
        itemCount: _notificationsProvider.getNumberNotification(),
      ),

    );

  }
}
