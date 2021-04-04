



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;



class FoodDetailItem{
  String nameFoodItem;
  String value;
  String unit;
  String otherDetails;
  FoodDetailItem({this.nameFoodItem, this.value, this.unit, this.otherDetails});

}


class FoodDetailsProvider with ChangeNotifier{

  List<FoodDetailItem>component=[];
  bool loading=false;
  String categoryName;



  void sendRequestToGetDetails(String fcdId)async{
    loading=true;
    component.clear();
    String url="https://jaber-server.herokuapp.com/food/";
    if(categoryName=="فواكه"){
      url+="fruits/";
    }
    else if(categoryName=="منتجات الألبان والبيض"){
      url+="eggs_and_milk/";

    }else if(categoryName=="الدهون والزيوت"){
      url+="oils_and_fats/";
    }else if(categoryName=="اللحوم و الأسماك"){
      url+="meat/";
    }else if(categoryName=="خضروات"){
      url+="vegetable/";
    }else if(categoryName=="المشروبات"){
      url += "drink/";
    }else if(categoryName=="البقوليات والمكسرات"){
      url+="legumes/";
    }else if(categoryName=="الورقيات"){
      url += "foliar/";
    }else if(categoryName=="النشويات"){
      url+="starche/";
    }
    else{
      loading=false;
      //notifyListeners();
      return;
    }
    http.Response response=await http.get(url+"${fcdId}");
    if(response.statusCode==200){
      var result=jsonDecode(response.body);
      var resultToProcess=result['FoodNutrients'] as Map<String,dynamic>;

      component.add(new FoodDetailItem(
          nameFoodItem:"الطاقة " ,
          value:resultToProcess['Energy']['value'] ,
          otherDetails:"لالالالال" ,
          unit: resultToProcess['Energy']['unit']
      ));

      component.add(new FoodDetailItem(
          nameFoodItem:"البروتين " ,
          value:resultToProcess['Protein']['value'] ,
          otherDetails:"لالالالال" ,
          unit: resultToProcess['Protein']['unit']
      ));



      component.add(new FoodDetailItem(
          nameFoodItem:"الدهون " ,
          value:resultToProcess['fat']['value'] ,
          otherDetails:"لالالالال" ,
          unit: resultToProcess['fat']['unit']
      ));

      component.add(new FoodDetailItem(
          nameFoodItem:"الكربوهيدرات " ,
          value:resultToProcess['Carbohydrate']['value'] ,
          otherDetails:"لالالالال" ,
          unit: resultToProcess['Carbohydrate']['unit']
      ));

      notifyListeners();
      loading=false;
      print(result['FoodNutrients']);
    }
    else{
      loading=false;
    }
  }

}