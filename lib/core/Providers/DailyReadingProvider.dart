
import 'package:ali_muntaser_final_project/core/Model/DailyReadingItem.dart';
import 'package:flutter/widgets.dart';

class DailyReadingProvider with ChangeNotifier{
    
  DateTime timeforthisreading = null;

  List<DailyReadingItem> listDailyReading = [
    DailyReadingItem(
        id: "1",
        value: 89,
        take: true,
        dateTimeForThis: DateTime.now(),
        timeRegistration: DateTime.now()),
    DailyReadingItem(
        id: "2",
        value: 0,
        take: true,
        dateTimeForThis: DateTime.now(),
        timeRegistration: DateTime.now()),
    DailyReadingItem(
        id: "3",
        value: 0,
        take: true,
        dateTimeForThis: DateTime.now(),
        timeRegistration: DateTime.now()),
    DailyReadingItem(
        id: "4",
        value: 0,
        take: true,
        dateTimeForThis: DateTime.now(),
        timeRegistration: DateTime.now())
  ];

  void setTimeForThisReading(DateTime t) {
    this.timeforthisreading = t;
    notifyListeners();
  }

  void setValueAndTake(int id, double val) {

        
         this.listDailyReading[id].value = val;
         this.listDailyReading[id].take = false;
        

        print(val);

        notifyListeners();
  }

  void updateValueAndTake(int id, double val) {

      if (listDailyReading[id].id == id && !listDailyReading[id].take) {
        this.listDailyReading[id].value = val;
        print("listDailyReading[id].id"+id.toString()+"!listDailyReading[id].take"+val.toString());

      }

    notifyListeners();
  }

}