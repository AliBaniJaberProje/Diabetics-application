
import 'package:flutter/material.dart';

enum FOOD_TYPE { BREAKFAST, LUNCH ,DINNER }

class FoodItem with ChangeNotifier {
  String id;
  String content;
  bool selected;
  String _idInDataSet;
  // ignore: non_constant_identifier_names
  FOOD_TYPE food_type;
  Color color;
  // ignore: non_constant_identifier_names
  FoodItem({this.id,this.content,this.selected=false,this.food_type,this.color});

  void setSelected(){
    this.selected=!this.selected;

    notifyListeners();

  }
  void setIdDataSet(String id){
    this._idInDataSet=id;
  }
  String getIdDataInDataSet(){
    return this._idInDataSet;
  }



}