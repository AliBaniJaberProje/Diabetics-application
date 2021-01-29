


import 'package:flutter/material.dart';

class DoseItem {
  final String dosetitle;
  final String id;
  final String time_dose;
  final DateTime dateDose;
  final Color color;
  bool take;

  DoseItem(
      {this.dosetitle,
      this.id,
      this.time_dose,
      this.dateDose,
      this.color,
      this.take = false});

  void setTake() {
    this.take = true;
  }

  factory DoseItem.fromJson(Map<String, dynamic> json) {
    return DoseItem(
        id: json['id'],
        dosetitle: json['dosetitle'],
        time_dose: json['time_json'],
        take: json['take'] as bool,
        dateDose: DateTime.parse(json['dateDose']),
        color: Colors.purple);
  }
}
