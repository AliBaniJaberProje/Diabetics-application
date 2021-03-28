import 'package:ali_muntaser_final_project/UI/Screens/chat/PersonChat/PersonChatScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/notifications/NotificationScreen.dart';
import 'package:ali_muntaser_final_project/UI/Widgets/MainDrawer/maindrawer.dart';
import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/MessagesProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';

import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/PatientServes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'Widgets/AppBar.dart';
import 'Widgets/body_hone_page.dart';


class HomeScreen extends StatefulWidget {
  static final String routeName = "/HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterLocalNotificationsPlugin fltrNotification;

  String task="545";
  int val=0;




  @override
  void initState() {
    super.initState();

    var androidInitilize = new AndroidInitializationSettings('ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);

    getIdAndIdCurrentDoctor().then((value) {
      print(value);
      context.read<NotificationsProvider>().startStreamNotification(value['patientUser']["id"]);
      context.read<MessagesProvider>().getNumberOfMessagesFromDoctor(value['patientUser']["id"],value['patientUser']["currentDoctor"]);
      context.read<DailyReadingProvider>().idUser=value['patientUser']["id"];
      context.read<DailyReadingProvider>().imgUrlDoctor=value['imgURLDoctor'];

      print(value["currentDoctor"]);
    });




    final fbm =FirebaseMessaging();
    fbm.configure(onMessage: (msg){
      print(msg);
      return ;
    },
    onLaunch: (msg){
      print(msg);
      return ;
    },
    onResume: (msg){
      print(msg);
      return ;
    }
    );
    fbm.getToken().then((value) {
      print(value);
    });
    fbm.subscribeToTopic("notification_msg");
  }


  Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(android: androidDetails, iOS: iSODetails);

    // await fltrNotification.show(
    //     0, "Task", "You created a Task", generalNotificationDetails, payload: "Task");
    var scheduledTime=DateTime.now();


    fltrNotification.schedule(
        1, "علي بني جابر", task, scheduledTime, generalNotificationDetails);
  }


  @override
  Widget build(BuildContext context) {
    var  indexpage = ModalRoute.of(context).settings.arguments as Map<String,int>;
    int curantpage=0;
    if(indexpage !=null && indexpage["index"]==2)
       curantpage=2;

    return DefaultTabController(
      initialIndex: curantpage,
      length: 3,
      child: Scaffold(
        endDrawer:MainDrawer(),
        appBar: AppBarHomePage(
          context
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.clear),
          //     onPressed: _showNotification,
          //   ),
          // ],
        ),
        body: TabBarView(
          children: [
            BodyHonePage(),
            NotificationsScreen(),
            PersonChatScreen(),
            //  PersonalScreen(),
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification Clicked $payload",style: TextStyle(color: Colors.deepOrange),),
      ),
    );
  }


}
