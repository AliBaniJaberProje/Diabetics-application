import 'package:ali_muntaser_final_project/core/Model/DoseItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDoseProvider with ChangeNotifier {
  DateTime dateDose = DateTime.parse("1969-07-20");
  bool intToBool(int a) => a == 0 ? true : false;
  void decremant_dateDose() {
    dateDose = dateDose.subtract(new Duration(days: 1));
    filter_listDose();
  }

  void incremant_dataDose() {
    dateDose = dateDose.add(new Duration(days: 1));
    filter_listDose();
  }

  List<DoseItem> listDose = [
    new DoseItem(
      id: "2",
      take: false,
      color: Colors.red,
      time_dose: "قبل الافطار",
      dosetitle: "جرعة 1 ",
      dateDose: DateTime.parse("1969-07-20"),
    ),
    new DoseItem(
      id: "2",
      take: false,
      color: Colors.yellowAccent,
      time_dose: "قبل العشاء",
      dosetitle: "جرعة 2 ",
      dateDose: DateTime.parse("1969-07-19"),
    ),
    new DoseItem(
      id: "2",
      take: false,
      color: Colors.black,
      time_dose: "قبل الافطار",
      dosetitle: "جرعة 3 ",
      dateDose: DateTime.parse("1969-07-20"),
    ),
    new DoseItem(
      id: "2",
      take: false,
      color: Colors.blue,
      time_dose: "قبل الغداء",
      dosetitle: "جرعة 3 ",
      dateDose: DateTime.parse("1969-07-21"),
    ),
  ];

  void addDoseToListProvider() {
    listDose.add(new DoseItem(
      id: "2",
      take: false,
      color: Colors.red,
      time_dose: "قبل الغداء",
      dateDose: DateTime.parse("1969-07-20"),
      dosetitle: "جرعة9 ",
    ));
    notifyListeners();
  }

  void filter_listDose() {
    for (int i = 0; i < listDose.length; i++) {
      if (listDose[i].dateDose.year == this.dateDose.year &&
          listDose[i].dateDose.month == this.dateDose.month &&
          listDose[i].dateDose.day == this.dateDose.day) {
        listDose[i].take = true;
      } else {
        listDose[i].take = false;
      }
    }
    notifyListeners();
  }
  // (dose.dateDose.year==this.dateDose.year&&
  // dose.dateDose.month==this.dateDose.month&&
  // dose.dateDose.day==this.dateDose.day)

}
