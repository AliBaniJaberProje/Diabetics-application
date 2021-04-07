

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/TestCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fradio/fradio.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}








class SuqarRedingHistory extends StatefulWidget {
  static String routName = "/SuqarRedingHistory";
  SuqarRedingHistory({Key key}) : super(key: key);

  @override
  _SuqarRedingHistoryState createState() => _SuqarRedingHistoryState();
}

class _SuqarRedingHistoryState extends State<SuqarRedingHistory> {
  bool _value1 = true;
  bool _value2 = true;
  bool _value3 = true;
  bool _value4 = true;
  ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    zoomMode: ZoomMode.xy,
    enablePanning: true,
  );
  int tableVScHART=1;
  bool groupValue_3 =true;

  @override
  Widget build(BuildContext context) {
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        actions: [
          FlatButton.icon(
            onPressed: (){
              showMonthPicker(

                context: context,
                firstDate: DateTime(DateTime.now().year - 1, 5),
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
                // locale: Locale("es"),
              ).then((date) {
                if (date != null) {

                  print(date.month);

                }
              });


            },
            label: Text("التاريخ",style: TextStyle(color: Colors.white,fontSize: 18),),
            icon: Icon(Icons.date_range,color: Colors.white,size: 18,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: [
              tableVScHART==1? Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 60,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 130,
                         height:20,
                         margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                         padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.green,
                              value: _value1,
                              onChanged: (val) {
                                setState(() {
                                  _value1 = val;
                                });
                              },
                            ),
                            Text("قبل الافطار ",style: TextStyle(fontSize: 15,),),
                          ],
                        ),
                      ),

                      Container(
                        width: 140,

                        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.blue,
                              value: _value2,
                              onChanged: (val) {
                                setState(() {
                                  _value2 = val;
                                });
                              },
                            ),
                            Text("بعد الافطار ",style: TextStyle(fontSize: 15,),),
                          ],
                        ),
                      ),

                      Container(
                        width: 140,

                        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.amber,
                              value: _value3,
                              onChanged: (val) {
                                setState(() {
                                  _value3 = val;
                                });
                              },
                            ),
                            Text("بعد الغداء ",style: TextStyle(fontSize: 15,),),
                          ],
                        ),
                      ),

                      Container(
                        width: 140,

                        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red.shade100,

                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Colors.red,
                              value: _value4,
                              onChanged: (val) {
                                setState(() {
                                  _value4 = val;
                                });
                              },
                            ),
                            Text("بعد العشاء ",style: TextStyle(fontSize: 15,),),
                          ],
                        ),
                      ),

                    ],
                  )):Text(""),
              tableVScHART==1? Container(
                height: 650,
                child: SfCartesianChart(

                    zoomPanBehavior: _zoomPanBehavior,
                    legend: Legend(
                        isVisible: true,
                        title: LegendTitle(
                            text: 'رسم بياني لقرائات السكري',
                            textStyle: ChartTextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w900)),
                        borderColor: Colors.black,
                        borderWidth: 1),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    borderColor: Colors.black,
                    plotAreaBackgroundColor: Colors.purple.shade50,
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(text: 'فحوصات السكري لشهر  2021-1'),
                    series: <ChartSeries>[
                      StackedLineSeries<SalesData, String>(
                          legendItemText: "قبل الافطار",
                          enableTooltip: true,
                          isVisibleInLegend: true,
                          color: Colors.green,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true, useSeriesColor: true),
                          dataSource: _value1
                              ? <SalesData>[
                                  SalesData('1/1', 105),
                                  SalesData('1/2', 95),
                                  SalesData('1/3', 98),
                                  SalesData('1/4', 100),
                                  SalesData('1/5', 105),
                                  SalesData('1/6', 95),
                                  SalesData('1/7', 98),
                                  SalesData('1/8', 100),
                                  SalesData('1/9', 50),
                                  SalesData('1/10', 60),
                                  SalesData('1/11', 70),
                                  SalesData('1/12', 80),
                                  SalesData('1/13', 105),
                                  SalesData('1/14', 95),
                                  SalesData('1/15', 98),
                                  SalesData('1/16', 100),
                                  SalesData('1/17', 105),
                                  SalesData('1/18', 95),
                                  SalesData('1/19', 98),
                                  SalesData('1/20', 100),
                                  SalesData('1/21', 50),
                                  SalesData('1/22', 60),
                                  SalesData('1/23', 70),
                                  SalesData('1/24', 80),
                                  SalesData('1/25', 98),
                                  SalesData('1/26', 100),
                                  SalesData('1/27', 105),
                                  SalesData('1/28', 95),
                                  SalesData('1/29', 98),
                                  SalesData('1/30', 100),


                                ]
                              : [],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales),
                      StackedLineSeries<SalesData, String>(
                          name: "بعد الافطار",
                          color: Colors.blue,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true, useSeriesColor: true),
                          dataSource: _value2
                              ? <SalesData>[
                            SalesData('1/1', 105),
                            SalesData('1/2', 95),
                            SalesData('1/3', 98),
                            SalesData('1/4', 100),
                            SalesData('1/5', 105),
                            SalesData('1/6', 95),
                            SalesData('1/7', 98),
                            SalesData('1/8', 100),
                            SalesData('1/9', 50),
                            SalesData('1/10', 60),
                            SalesData('1/11', 70),
                            SalesData('1/12', 80),
                            SalesData('1/13', 105),
                            SalesData('1/14', 95),
                            SalesData('1/15', 98),
                            SalesData('1/16', 100),
                            SalesData('1/17', 105),
                            SalesData('1/18', 95),
                            SalesData('1/19', 98),
                            SalesData('1/20', 100),
                            SalesData('1/21', 50),
                            SalesData('1/22', 60),
                            SalesData('1/23', 70),
                            SalesData('1/24', 80),
                            SalesData('1/25', 98),
                            SalesData('1/26', 100),
                            SalesData('1/27', 105),
                            SalesData('1/28', 95),
                            SalesData('1/29', 98),
                            SalesData('1/30', 100),
                                ]
                              : [],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales),
                      StackedLineSeries<SalesData, String>(
                          name: "بعد الغداء",
                          color: Colors.amber,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true, useSeriesColor: true),
                          dataSource: _value3
                              ? <SalesData>[
                            SalesData('1/1', 105),
                            SalesData('1/2', 95),
                            SalesData('1/3', 98),
                            SalesData('1/4', 100),
                            SalesData('1/5', 105),
                            SalesData('1/6', 95),
                            SalesData('1/7', 98),
                            SalesData('1/8', 100),
                            SalesData('1/9', 50),
                            SalesData('1/10', 60),
                            SalesData('1/11', 70),
                            SalesData('1/12', 80),
                            SalesData('1/13', 105),
                            SalesData('1/14', 95),
                            SalesData('1/15', 98),
                            SalesData('1/16', 100),
                            SalesData('1/17', 105),
                            SalesData('1/18', 95),
                            SalesData('1/19', 98),
                            SalesData('1/20', 100),
                            SalesData('1/21', 50),
                            SalesData('1/22', 60),
                            SalesData('1/23', 70),
                            SalesData('1/24', 80),
                            SalesData('1/25', 98),
                            SalesData('1/26', 100),
                            SalesData('1/27', 105),
                            SalesData('1/28', 95),
                            SalesData('1/29', 98),
                            SalesData('1/30', 100),
                                ]
                              : [],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales),
                      StackedLineSeries<SalesData, String>(
                          name: "بعد العشاء",
                          color: Colors.red,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true, useSeriesColor: true),
                          dataSource: _value4
                              ? <SalesData>[
                            SalesData('1/1', 105),
                            SalesData('1/2', 95),
                            SalesData('1/3', 98),
                            SalesData('1/4', 100),
                            SalesData('1/5', 105),
                            SalesData('1/6', 95),
                            SalesData('1/7', 98),
                            SalesData('1/8', 100),
                            SalesData('1/9', 50),
                            SalesData('1/10', 60),
                            SalesData('1/11', 70),
                            SalesData('1/12', 80),
                            SalesData('1/13', 105),
                            SalesData('1/14', 95),
                            SalesData('1/15', 98),
                            SalesData('1/16', 100),
                            SalesData('1/17', 105),
                            SalesData('1/18', 95),
                            SalesData('1/19', 98),
                            SalesData('1/20', 100),
                            SalesData('1/21', 50),
                            SalesData('1/22', 60),
                            SalesData('1/23', 70),
                            SalesData('1/24', 80),
                            SalesData('1/25', 98),
                            SalesData('1/26', 100),
                            SalesData('1/27', 105),
                            SalesData('1/28', 95),
                            SalesData('1/29', 98),
                            SalesData('1/30', 100),
                                ]
                              : [],
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales),
                    ]



                    ),
              ):TableAllDalySuqarReading(),

            ],
          ),
        ),
      ),

      bottomSheet: Container(
        child: Container(
              height: 70,
             // color: Colors.amber.shade100,
              child: Center(

                child:     Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 140,

                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: tableVScHART,
                            onChanged: (v){
                              setState(() {
                                tableVScHART=v;
                              });
                            },
                          ),
                          Text(
                            'جدول',
                            style: new TextStyle(fontSize: 16.0),
                          ),

                        ],
                      ),
                    ),


                    Container(
                      width: 140,


                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value:1,
                            groupValue: tableVScHART,
                            onChanged: (v){
                              setState(() {
                                tableVScHART=v;
                              });
                            },
                          ),
                          Text(
                            'رسم بياني',
                            style: new TextStyle(fontSize: 16.0),
                          ),

                        ],
                      ),
                    ),




                  ],
                ),
              )

        ),
      ),



    );
  }
}








class TableAllDalySuqarReading extends StatefulWidget {
  TableAllDalySuqarReading({Key key}) : super(key: key);
  @override
  _TableAllDalySuqarReadingState createState() => _TableAllDalySuqarReadingState();
}

class _TableAllDalySuqarReadingState extends State<TableAllDalySuqarReading> {
  List<DatatableHeader> _headers = [
    DatatableHeader(
        text: "التاريخ",
        value: "التاريخ",
        headerBuilder: (value)=>Text("$value",style: TextStyle(fontSize: 20),),
        show: true,
        sourceBuilder: (value, row) {
          return Container(
              child:Text("$value",style: TextStyle(color:Colors.black,fontSize: 18),)
          );
        },
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "قبل الافطار",
        value: "قبل الافطار",
        show: true,
        sortable: true,
        headerBuilder: (value)=>Text("$value",style: TextStyle(fontSize: 20),),

        sourceBuilder: (value, row) {

          return Container(
            color:value<70? Colors.red:Colors.white,
            child: Column(
              children: [
                // Container(
                //   width: 85,
                //   color: Colors.red,
                //   child: LinearProgressIndicator(
                //     value: 1/5,
                //   ),
                // ),
                Text("$value",style: TextStyle(color:Colors.black,fontSize: 18),)
              ],
            ),
          );
        },


        textAlign: TextAlign.center),
    DatatableHeader(
        text: "بعد الافطار بساعتين",
        value: "بعد الافطار بساعتين",
        show: true,
        sortable: true,
        headerBuilder: (value)=>Text("$value",style: TextStyle(fontSize: 20),),
        sourceBuilder: (value, row) {
          return Container(
              color: value<70? Colors.red:Colors.white,
            child:Text("$value",style: TextStyle(color:Colors.black,fontSize: 18),)
          );
        },

        textAlign: TextAlign.center),
    DatatableHeader(
        text: "بعد الغداء بساعتين",
        value: "بعد الغداء بساعتين",
        show: true,
        sortable: true,
        sourceBuilder: (value, row) {
          return Container(
              color:value<70? Colors.red:Colors.white,
              child:Text("$value",style: TextStyle(color:Colors.black,fontSize: 18),)
          );
        },
        headerBuilder: (value)=>Text("$value",style: TextStyle(fontSize: 20),),

        textAlign: TextAlign.center),
    DatatableHeader(
        text: "بعد العشاء بساعتين",
        value: "بعد العشاء بساعتين",
        show: true,
        sortable: true,

        sourceBuilder: (value, row) {
          return Container(
            color:value<70? Colors.red:Colors.white,
              child:Text("$value",style: TextStyle(color:Colors.black,fontSize: 18),)
          );
        },
        headerBuilder: (value)=>Text("$value",style: TextStyle(fontSize: 20),),

        textAlign: TextAlign.center),
  ];

  List<int> _perPages = [5, 10, 15, 100];
  int _total = 100;
  int _currentPerPage;
  int _currentPage = 1;
  List<Map<String, dynamic>> _source = List<Map<String, dynamic>>();

  String _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;

  List<Map<String, dynamic>> _generateData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();

    temps.add({
      "التاريخ": "10/1/2021",
      "قبل الافطار": 50,
      "بعد الافطار بساعتين": 98,
      "بعد الغداء بساعتين": 80,
      "بعد العشاء بساعتين": 20,
    });
    temps.add({
      "التاريخ": "11/1/2021",
      "قبل الافطار": 100,
      "بعد الافطار بساعتين": 20,
      "بعد الغداء بساعتين": 90,
      "بعد العشاء بساعتين": 11,
    });

    return temps;
  }

  _initData() async {
    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 2)).then((value) {
      _source.addAll(_generateData());
      setState(() => _isLoading = false);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(0),
            color: Colors.purple,

            constraints: BoxConstraints(
              maxHeight: 900,
            ),
            child: Card(
              elevation: 1,
              shadowColor: Colors.black,
              child:  ResponsiveDatatable(

                 autoHeight:true,
                title:Text("جدول لفحوصات السكري لشهر 1-2021",style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,),
                actions: [
                  // if (_isSearch)
                  //   Expanded(
                  //       child: TextField(
                  //         decoration: InputDecoration(
                  //             prefixIcon: IconButton(
                  //                 icon: Icon(Icons.cancel),
                  //                 onPressed: () {
                  //                   setState(() {
                  //                     _isSearch = false;
                  //                   });
                  //                 }),
                  //             suffixIcon: IconButton(
                  //                 icon: Icon(Icons.search), onPressed: () {})),
                  //       )),
                  // if (!_isSearch)
                  //   IconButton(
                  //       icon: Icon(Icons.search),
                  //       onPressed: () {
                  //         setState(() {
                  //           _isSearch = true;
                  //         });
                  //       })
                ],
                headers: _headers,
                source: _source,
                selecteds: null,
                showSelect: _showSelect,

                onTabRow: (data) {
                  print(data);
                },
                onSort: (value) {
                  setState(() {
                    _sortColumn = value;
                    _sortAscending = !_sortAscending;
                    if (_sortAscending) {
                      _source.sort((a, b) =>
                          b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                    } else {
                      _source.sort((a, b) =>
                          a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                    }
                  });
                },
                sortAscending: _sortAscending,
                sortColumn: _sortColumn,
                isLoading: _isLoading,
                footers: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text("عدد الصفحات:"),
                  ),
                  if (_perPages != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: DropdownButton(
                          value: _currentPerPage,
                          items: _perPages
                              .map((e) => DropdownMenuItem(
                            child: Text("$e"),
                            value: e,
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _currentPerPage = value;
                            });
                          }),
                    ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text("$_currentPage   of $_total"),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentPage = _currentPage >= 2 ? _currentPage - 1 : 1;
                      });
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () {
                      setState(() {
                        _currentPage++;
                      });
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}









