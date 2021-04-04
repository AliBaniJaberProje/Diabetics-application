


import 'package:flutter/material.dart';

class DoseItem {
  final String dosetitle;
  final String id;
  final String time_dose;

  final Color color;


  DoseItem(
      {this.dosetitle,
      this.id,
      this.time_dose,

      this.color,
     });

  void setTake() {

  }

  factory DoseItem.fromJson(Map<String, dynamic> json) {
    return DoseItem(
        id: json['id'],
        dosetitle: json['dosetitle'],
        time_dose: json['time_json'],


        color: Colors.purple);
  }
}
