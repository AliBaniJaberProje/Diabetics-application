import 'package:ali_muntaser_final_project/UI/Screens/chat/PersonChat/PersonChatScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/notifications/NotificationScreen.dart';
import 'package:ali_muntaser_final_project/UI/Widgets/MainDrawer/maindrawer.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Widgets/AppBar.dart';
import 'Widgets/body_hone_page.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<NotificationsProvider>().startStreamNotification("123456789");

  }

  int currentPage;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        endDrawer:MainDrawer(),
        appBar: AppBarHomePage(context),
        body: TabBarView(
          children: [
            BodyHonePage(),
            //Scaffold(),
            NotificationsScreen(),
            PersonChatScreen(),
            //  PersonalScreen(),
          ],
        ),
      ),
    );
  }
}
