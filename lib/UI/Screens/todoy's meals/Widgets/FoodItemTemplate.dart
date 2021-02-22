import 'package:ali_muntaser_final_project/core/Providers/FoodProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

class FoodItemTemplate extends StatefulWidget {
  final Color color;
  final String content;
  final String id;
  FoodItemTemplate({this.id, this.color, this.content});

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
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width * .99,
          child: Card(
            color: widget.color,
            elevation: 10,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipPath(
              clipper: WaveClipperTwo(reverse: true),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: 20,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 25, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Checkbox(
                      activeColor: widget.color,
                      checkColor: Colors.white,
                      value: context
                          .watch<FoodProvider>()
                          .getFoodItem(int.parse(widget.id) - 1)
                          .selected,
                      onChanged: (value) {
                        _foodProvider
                            .setSelectedWhereId(int.parse(widget.id) - 1);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.swap_horizontal_circle_outlined,
                        color: widget.color,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  widget.content,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 60),
                child: Text(
                  widget.id,
                  style: TextStyle(
                      fontSize: 25,
                      //  fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
