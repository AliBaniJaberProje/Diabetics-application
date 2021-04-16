import 'dart:math';

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/history/suqar_reding_history.dart';
import 'package:ali_muntaser_final_project/core/Providers/food-history-provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';

import 'dart:ui' as ui;

Future<DateTime> selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020, 8),
    lastDate: DateTime.now(),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(
              primary: Colors.purple,
              secondary: Colors.amber
          ),
        ),
        child: child,
      );
    },
  );
  return picked;
}

class FoodHistory extends StatefulWidget {
  static String routName = "/FoodHistory";

  FoodHistory({Key key}) : super(key: key);

  @override
  _FoodHistoryState createState() => _FoodHistoryState();
}

class _FoodHistoryState extends State<FoodHistory> {
  int tableChar = 0;
  int init=1;






  @override
  Widget build(BuildContext context) {
    var foodHistoryProviderWatch=context.watch<FoodHistoryProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<FoodHistoryProvider>().clearData();
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        title:TextLiquidFill(
          text: 'الأطعمة التي تناولتها سابقا',
          waveColor: Colors.white,
          boxBackgroundColor: Colors.purple,
          waveDuration: Duration(seconds: 1),
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

        ),

        //Text("الأطعمة التي تناولتها سابقا",textDirection: ui.TextDirection.rtl,),
        centerTitle: true,

      ),
      body:

      tableChar == 0
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
                      context.watch<FoodHistoryProvider>().initTextChart,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textDirection: ui.TextDirection.rtl,
                    ),
                  ),
                ),
                context.watch<FoodHistoryProvider>().loading?Center(child: CircularProgressIndicator(),) :
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
                        dataSource: foodHistoryProviderWatch.chartData,
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
            fabsinglemenu(Icons.date_range_sharp, ()async {

                 selectDate(context).then(( date){

                   if(date==null){
                     print("NUll Date ");
                     return ;
                   }else{
                     context.read<FoodHistoryProvider>().setNewDateAndSendRequest(year: "${date.year}" ,month: "${date.month}", day: "${date.day}");

                   }

                 });

                },)
          ],),
    );
  }
}

class FoodHistoryTable extends StatelessWidget {






  @override
  Widget build(BuildContext context) {
    var providerFoodHistory=context.watch<FoodHistoryProvider>();
    return Column(

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
              context.watch<FoodHistoryProvider>().initTitle,
              style: TextStyle(
                fontSize: 18,
              ),
              textDirection: ui.TextDirection.rtl,
            ),
          ),
        ),
       context.watch<FoodHistoryProvider>().loading?Center(
         child: CircularProgressIndicator(),
       ): Expanded(
          child:ListView.builder(
              itemCount: providerFoodHistory.foodHistoryDataTable.length,

              itemBuilder: (ctx, index) {
                var foodItem=providerFoodHistory.foodHistoryDataTable[index];


                return  FoodHistoryItem(
                  ch:foodItem.ch,
                  proten: foodItem.proten,
                  fat: foodItem.fat,
                  foodAmount: foodItem.amount,
                  foodName: foodItem.name,
                  image: foodItem.img,
                  color: foodItem.color,
                  shadowColor: foodItem.shadowColor,
                );

              }

            //
          ),
        ),

      ],

    );



  }
}

class FoodHistoryItem extends StatelessWidget {
  final String image;
  final double ch;
  final double proten;
  final double fat;
  final String foodName;
  final int foodAmount;
  final Color color;
  final Color shadowColor;
  FoodHistoryItem(
      {this.image,
      this.ch,
      this.proten,
      this.fat,
      this.foodName,
      this.foodAmount,
      this.color,
      this.shadowColor
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color:this.color, width: 1),
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
                    border: Colors.purple,
                    title: " كربوهيدرات",
                    amount: this.ch,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CombonentFoodItem(
                    color: Colors.amber.shade100,
                    border: Colors.amber,
                    title: "دهون",
                    amount: this.fat,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CombonentFoodItem(
                    color: Colors.green.shade100,
                    border: Colors.green,
                    title: "بروتين",
                    amount: this.proten,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
              Card(
                margin: EdgeInsets.all(15),
                color: this.shadowColor,
                elevation: 1,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color:this.color,
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
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 45),
                              color: this.shadowColor,
                              height: 120,
                              width: MediaQuery.of(context).size.width * .33,
                              child:  CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            )
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
  final Color border;
  final String title;
  final double amount;

  const CombonentFoodItem({this.color, this.title, this.amount,this.border});

  @override
  Widget build(BuildContext context) {
    return   Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: this.color,
                border: Border.all(
                    color: border,
                    width: 1.5
                )

          ),
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              Text("${this.amount}",
                  style: TextStyle(fontSize: 17),
                  textDirection: ui.TextDirection.rtl),
              Text(this.title ,
                  style: TextStyle(fontSize: 17),
                  textDirection: ui.TextDirection.rtl),
            ],
          ),
          height: 50,
          width: 220,



    );
  }
}
