import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';

AppBar MyAppBar(BuildContext context) {
    return  AppBar(
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
              "سجل القرأت اليومية",
            ),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
      backgroundColor: Colors.purple,
    );
  }

