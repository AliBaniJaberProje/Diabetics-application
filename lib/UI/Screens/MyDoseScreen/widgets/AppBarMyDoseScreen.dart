
import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/MyDoseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
AppBar AppBarMyDoseScreen(BuildContext context){
    return  AppBar(
        backgroundColor: Colors.purple,
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<MyDoseProvider>().clearDose();
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);

          },
        ),
        title: Text(
                "جدول الجرعات",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
      centerTitle: true,



    );
  }

