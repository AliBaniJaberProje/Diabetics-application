import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Data {
  // for ordering in the graph
  final int id;
  final String name;
   double y;
  final Color color;

   Data({
    @required this.name,
    @required this.id,
    @required this.y,
    @required this.color,
  });
}