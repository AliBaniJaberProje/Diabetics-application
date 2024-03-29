import 'package:ali_muntaser_final_project/UI/Screens/history/suqar_reding_history.dart';
import 'package:ali_muntaser_final_project/UI/Screens/login/loginScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/LogInProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/Screens/FoodScreen/food_screen.dart';
import 'UI/Screens/HomeScreen/HomeScreen.dart';
import 'UI/Screens/MyDoseScreen/MyDoseScreen.dart';
import 'UI/Screens/ProfilePersonly/ProfilePersonly.dart';
import 'UI/Screens/StepCount/StepScreen.dart';
import 'UI/Screens/TestCard.dart';
import 'UI/Screens/chat/MsgChat/MessagesScreen.dart';
import 'UI/Screens/daily_reading_screen/dailyReadingScreen.dart';
import 'UI/Screens/doctor_appointments/Doctor_appointmentScreen.dart';
import 'UI/Screens/doctor_appointments/EventTimeScreen.dart';
import 'UI/Screens/history/dose_history_dose.dart';
import 'UI/Screens/history/events_history.dart';
import 'UI/Screens/history/food_history.dart';
import 'UI/Screens/history/grp_history.dart';
import 'UI/Screens/history/number_steps_history.dart';
import 'UI/Screens/information/informationScreen.dart';
import 'UI/Screens/setting/verfiy.dart';
import 'UI/Screens/setting/rest_password_secren1.dart';
import 'UI/Screens/setting/update_forget_passward.dart';
import 'UI/Screens/setting/update_password.dart';
import "UI/Screens/todoy's meals/FoodScreen.dart";
import 'core/Providers/EventDateTimeProvier.dart';
import 'core/Providers/EventProvider.dart';
import 'core/Providers/MessagesProvider.dart';
import 'core/Providers/FoodProvider.dart';
import 'core/Providers/MyDoseProvider.dart';
import 'core/Providers/NotificationProvider.dart';
import 'core/Providers/doctorChatProvider.dart';
import 'core/Providers/ProfileProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import './core/Model/messageStruct.dart';
import './core/Providers/NumberOfStepProvider.dart';
import 'core/Providers/dose_history_provider.dart';
import './core/Providers/food-history-provider.dart';
import 'core/Providers/event_history.dart';
import 'core/Providers/food_details.dart';
import 'core/Providers/food_provider.dart';
import 'core/Providers/grp_provider.dart';
import 'core/Providers/histry_number_of_stepProvider.dart';
import 'core/Providers/suqar_reding_historyProvider.dart';
import 'core/Servies_api/nodeServers/auth.dart';
import "./UI/Screens/todoy's meals/Today's_MealsScreen.dart";
import './UI/Screens/grp_reading/grp_reading.dart';


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
        ChangeNotifierProvider.value(value: MessageStruct()),
        ChangeNotifierProvider.value(value: NumberOfStepProvider()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: FoodProvider()),
        ChangeNotifierProvider.value(value: EventProvider()),
        ChangeNotifierProvider.value(value: SlotDateTimeProvider()),
        ChangeNotifierProvider.value(value: FoodProvider2()),
        ChangeNotifierProvider.value(value: FoodDetailsProvider()),
        ChangeNotifierProvider.value(value: DoseHistoryProvider()),
        ChangeNotifierProvider.value(value: SuqarReadingHistoryProvider()),
        ChangeNotifierProvider.value(value: FoodHistoryProvider()),
        ChangeNotifierProvider.value(value: NumberOfStepHistory()),
        ChangeNotifierProvider.value(value: EventHistory()),
        ChangeNotifierProvider.value(value: GRP_history_Provider()),
        // GRP_history_Provider
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
        FoodScreen2.routeName:(context)=>FoodScreen2(),
        DoseHistoryDose.routeName:(context)=>DoseHistoryDose(),
        SuqarRedingHistory.routName:(context)=>SuqarRedingHistory(),
        FoodHistory.routName:(context)=>FoodHistory(),
        NumberStepsHistory.routeName:(context)=>NumberStepsHistory(),
        EventsHistory.routeName:(context)=>EventsHistory(),
        GrpHistory.routeName:(context)=>GrpHistory(),
        UpdatePassword.routeName:(context)=>UpdatePassword(),
        ResatPassword.routeName:(context)=>ResatPassword(),
        RestPasswordSecren1.routeName:(context)=>RestPasswordSecren1(),
        UpdateForgetPassward.routeName:(context)=>UpdateForgetPassward(),
        GrpReading.routeName:(context)=>GrpReading(),
        InformationScreen.routeName:(context)=>InformationScreen(),
        // RestPasswordSecren1
        // ResatPassword   InformationScreen
      },
    );
  }
}
