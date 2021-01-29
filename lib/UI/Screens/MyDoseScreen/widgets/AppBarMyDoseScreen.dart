
import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';

AppBar AppBarMyDoseScreen(BuildContext context){
    return  AppBar(
        backgroundColor: Colors.purple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
            ),
            Container(
              child: Text(
                "جدول الجرعات",
              ),
              padding: EdgeInsets.all(10),
            ),
          ],
        ),

    );
  }

