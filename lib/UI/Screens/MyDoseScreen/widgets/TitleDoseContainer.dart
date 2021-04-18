
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
class TitleDoseContainer extends StatelessWidget {
  final String _title;

  TitleDoseContainer(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(

          child: Text(
            "${this._title}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,

            ),
            textAlign: TextAlign.justify,
            textDirection: ui.TextDirection.ltr,
            //textAlign: TextAlign.start,
          ),


    );
  }
}
