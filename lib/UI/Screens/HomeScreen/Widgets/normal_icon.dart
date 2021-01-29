import 'package:flutter/material.dart';

class NormalIcon extends StatelessWidget {

  final IconData icon;
  final double sizeIcon;

   NormalIcon( { this.icon, this.sizeIcon}) ;


  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: sizeIcon,
    );
  }
}
