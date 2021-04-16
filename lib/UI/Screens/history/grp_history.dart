import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class GrpHistory extends StatefulWidget {
  static String routeName="/GrpHistory";
  GrpHistory({Key key}) : super(key: key);

  @override
  _GrpHistoryState createState() => _GrpHistoryState();
}

class _GrpHistoryState extends State<GrpHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        title: Text(
          " السكري التراكمي ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textDirection: ui.TextDirection.rtl,
        ),
        centerTitle: true,
      ),

    );
  }
}