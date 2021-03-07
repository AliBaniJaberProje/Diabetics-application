import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class EventProvider with ChangeNotifier {
  List<dynamic> daysNamedAndDateTime = [];

  // ignore: missing_return
  int _mapNameDayToNumberOfAvailableDays(int dayIndexInDateTime) {
    switch (dayIndexInDateTime) {
      case 0:
        {
          print("error in mapNameDayToNumberOfAvailableDays");
          break;
        }

      case 1:
        return 4;
      case 2:
        return 3;
      case 3:
        return 2;
      case 4:
        return 1;
      case 5:
        return 6;
      case 6:
        return 6;
      case 7:
        return 5;
    }
  }

  // ignore: missing_return
  List<String> _getWeekDay(int numberOfDays) {
    switch (numberOfDays) {
      case 1:
        return ["الخميس"];
      case 2:
        return ["الخميس", "الاربعاء"];
      case 3:
        return ["الخميس", "الأربعاء", "الثلاثاء"];
      case 4:
        return ["الخميس", "الأربعاء", "الثلاثاء", "الأثنين"];
      case 5:
        return ["الخميس", "الأربعاء", "الثلاثاء", "الأثنين", "الأحد"];
      case 6:
        return ["الخميس", "الأربعاء", "الثلاثاء", "الأثنين", "الأحد", "السبت"];
    }
  }

  void getAllWeekDay() {
    DateTime dateTime = DateTime.now();
    int numberOfDay = _mapNameDayToNumberOfAvailableDays(dateTime.weekday);
    List<String> days = _getWeekDay(numberOfDay);
    days = days.reversed.toList();
    for (int i = 0; i < days.length; i++) {
      var dateAfterAdd = dateTime.add(Duration(days: i));
      daysNamedAndDateTime.add({
        "date": days[i],
        "DateTime":dateAfterAdd.year.toString() + "-"+
            dateAfterAdd.month.toString() + "-" + dateAfterAdd.day.toString(),
        "id":dateAfterAdd.toString()
      });
    }
    print(daysNamedAndDateTime.toString());
  }

  void clearDaysNamedAndDateTime(){
    this.daysNamedAndDateTime.clear();
  }

}
