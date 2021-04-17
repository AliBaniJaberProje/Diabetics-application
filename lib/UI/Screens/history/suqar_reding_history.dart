import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Widgets/MainDrawer/maindrawer.dart';
import 'package:ali_muntaser_final_project/core/Providers/suqar_reding_historyProvider.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

Widget fabsinglemenu(IconData icon, Function onPressFunction) {
  return SizedBox(
      width: 75,
      height: 75,
      child: RaisedButton(

        color: Colors.white,
        child: Icon(
          icon,
          color: Colors.deepPurpleAccent,
          size: 40,
        ),
        onPressed: onPressFunction,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(60.0),
        ),
      ));
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
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
  bool loading=true;
  ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    zoomMode: ZoomMode.xy,
    enablePanning: true,
  );
  int tableVScHART = 1;
  bool groupValue_3 = true;



  @override
  void initState() {
    context.read<SuqarReadingHistoryProvider>().fetchData().then((_){
      setState(() {
        loading=false;
      });
      print("rrrrrrrrrrrrrrr");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");

    return Scaffold(
      endDrawer:MainDrawer(),
      appBar: AppBar(

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        title: Text(
          " فحوصات السكري السابقة",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textDirection: ui.TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: loading?Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child:  Column(
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
                    context.read<SuqarReadingHistoryProvider>().titleTable,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textDirection: ui.TextDirection.ltr,
                  ),
                ),
              ),
              tableVScHART == 1
                  ? Container(
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
                       //   title: ChartTitle(text: context.read<SuqarReadingHistoryProvider>().titleTable,textStyle: TextStyle(color: Colors.purple)),
                          series: <CartesianSeries>[
                            LineSeries<SalesData, String>(
                                legendItemText: "قبل الافطار",
                                name:"قبل الافطار",
                                enableTooltip: true,
                                isVisibleInLegend: true,
                                color: Colors.green,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true, useSeriesColor: true),
                                dataSource: _value1
                                    ? context.watch<SuqarReadingHistoryProvider>().arr1
                                    : [],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales),
                            LineSeries<SalesData, String>(
                                name: "بعد الافطار",
                                color: Colors.blue,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true, useSeriesColor: true),
                                dataSource: _value2
                                    ? context.read<SuqarReadingHistoryProvider>().arr2
                                    : [],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales),
                            LineSeries<SalesData, String>(
                                name: "بعد الغداء",
                                color: Colors.amber,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true, useSeriesColor: true),
                                dataSource: _value3
                                    ? context.read<SuqarReadingHistoryProvider>().arr3
                                    : [],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales),
                            LineSeries<SalesData, String>(
                                name: "بعد العشاء",
                                color: Colors.red,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true, useSeriesColor: true),
                                dataSource: _value4
                                    ? context.read<SuqarReadingHistoryProvider>().arr4
                                    : [],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales),
                          ]),
                    )
                  : TableAllDalySuqarReading(),
            ],
          ),
        ),
      ),
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
            fabsinglemenu(Icons.table_chart, () {
              setState(() {
                tableVScHART = 0;
              });


            }),
            fabsinglemenu(Icons.stacked_bar_chart, () {
              setState(() {
                tableVScHART = 1;
              });
            }),
            fabsinglemenu(Icons.date_range_outlined, () {
              showMonthPicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 1, 5),
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
                // locale: Locale("es"),
              ).then((date) {
                if (date != null) {
                  setState(() {
                    loading=true;
                  });
                  context.read<SuqarReadingHistoryProvider>().setDateToSelect(date.month,date.year);
                  context.read<SuqarReadingHistoryProvider>().reFetchData().then((_){
                    setState(() {
                      loading=false;
                    });
                  });
                  print(date.month);
                }
              });


            }),
          ]), //FAB circular Menu
    );
  }
}

class TableAllDalySuqarReading extends StatefulWidget {
  TableAllDalySuqarReading({Key key}) : super(key: key);
  @override
  _TableAllDalySuqarReadingState createState() =>
      _TableAllDalySuqarReadingState();
}

class _TableAllDalySuqarReadingState extends State<TableAllDalySuqarReading> {
  List<DatatableHeader> _headers = [
    DatatableHeader(
        text: "التاريخ",
        value: "التاريخ",
        headerBuilder: (value) => Text(
              "$value",
              style: TextStyle(fontSize: 20),
            ),
        show: true,
        sourceBuilder: (value, row) {
          return Container(
              padding: EdgeInsets.all(10),
              child: Text(
            "$value".padLeft(3, " "),
            style: TextStyle(color: Colors.black, fontSize: 18),
          ));
        },
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "قبل الافطار",
        value: "قبل الافطار",
        show: true,
        sortable: true,
        headerBuilder: (value) => Text(
              "$value".padLeft(3, " "),
              style: TextStyle(fontSize: 20),
            ),
        sourceBuilder: (value, row) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: value < 70 ? Colors.red : Colors.white,
            ),
            child: Column(
              children: [
                Text(
                  "$value".padLeft(3, " "),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )
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
        headerBuilder: (value) => Text(
              "$value".padLeft(3, " "),
              style: TextStyle(fontSize: 20),
            ),
        sourceBuilder: (value, row) {
          return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: value < 70 ? Colors.red : Colors.white,
              ),
              child: Text(
                "$value".padLeft(3, " "),
                style: TextStyle(color: Colors.black, fontSize: 18),
              ));
        },
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "بعد الغداء بساعتين",
        value: "بعد الغداء بساعتين",
        show: true,
        sortable: true,
        sourceBuilder: (value, row) {
          return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: value < 70 ? Colors.red : Colors.white,
              ),
              child: Text(
                "$value".padLeft(3, " "),
                style: TextStyle(color: Colors.black, fontSize: 18),
              ));
        },
        headerBuilder: (value) => Text(
              "$value".padLeft(3, " "),
              style: TextStyle(fontSize: 20),
            ),
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "بعد العشاء بساعتين",
        value: "بعد العشاء بساعتين",
        show: true,
        sortable: true,
        sourceBuilder: (value, row) {
          return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: value < 70 ? Colors.red : Colors.white,
              ),

              child: Text(
                "$value".padLeft(3, " "),
                style: TextStyle(color: Colors.black, fontSize: 18),
              ));
        },
        headerBuilder: (value) => Text(
              "$value",
              style: TextStyle(fontSize: 20),
            ),
        textAlign: TextAlign.center),
  ];

  List<int> _perPages = [5, 10, 15];
  int _total = 100;
  int _currentPerPage;
  int _currentPage = 1;
  List<Map<String, dynamic>> _source = List<Map<String, dynamic>>();

  String _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;



  _initData() async {
    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 2)).then((value) {

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.purple,
            ),

            // constraints: BoxConstraints(
            //   maxHeight: 700,
            // ),
            child: Card(
              elevation: 1,
              shadowColor: Colors.black,
              child: ResponsiveDatatable(
                autoHeight: true,
                // title: Text(
                //  "\t"+context.watch<SuqarReadingHistoryProvider>().titleTable,
                //   style: TextStyle(
                //     fontSize: 20,
                //
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // actions: [
                //
                // ],
                headers: _headers,
                source: context.watch<SuqarReadingHistoryProvider>().temps,
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
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 15),
                  //   child: Text("عدد الصفحات:"),
                  // ),
                  // if (_perPages != null)
                  //   Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 15),
                  //     child: DropdownButton(
                  //         value: _currentPerPage,
                  //         items: _perPages
                  //             .map((e) => DropdownMenuItem(
                  //                   child: Text("$e"),
                  //                   value: e,
                  //                 ))
                  //             .toList(),
                  //         onChanged: (value) {
                  //           setState(() {
                  //             _currentPerPage = value;
                  //           });
                  //         }),
                  //   ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 15),
                  //   child: Text("$_currentPage   of $_total"),
                  // ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.arrow_back_ios,
                  //     size: 16,
                  //   ),
                  //   onPressed: () {
                  //     setState(() {
                  //       _currentPage = _currentPage >= 2 ? _currentPage - 1 : 1;
                  //     });
                  //   },
                  //   padding: EdgeInsets.symmetric(horizontal: 15),
                  // ),
                  // IconButton(
                  //   icon: Icon(Icons.arrow_forward_ios, size: 16),
                  //   onPressed: () {
                  //     setState(() {
                  //       _currentPage++;
                  //     });
                  //   },
                  //   padding: EdgeInsets.symmetric(horizontal: 15),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
