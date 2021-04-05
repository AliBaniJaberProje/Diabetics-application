import 'package:ali_muntaser_final_project/core/Model/DoseItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MyDoseProvider with ChangeNotifier {
  int indexInList=1;
  DateTime dateDose = DateTime.now();
  bool intToBool(int a) => a == 0 ? true : false;
  void decremant_dateDose() {
    dateDose = dateDose.subtract(new Duration(days: 1));
    //filter_listDose();
  }
  void clearDose(){
    this.listDose.clear();
    indexInList=1;
  }

  void incremant_dataDose() {
    dateDose = dateDose.add(new Duration(days: 1));
   // filter_listDose();
  }
  Color getColorDose(String time){
    switch (time){
      case "قبل الافطار" : return Colors.green;
      case "بعد العشاء" : return Colors.blue;
      case "بعد الافطار": return Colors.yellow;
      case "بعد الغداء":return Colors.red;
    }
    return Colors.deepOrange;
  }


  void process(dynamic data, String id){

    if(data['flag']=="0"){
      addDoseToListProvider(id: indexInList.toString() ,color: Colors.green, doseTitle:(" IU ${data['amountOfinj']}"+data['typeOfinj']).padLeft(20, " ") ,timeDose: data['dateOfMed']);
      indexInList++;
    }else if(data['flag']=="1")
    {
      addDoseToListProvider(id: indexInList.toString() ,color: Colors.blue, doseTitle:("${data['typeOfBill']} "+data['typeOfinj']).padLeft(20, " ")  ,timeDose: data['dateOfMed']);
      indexInList++;
    }else if(data['flag']=="2"){
      addDoseToListProvider(id: indexInList.toString() ,color: Colors.yellow, doseTitle:("${data['amountOfBill']} "+data['typeOfBill']).padLeft(20, " ") ,timeDose: data['dateOfMed']);
      indexInList++;
      addDoseToListProvider(id: indexInList.toString() ,color: Colors.deepOrange, doseTitle:(" IU ${data['amountOfinj']}  ${data['typeOfinj']} ").padLeft(20, " ")  ,timeDose: data['dateOfMed']);
      indexInList++;
    }
    print(data.toString());


  }


  List<DoseItem> listDose = [];

  String idUser;

  Future<void> fetchDoses()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();


    String url = "https://jaber-server.herokuapp.com/dose/${this.idUser}";
   http.Response response=await http.get(url,headers: {"x-auth-token":prefs.getString('jwt')});
   if(response.statusCode==200){
     var result=jsonDecode(response.body);
     http.Response response2=await http.get("https://jaber-server.herokuapp.com/steps/timestamp");
     var date=jsonDecode(response2.body);
     this.dateDose=DateTime.fromMillisecondsSinceEpoch(date['now']);

     for(int index=0;index<result['inject'].length;index++){
       process(result['inject'][index], (index+1).toString());
     }
     print(result['inject']);


   }

  }

  void addDoseToListProvider({String id , Color color , String doseTitle,String timeDose }) {
    listDose.add(new DoseItem(
      id: id,
      color: color,
      time_dose: timeDose,
      dosetitle: doseTitle,
    ));
    notifyListeners();
  }

  // void filter_listDose() {
  //   for (int i = 0; i < listDose.length; i++) {
  //     if (listDose[i].dateDose.year == this.dateDose.year &&
  //         listDose[i].dateDose.month == this.dateDose.month &&
  //         listDose[i].dateDose.day == this.dateDose.day) {
  //       listDose[i].take = true;
  //     } else {
  //       listDose[i].take = false;
  //     }
  //   }
  //   notifyListeners();
  // }
  // (dose.dateDose.year==this.dateDose.year&&
  // dose.dateDose.month==this.dateDose.month&&
  // dose.dateDose.day==this.dateDose.day)

}
