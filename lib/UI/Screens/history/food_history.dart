import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/history/suqar_reding_history.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:ui' as ui;

class FoodHistory extends StatefulWidget {
  static String routName = "/FoodHistory";

  FoodHistory({Key key}) : super(key: key);

  @override
  _FoodHistoryState createState() => _FoodHistoryState();
}

class _FoodHistoryState extends State<FoodHistory> {
  int tableChar = 0;
  List<ChartData> chartData = [
    ChartData("كربوهيدرات", 100, Colors.purple.shade300),
    ChartData("دهون", 38, Colors.amber.shade300),
    ChartData("بروتين", 34, Colors.green.shade300),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
      ),
      body: tableChar == 0
          ? FoodHistoryTable()
          : ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.purple,width: 3)
                  ),

                  child: Center(
                    child: Text(
                      "رسم بياني لمكوانات الطعام المتناول في 1-1-2020",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textDirection: ui.TextDirection.rtl,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .7,
                  child: SfCircularChart(
                    legend: Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                        padding: 30,
                        iconBorderColor: Colors.purple,
                        backgroundColor: Colors.grey.shade300,
                        textStyle: TextStyle(fontSize: 18),
                        width: "${MediaQuery.of(context).size.width * .8}",
                        isResponsive: true,
                        toggleSeriesVisibility: true,
                        title: LegendTitle(
                            text: 'رسم بياني لمكونات الاكل ',
                            textStyle: ChartTextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w900)),
                        borderColor: Colors.black,
                        borderWidth: 1),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CircularSeries>[
                      PieSeries<ChartData, String>(
                        explode: true,
                        enableSmartLabels: true,
                        dataSource: chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.text,
                        yValueMapper: (ChartData data, _) => data.data,
                        dataLabelMapper: (ChartData data, _) => data.text,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.outside,
                            useSeriesColor: true,
                            connectorLineSettings: ConnectorLineSettings(
                                type: ConnectorType.curve)),
                      )
                    ],
                  ),
                ),
              ],
            ),
      primary: true,
      drawerEnableOpenDragGesture: true,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      extendBody: true,
      floatingActionButton: FabCircularMenu(
          animationDuration: Duration(seconds: 1),
          fabColor: Colors.purple.shade100,
          ringWidth: 100,
          ringDiameter: 450,
          fabCloseColor: Colors.purple,
          fabOpenColor: Colors.red,
          fabOpenIcon: Icon(Icons.menu, color: Colors.white),
          fabCloseIcon: Icon(Icons.close, color: Colors.white),
          ringColor: Colors.purple.shade300,
          children: <Widget>[
            fabsinglemenu(Icons.pie_chart, () {
              setState(() {
                tableChar = 1;
              });
            }),
            fabsinglemenu(Icons.table_rows_outlined, () {
              setState(() {
                tableChar = 0;
              });
            }),
            Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.purple,
                ),
                child: fabsinglemenu(Icons.date_range_sharp, () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    //useRootNavigator: true,
                    // locale: Locale("es"),
                  ).then((date) {
                    if (date != null) {
                      print(date);
                    }
                  });
                }))
          ]),
    );
  }
}

class ChartData {
  final String text;
  final int data;
  final Color color;
  ChartData(this.text, this.data, this.color);
}

class FoodHistoryTable extends StatelessWidget {
  const FoodHistoryTable({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,

      itemBuilder: (ctx, index) => FoodHistoryItem(
        ch: 100.0,
        proten: 150.0,
        fat: 70.0,
        foodAmount: 980.5,
        foodName: "اناناس",
        image:
            "https://jaber-server.herokuapp.com/images/Fruits/%D8%A7%D9%86%D9%86%D8%A7%D8%B3.png",
      ),
      //
    );
  }
}

class FoodHistoryItem extends StatelessWidget {
  final String image;
  final double ch;
  final double proten;
  final double fat;
  final String foodName;
  final double foodAmount;

  FoodHistoryItem(
      {this.image,
      this.ch,
      this.proten,
      this.fat,
      this.foodName,
      this.foodAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber, width: 1),
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CombonentFoodItem(
                    color: Colors.purple.shade100,
                    title: " كربوهيدرات",
                    amount: 95.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CombonentFoodItem(
                    color: Colors.amber.shade100,
                    title: "دهون",
                    amount: 70.5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CombonentFoodItem(
                    color: Colors.green.shade100,
                    title: "بروتين",
                    amount: 80.5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
              Card(
                margin: EdgeInsets.all(15),
                color: Colors.amber.shade100,
                elevation: 1,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Colors.amber,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      child: Image.network(
                        this.image,
                        height: 120,
                        width: MediaQuery.of(context).size.width * .33,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: Text(this.foodName,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center,
                          textDirection: ui.TextDirection.rtl),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //${this.foodAmount}
          Center(
            child: Text(
                "\t${this.foodName} " +
                    "\t " +
                    " ${this.foodAmount}غرام  \t " +
                    " ",
                style: TextStyle(fontSize: 18),
                textDirection: ui.TextDirection.rtl),
          ),
        ],
      ),
    );
  }
}

class CombonentFoodItem extends StatelessWidget {
  final Color color;
  final String title;
  final double amount;

  const CombonentFoodItem({this.color, this.title, this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: this.color,
      ),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(this.title + ":" + "${this.amount}".padLeft(20, " "),
              style: TextStyle(fontSize: 17),
              textDirection: ui.TextDirection.rtl)
        ],
      ),
      height: 50,
      width: 220,
    );
  }
}
