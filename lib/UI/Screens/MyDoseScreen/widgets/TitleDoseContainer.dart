
import 'package:flutter/cupertino.dart';

class TitleDoseContainer extends StatelessWidget {
  final String _title;

  TitleDoseContainer(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(

          child: Text(
            "${this._title}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
            //textAlign: TextAlign.start,
          ),


    );
  }
}
