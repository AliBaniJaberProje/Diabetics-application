import 'package:ali_muntaser_final_project/core/Model/NotificationStruct.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
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
                mykey: notification.key,
                title: notification.title,
                body: notification.body,
                timestamp: notification.timeSend,
                status: notification.status,
                imgurl: notification.imgSender,
              ),
              onTap: () => _notificationsProvider.updateStatusToSeen(
                  "123456789", notification.key),
            ),
            onDismissed: (DismissDirection direction) {
              _notificationsProvider.deleteNotification(
                  "123456789", notification.key);
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
