import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/Widgets/normal_icon.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/chatProvider.dart';
import 'package:flutter/material.dart';
import 'icon_with_number.dart';
import 'package:provider/provider.dart';
 AppBar AppBarHomePage (BuildContext context){

      return  AppBar(
        backgroundColor: Colors.purple.shade500,


        bottom: TabBar(
          tabs: [
            Tab(
              child: NormalIcon(icon: Icons.home,sizeIcon: 30,),
            ),
            Tab(
              //child: NormalIcon(icon: Icons.home,sizeIcon: 30,)
              child: IconWithNumber(icon:Icons.notifications,number :context.watch<NotificationsProvider>().notificationNumber,),
            ),
            Tab(
              //child: NormalIcon(icon: Icons.home,sizeIcon: 30,),
              child: IconWithNumber(icon: Icons.chat,number:context.watch<ChatProvider>().numberMessagesNotRead,),
            ),
            // Tab(
            //   child: NormalIcon(icon: Icons.person,sizeIcon: 30,),
            // ),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("أهلا بك يا محمد  "),
          ],
        ),

      );


  }

