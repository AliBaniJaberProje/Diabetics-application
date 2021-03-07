

class EventStruct{

  String id;
  bool isAvailable;
  DateTime startEventTime;
  DateTime endEventTime;

  EventStruct({this.id,this.isAvailable,this.startEventTime,this.endEventTime});

  String getDateStarToEnd(){
    return this.startEventTime.hour.toString().padLeft(2, "0")+":"+this.startEventTime.minute.toString().padLeft(2, "0")+"\t-\t"+this.endEventTime.hour.toString().padLeft(2, "0")+":"+this.endEventTime.minute.toString().padLeft(2, "0");
  }

  String getDateYMD(){
    return this.endEventTime.year.toString()+"-"+this.endEventTime.month.toString()+"-"+this.endEventTime.day.toString();
  }

  String getDateTimeString(){
    switch(this.endEventTime.weekday){
      case 1: return "الأثنين";
      case 2: return "الثلاثاء";
      case 3: return "الأربعاء";
      case 4: return "الخميس";
      case 5 : return "الجمعة";
      case 6 : return "السبت";
      case 7 : return "الأحد";

    }
  }

}
