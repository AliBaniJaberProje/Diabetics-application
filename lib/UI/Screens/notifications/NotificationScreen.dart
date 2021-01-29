

import 'package:ali_muntaser_final_project/UI/Widgets/NotificationsItem.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var NotificationsList =
        context.watch<NotificationsProvider>().NotificationsList;
    return Container(
      color: Colors.purple.withOpacity(.3),
      child: ListView.builder(

        itemBuilder: (ctx, i) => NotificationsItem(
          id: NotificationsList[i].id,
          title: NotificationsList[i].title,
          dateTime: NotificationsList[i].dateTime,
          auther: NotificationsList[i].auther,
          state: NotificationsList[i].statusR_NR,
        ),
        itemCount: context.watch<NotificationsProvider>().NotificationsNumber,
      ),
    );
  }
}
