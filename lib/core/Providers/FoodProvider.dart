

import 'package:ali_muntaser_final_project/core/Model/FoodItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodProvider with ChangeNotifier{

  List<FoodItem> _foodList =[];

  int getLength() =>this._foodList.length;

  FoodItem getFoodItem(int index)=>this._foodList[index];

  List<FoodItem> filterBy(FOOD_TYPE foodType){
   return this._foodList.where((element) => element.food_type==foodType).toList();
  }

  FoodProvider(){

    _foodList.add(new FoodItem(
      id: "1",
      content: "100 غرام سكر",
      food_type: FOOD_TYPE.LUNCH,
      selected: false,
      color: Colors.purpleAccent,
    ),);


    _foodList.add(new FoodItem(
      id: "2",
      content: "نص حبة بطاطا",
      food_type: FOOD_TYPE.DINNER,
      selected: true,
      color: Colors.tealAccent
    ),);


    _foodList.add(new FoodItem(
        id: "3",
        content: "خبز توست",
        food_type: FOOD_TYPE.BREAKFAST,
        selected: true,
        color: Colors.blue
    ),);


    _foodList.add(new FoodItem(
        id: "4",
        content: "100 غرام لحم خروف",
        food_type: FOOD_TYPE.LUNCH,
        selected: true,
        color: Colors.amber
    ),);

    _foodList.add(new FoodItem(
        id: "5",
        content: "100 غرام لحم خروف",
        food_type: FOOD_TYPE.BREAKFAST,
        selected: true,
        color: Colors.brown
    ),);

  }

  void setSelectedWhereId(int i) {
    this._foodList[i].setSelected();
    notifyListeners();
  }



}