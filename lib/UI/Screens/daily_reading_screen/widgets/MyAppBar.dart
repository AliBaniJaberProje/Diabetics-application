
import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
AppBar MyAppBar(BuildContext context) {
      return  AppBar(
        centerTitle: true,
        leading:
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.read<DailyReadingProvider>().clearListDailyReading();
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),

        title:Container(
              child: Text("سجل القرأت اليومية",),
              padding: EdgeInsets.all(10),

        ),
        backgroundColor: Colors.purple,
      );
  }

