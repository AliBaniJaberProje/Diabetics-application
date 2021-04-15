import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';

import 'package:ali_muntaser_final_project/core/Providers/food-history-provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../core/Providers/histry_number_of_stepProvider.dart';
import 'food_history.dart';

class NumberStepsHistory extends StatefulWidget {
  static String routeName = "/NumberStepsHistory";
  NumberStepsHistory({Key key}) : super(key: key);

  @override
  _NumberStepsHistoryState createState() => _NumberStepsHistoryState();
}
// String text;
// double data;
// Color color;
class _NumberStepsHistoryState extends State<NumberStepsHistory> {




  ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    zoomMode: ZoomMode.xy,
    enablePanning: true,
  );

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<NumberOfStepHistory>().clearData();
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        title: Text(
          "النشاط الرياضي ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textDirection: ui.TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.purple, width: 3),),
              child: Center(
                child: Text(
                  context.watch<NumberOfStepHistory>().title,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textDirection: ui.TextDirection.rtl,
                ),
              ),
            ),
           context.watch<NumberOfStepHistory>().loading?Center(child: CircularProgressIndicator(),):

           context.watch<NumberOfStepHistory>().isEmpty?Center(child: Text("لم تقم بمممارسة نشاط رياضي في هذا الشهر",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),): Expanded(
              child: ListView(

               children:[

                  Container(
                    height: 500,
                    child: SfCartesianChart(



                        zoomPanBehavior: _zoomPanBehavior,

                        primaryXAxis: CategoryAxis(),
                        series: <CartesianSeries>[

                          ColumnSeries<ChartData, String>(
                            xAxisName: "اليوم",
                            yAxisName: "المسافة(كم)",
                              dataSource: context.watch<NumberOfStepHistory>().chartData,
                              xValueMapper: (ChartData data, _) => data.text,
                              yValueMapper: (ChartData data, _) => data.data,
                              pointColorMapper: (ChartData data, _) => Colors.amber.shade100
                          )
                        ]
                    ),
                  ),



                  SizedBox(height: 30,),

                 context.watch<NumberOfStepHistory>().totalTitel.isEmpty?Text(""): Container(

                    margin: EdgeInsets.symmetric(horizontal: 50),

                    child: CombonentFoodItem(color: Colors.purple.shade100,title: context.watch<NumberOfStepHistory>().totalTitel,amount:  context.watch<NumberOfStepHistory>().total,border: Colors.purple,),
                  ),

                  // SizedBox(height: 10,),
                  //
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 50),
                  //
                  //   child: CombonentFoodItem(color: Colors.amber.shade100,title: "المجموع لشهر الحالي",amount: 20,border: Colors.amber,),
                  // ),


                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        child: Icon(Icons.date_range_sharp),

        onPressed: (){
          showMonthPicker(

            context: context,
            firstDate: DateTime(DateTime.now().year - 1, 5),
            lastDate: DateTime.now(),
            initialDate: DateTime.now(),
            // locale: Locale("es"),
          ).then((date) {
            if (date != null) {
              context.read<NumberOfStepHistory>().fetchAllInDate("${date.year}","${date.month}");

              print(date.month);

            }
          });
        },
        ),




    );
  }


}

class SalesData1 {
  final int year;
  final double value;


  SalesData1(this.year, this.value);
}
