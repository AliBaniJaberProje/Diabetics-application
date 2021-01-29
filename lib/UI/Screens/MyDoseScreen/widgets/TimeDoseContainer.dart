

import 'package:flutter/cupertino.dart';

class TimeDoseContainer extends StatelessWidget {
  final String _time;
  final Color _color;

  TimeDoseContainer(this._time, this._color);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: 70,
        child: Text(
          "${this._time}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        decoration: BoxDecoration(
          color: this._color.withOpacity(.3),
          border: Border(
            right: BorderSide(color: this._color),
          ),
        ),
      ),
    );
  }
}
