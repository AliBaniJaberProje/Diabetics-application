


import 'package:ali_muntaser_final_project/UI/Screens/ProfilePersonly/ProfilePersonly.dart';
import 'package:flutter/material.dart';

class MainDrawerController {
  BuildContext context;
  MainDrawerController(this.context);
  goToMyPersonScreen() {
    Navigator.pushReplacementNamed(context, MyPersonScreen.routeName);
  }

  
}