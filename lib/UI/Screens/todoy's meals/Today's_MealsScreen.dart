import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import "package:ali_muntaser_final_project/UI/Screens/todoy's%20meals/Widgets/FoodItemTemplate.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'BreakfastScreen.dart';
import 'DinnerScreen.dart';
import 'LunchScreen.dart';

class TabTemplate extends StatelessWidget {
  final String tabTitle;

  const TabTemplate({this.tabTitle});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        tabTitle,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TodayMeals extends StatefulWidget {
  static String routeName = "/TodayMeals";
  @override
  _TodayMealsState createState() => _TodayMealsState();
}

class _TodayMealsState extends State<TodayMeals> {
  DateTime _time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              " ${_time.year}${"-"}${_time.month}${"-"}${_time.day}${"    "}وجبات اليوم "),
          centerTitle: true,
          backgroundColor: Colors.purple.shade500,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicator: MaterialIndicator(
              color: Colors.white,
              height: 8,
              topLeftRadius: 8,
              topRightRadius: 8,
              tabPosition: TabPosition.bottom,
            ),
            tabs: [
              TabTemplate(
                tabTitle: "الافطار",
              ),
              TabTemplate(
                tabTitle: "الغداء",
              ),
              TabTemplate(
                tabTitle: "العشاء",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BreakfastScreen(),
            LunchScreen(),
            DinnerScreen(),
          ],
        ),
      ),
    );

    ///-------------------
  }
}
