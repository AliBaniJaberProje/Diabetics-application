import 'package:ali_muntaser_final_project/UI/Screens/login/loginScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/LogInProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/Screens/HomeScreen/HomeScreen.dart';
import 'UI/Screens/MyDoseScreen/MyDoseScreen.dart';
import 'UI/Screens/ProfilePersonly/ProfilePersonly.dart';
import 'UI/Screens/StepCount/StepScreen.dart';
import 'UI/Screens/TestCard.dart';
import 'UI/Screens/chat/MsgChat/MessagesScreen.dart';
import 'UI/Screens/daily_reading_screen/dailyReadingScreen.dart';


import 'UI/Screens/doctor_appointments/Doctor_appointmentScreen.dart';
import 'UI/Screens/doctor_appointments/EventTimeScreen.dart';
import "UI/Screens/todoy's meals/FoodScreen.dart";
import 'core/Providers/EventDateTimeProvier.dart';
import 'core/Providers/EventProvider.dart';
import 'core/Providers/MessagesProvider.dart';
import 'core/Providers/FoodProvider.dart';
import 'core/Providers/MyDoseProvider.dart';
import 'core/Providers/NotificationProvider.dart';
import 'core/Providers/chatProvider.dart';
import 'core/Providers/doctorChatProvider.dart';
import 'core/Providers/ProfileProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import './core/Model/messageStruct.dart';
import './core/Providers/NumberOfStepProvider.dart';
import 'core/Servies_api/nodeServers/auth.dart';
import "./UI/Screens/todoy's meals/Today's_MealsScreen.dart";

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

        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: DailyReadingProvider()),
        ChangeNotifierProvider.value(value: NotificationsProvider()),
        ChangeNotifierProvider.value(value: ProfileProvider()),
        ChangeNotifierProvider.value(value: MyDoseProvider()),
        ChangeNotifierProvider.value(value: DoctorChatProvider()),
        ChangeNotifierProvider.value(value: MessagesProvider()),
        ChangeNotifierProvider.value(value: ChatProvider()),
        ChangeNotifierProvider.value(value: MessageStruct()),
        ChangeNotifierProvider.value(value: NumberOfStepProvider()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: FoodProvider()),
        ChangeNotifierProvider.value(value: EventProvider()),
        ChangeNotifierProvider.value(value: SlotDateTimeProvider()),


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
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
      ),
      routes: {

        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        DailyReadingScreen.routeName: (context) => DailyReadingScreen(),
        MyPersonScreen.routeName: (context) => MyPersonScreen(),
        MyDoseScreen.routeName: (context) => MyDoseScreen(),
        MessagesScreen.routeName: (context) => MessagesScreen(),
        NumberOfStep.routeName:(context)=>NumberOfStep(),
        TestCard.routName:(context)=>TestCard(),
        TodayMeals.routeName:(context)=>TodayMeals(),
        DoctorAppointmentsScreen.routeName:(context)=>DoctorAppointmentsScreen(),
        FoodScreen.routerName:(context)=>FoodScreen(),
        EventTimeScreen.routeName:(context)=>EventTimeScreen(),
      },
    );
  }
}
