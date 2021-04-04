import 'dart:convert';

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import '../../../core/Providers/dose_history_provider.dart';
class DoseHistoryDose extends StatefulWidget {
  static String routeName = "/DoseHHistoryDose";
  DoseHistoryDose({Key key}) : super(key: key);

  @override
  _DoseHistoryDoseState createState() => _DoseHistoryDoseState();
}

class _DoseHistoryDoseState extends State<DoseHistoryDose> {
  bool loading = true;
  int indexColor = 0;
  List<Color> color = [
    Colors.greenAccent.shade100,
    Colors.amber.shade100,
    Colors.blueAccent.shade100,
    Colors.purpleAccent.shade100,
    Colors.orangeAccent.shade100,
  ];
  DateTime selectedDate;

  var json;
  var jsonSample="";

  // @override
  // void initState() {
  //   http.get("http://192.168.0.112:3000/doseHistory",headers: {}).then((value) {
  //     jsonSample = value.body;
  //     json = jsonDecode(jsonSample);
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  //
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("الجراعات الطبية السابقة"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
      ),
      body: context.watch<DoseHistoryProvider>().jsonSample.isEmpty? Center(child: Text("قم باختيار الشهر",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w200,fontSize: 25),),):
      context.watch<DoseHistoryProvider>().loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
             // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: JsonTable(
                context.watch<DoseHistoryProvider>().json,
                tableHeaderBuilder: (String header) {
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 11, vertical: 4.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        color: Colors.purple.shade200),
                    child: Text(
                      header,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.display1.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: Colors.black87),
                    ),
                  );
                },
                tableCellBuilder: (value) {
                  return Container(
                    height: 30,
                    padding:
                        EdgeInsets.symmetric(horizontal:11, vertical: 2.0),
                    decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        border: Border.all(
                            width: 0.5, color: Colors.grey.withOpacity(0.5))),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontSize: 14.0, color: Colors.grey[900]),
                    ),
                  );
                },


                allowRowHighlight: true,
                rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
              )),


      bottomSheet: Container(
        child: ClipPath(
          clipper: WaveClipperTwo(reverse: true),
          child: Container(
            height: 120,
            color: Colors.amber,
            child: Center(

              child:Container(
                margin: EdgeInsets.all(20),
              child:  FloatingActionButton(

                onPressed: () {
                  showMonthPicker(

                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: DateTime.now(),
                    // locale: Locale("es"),
                  ).then((date) {
                    if (date != null) {
                      context.read<DoseHistoryProvider>().fetchData(date.month,date.year);
                      print(date.month);
                      setState(() {
                        selectedDate = date;
                      });
                    }
                  });
                },
                child: Icon(Icons.calendar_today),
              ), ),
             )
          ),
        ),
      ),
      // floatingActionButton: Builder(
      //
      //   builder: (context) => FloatingActionButton(
      //     onPressed: () {
      //       showMonthPicker(
      //
      //         context: context,
      //         firstDate: DateTime(DateTime.now().year - 1, 5),
      //         lastDate: DateTime(DateTime.now().year + 1, 9),
      //         initialDate: DateTime.now(),
      //         // locale: Locale("es"),
      //       ).then((date) {
      //         if (date != null) {
      //           context.read<DoseHistoryProvider>().fetchData(date.month,date.year);
      //           print(date.month);
      //           setState(() {
      //             selectedDate = date;
      //           });
      //         }
      //       });
      //     },
      //     child: Icon(Icons.calendar_today),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
