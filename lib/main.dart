import 'package:ali_muntaser_final_project/UI/Screens/login/loginScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/LogInProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/Screens/HomeScreen/HomeScreen.dart';
import 'UI/Screens/MyDoseScreen/MyDoseScreen.dart';
import 'UI/Screens/ProfilePersonly/ProfilePersonly.dart';
import 'UI/Screens/chat/MsgChat/msgChatScreen.dart';
import 'UI/Screens/daily_reading_screen/dailyReadingScreen.dart';
import 'core/Providers/MsgProvider.dart';
import 'core/Providers/MyDoseProvider.dart';
import 'core/Providers/NotificationProvider.dart';
import 'core/Providers/PersonProvider.dart';
import 'core/Providers/ProfileProvider.dart';
import 'core/Providers/messageProvider.dart';
import 'core/Providers/test.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(InitProviderWidget());
}

class InitProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Test()),
        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: DailyReadingProvider()),
        ChangeNotifierProvider.value(value: NotificationsProvider()),
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider.value(value: MyDoseProvider()),
        ChangeNotifierProvider.value(value: PersonChatProvider()),
        ChangeNotifierProvider.value(value: MessageProvider()),
        ChangeNotifierProvider.value(value: MsgProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        DailyReadingScreen.routeName: (context) => DailyReadingScreen(),
        MyPersonScreen.routeName: (context) => MyPersonScreen(),
        MyDoseScreen.routeName: (context) => MyDoseScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
      },
    );
  }
}
