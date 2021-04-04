import 'package:flutter/material.dart';

class Data1 {
  // for ordering in the graph
  final int id;
  final String name;
  final double y;
  final Color color;

  const Data1({
    @required this.name,
    @required this.id,
    @required this.y,
    @required this.color,
  });
}

class BarData {
  static int interval = 5;

  static List<Data1> barData = [

    Data1(
      id: 1,
      name: 'Mon',
      y: 15,
      color: Color(0xff19bfff),
    ),
    Data1(
      name: 'Tue',
      id: 2,
      y: 12,
      color: Color(0xffff4d94),
    ),
    Data1(
      name: 'Wed',
      id: 3,
      y: 11,
      color: Color(0xff2bdb90),
    ),
    Data1(
      name: 'Thu',
      id: 4,
      y: 10,
      color: Color(0xffffdd80),
    ),
    Data1(
      name: 'Fri',
      id: 5,
      y: 5,
      color: Color(0xff2bdb90),
    ),
    Data1(
      name: 'Sat',
      id: 6,
      y: 17,
      color: Color(0xffffdd80),
    ),
    Data1(
      name: 'Sun',
      id: 0,
      y: 5,
      color: Color(0xffff4d94),
    ),

  ];
}