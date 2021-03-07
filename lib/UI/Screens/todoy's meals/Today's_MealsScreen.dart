import 'dart:math';
import 'dart:ui';

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/core/Model/FoodItem.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'FoodScreen.dart';
import 'Widgets/FoodItemTemplate.dart';

class TabTemplate extends StatelessWidget {
  final String tabTitle;

  const TabTemplate({this.tabTitle});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        tabTitle,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TodayMeals extends StatefulWidget {
  static String routeName = "/TodayMeals";
  @override
  _TodayMealsState createState() => _TodayMealsState();
}

class _TodayMealsState extends State<TodayMeals> {
  List<String> listHeader = [
    'HEADER1',
    'HEADER2',
    'HEADER3',
    'HEADER4',
    'HEADER5',
    'HEADER6',
    'HEADER7',
    'HEADER8',
    'HEADER9',
    'HEADER10',
  ];
  List<String> listTitle = [
    'title1',
    'title2',
    'title3',
    'title4',
  ];
  DateTime _time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(" الأصناف الغذائية"),
        centerTitle: true,
        backgroundColor: Colors.purple.shade500,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
      ),
      body: GridView(
        padding: EdgeInsets.all(13),
        children: [


          InkWell(
            onTap: ()=>Navigator.pushReplacementNamed(context, FoodScreen.routerName),
            child:    Card(
              elevation: 5,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.purple,
                  width: 1,
                ),
              ),
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  //  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/p1.png",
                    height: 100,
                    width: 170,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Text(
                    "منتحات الألبان\n والبيض",
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
            ),
          ),




          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                //  padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/images/p2.png",
                  height: 100,
                  width: 170,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Text(
                  "الدهون والزيوت",
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),

          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                //  padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/images/p3.png",
                  height: 100,
                  width: 170,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Text(
                  "\n"
                  "منتجات الدواجن ",
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                //  padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/images/p4.png",
                  height: 100,
                  width: 170,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Text(
                  "فواكه \nوعصائر فواكه",
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),

          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                //  padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/images/p5.png",
                  height: 100,
                  width: 170,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Text(
                  "خضروات \n ومنتجات نباتية",
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                //  padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/images/p6.png",
                  height: 100,
                  width: 170,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Text(
                  "اللحوم الحمراء",
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),

          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                //  padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/images/p7.png",
                  height: 100,
                  width: 170,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                child: Text(
                  "المشروبات",
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ),
          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  //  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/p8.png",
                    height: 100,
                    width: 170,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Text(
                    "الأسماك",
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  //  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/p9.png",
                    height: 100,
                    width: 170,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Text(
                      "\n"
                  "البقوليات والحبوب",
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  //  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/p10.png",
                    height: 100,
                    width: 170,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Text(
                    "\n"
                        "منتجات المخبوزات",
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  //  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/p11.png",
                    height: 100,
                    width: 170,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Text(
                    "\n"
                        "الحلويات",
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  //  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/p12.png",
                    height: 100,
                    width: 170,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Text(
                    "\n"
                        " المعكرونة",
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          Card(
            elevation: 5,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.purple,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  //  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/p13.png",
                    height: 100,
                    width: 170,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Text(
                    "\n"
                        "وجبات خفيفة",
                    style: TextStyle(fontSize: 20, color: Colors.purple),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 /2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),

      // ListView(
      //   children: [
      //     SizedBox(height: 20,),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       //crossAxisAlignment: CrossAxisAlignment.spaceEvenly,
      //       children: [
      //         Card(
      //           elevation: 5,
      //           shape: BeveledRectangleBorder(
      //             borderRadius: BorderRadius.circular(10.0),
      //             side: BorderSide(
      //               color: Colors.purple,
      //               width: 1,
      //             ),
      //           ),
      //           child: Column(
      //             children: [
      //               Container(
      //               //  padding: EdgeInsets.all(10),
      //                 child: Image.asset(
      //                   "assets/images/p1.png",
      //                   height: 100,
      //                   width: 170,
      //                   fit: BoxFit.fill,
      //                 ),
      //               ),
      //               Container(
      //
      //                 child: Text(
      //                   "الحليب \n ومشتقات الالبان",
      //                   style: TextStyle(fontSize: 20, color: Colors.purple),
      //                   textAlign: TextAlign.center,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         Card(
      //           elevation: 5,
      //           shape: BeveledRectangleBorder(
      //             borderRadius: BorderRadius.circular(10.0),
      //             side: BorderSide(
      //               color: Colors.purple,
      //               width: 1,
      //             ),
      //           ),
      //           child: Column(
      //             children: [
      //               Container(
      //                 padding: EdgeInsets.only(top: 10),
      //                 child: Image.asset(
      //                   "assets/images/p2.png",
      //                   height: 100,
      //                   width: 170,
      //                   fit: BoxFit.fill,
      //                 ),
      //               ),
      //               Container(
      //                 height: 60,
      //                 child: Text(
      //                   "الزيوت والدهون",
      //                   style: TextStyle(fontSize: 20, color: Colors.purple),
      //                   textAlign: TextAlign.center,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //
      //
      //     SizedBox(height: 20,),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       //crossAxisAlignment: CrossAxisAlignment.spaceEvenly,
      //       children: [
      //         Card(
      //           elevation: 5,
      //           shape: BeveledRectangleBorder(
      //             borderRadius: BorderRadius.circular(10.0),
      //             side: BorderSide(
      //               color: Colors.purple,
      //               width: 1,
      //             ),
      //           ),
      //           child: Column(
      //             children: [
      //               Container(
      //                 //  padding: EdgeInsets.all(10),
      //                 child: Image.asset(
      //                   "assets/images/p4.png",
      //                   height: 100,
      //                   width: 170,
      //                   fit: BoxFit.fill,
      //                 ),
      //               ),
      //               Container(
      //                 padding: EdgeInsets.all(14),
      //                 child: Text(
      //                   "فواكه وعصائر الفواكه",
      //                   style: TextStyle(fontSize: 20, color: Colors.purple),
      //                   textAlign: TextAlign.center,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         Card(
      //           elevation: 5,
      //           shape: BeveledRectangleBorder(
      //             borderRadius: BorderRadius.circular(10.0),
      //             side: BorderSide(
      //               color: Colors.purple,
      //               width: 1,
      //             ),
      //           ),
      //           child: Column(
      //             children: [
      //               Container(
      //                 padding: EdgeInsets.only(top: 10),
      //                 child: Image.asset(
      //                   "assets/images/p3.png",
      //                   height: 100,
      //                   width: 170,
      //                   fit: BoxFit.fill,
      //                 ),
      //               ),
      //               Container(
      //                 height: 60,
      //                 child: Text(
      //                   "منتجات الدواجن",
      //                   style: TextStyle(fontSize: 20, color: Colors.purple),
      //                   textAlign: TextAlign.center,
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //
      //
      //   ],
      // ),
    );

    ///-------------------
  }
}
