


import 'package:ali_muntaser_final_project/UI/Screens/daily_reading_screen/widgets/MyAppBar.dart';
import 'package:ali_muntaser_final_project/UI/Screens/daily_reading_screen/widgets/MyDailyReadingBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





class DailyReadingScreen extends StatelessWidget {
  static final String routeName = "/DailyReadingScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      appBar: MyAppBar(context),
      body: MyDailyReadingBody(),

    );
  }
}
