import 'package:ali_muntaser_final_project/core/Model/FoodItem.dart';
import 'package:ali_muntaser_final_project/core/Providers/FoodProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Widgets/FoodItemTemplate.dart';
import 'package:provider/provider.dart';

class BreakfastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _foodProvider = context.read<FoodProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: _foodProvider.filterBy(FOOD_TYPE.BREAKFAST).map(
          (foodItem) {
            return FoodItemTemplate(
              id: foodItem.id,
              color: foodItem.color,
              content: foodItem.content,
            );
          },
        ).toList(),
      ),
    );
  }
}
