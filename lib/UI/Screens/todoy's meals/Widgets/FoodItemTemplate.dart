import 'package:ali_muntaser_final_project/core/Model/FoodItem.dart';
import 'package:ali_muntaser_final_project/core/Providers/FoodProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

class FoodItemTemplate extends StatefulWidget {
  final String idView;
  final FoodItem foodItem;
  FoodItemTemplate({this.idView, this.foodItem});

  @override
  _FoodItemTemplateState createState() => _FoodItemTemplateState();
}

class _FoodItemTemplateState extends State<FoodItemTemplate> {
  @override
  Widget build(BuildContext context) {
    var _foodProvider = context.read<FoodProvider>();

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 70,
          width: MediaQuery.of(context).size.width * .99,
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: widget.foodItem.color,
                width: 1,
              ),
            ),
          ),
        ),
        Container(
          // padding: EdgeInsets.only(right:15,top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Checkbox(
                  activeColor: widget.foodItem.color,
                  checkColor: Colors.white,
                  value: context
                      .watch<FoodProvider>()
                      .getFoodItem(int.parse(widget.foodItem.id) - 1)
                      .selected,
                  onChanged: (value) {
                    _foodProvider
                        .setSelectedWhereId(int.parse(widget.foodItem.id) - 1);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, right: 20),
                child: Text(
                  widget.foodItem.content,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
