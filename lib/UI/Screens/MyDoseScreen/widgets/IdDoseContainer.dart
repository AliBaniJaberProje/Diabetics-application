
import 'package:flutter/cupertino.dart';

class IdDoseContainer extends StatelessWidget {
  final String _id;
  final Color _color;
  final double fontSize;
  IdDoseContainer(this._id, this._color, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: 40,
        child: Text(
          "${this._id}",
          style: TextStyle(fontSize: fontSize),
        ),
        decoration: BoxDecoration(
          color: this._color.withOpacity(.3),
          border: Border(),
        ),
      ),
    );
  }
}