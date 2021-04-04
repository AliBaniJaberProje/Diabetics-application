import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:ali_muntaser_final_project/core/Providers/NumberOfStepProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bar_data.dart';
import 'bar_titles.dart';

class NumberOfStep extends StatefulWidget {
  static String routeName = "/NumberOfStep";

  @override
  _StepsNumberState createState() => _StepsNumberState();
}

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class _StepsNumberState extends State<NumberOfStep> {


  @override
  void initState() {

    context.read<NumberOfStepProvider>().feachThisWeek();





    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    NumberOfStepProvider _numberOfStepProviderRead =
        context.read<NumberOfStepProvider>();
    NumberOfStepProvider _numberOfStepProviderWatch =
        context.watch<NumberOfStepProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        title: Container(
          margin: EdgeInsets.only(right: 30),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "الرياضة",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: Colors.amber.shade50,
        child: ListView(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(
                        _numberOfStepProviderRead.status == 'walking'
                            ? Icons.directions_walk
                            : _numberOfStepProviderRead.status == 'stopped'
                                ? Icons.accessibility_new
                                : Icons.error,
                        size: 100,
                        color: Colors.purple,
                      ),
                      Text(
                        _numberOfStepProviderRead.status,
                        style: _numberOfStepProviderRead.status == 'walking' ||
                                _numberOfStepProviderRead.status == 'stopped'
                            ? TextStyle(fontSize: 30, color: Colors.purple)
                            : TextStyle(fontSize: 20, color: Colors.red),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          _numberOfStepProviderWatch.count.toString(),
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    color: Colors.white.withOpacity(.01),
                    elevation: 3,
                    child: Container(
                      width: 200,
                      height: 200,
                    ),
                    shadowColor: Colors.purple,
                  ),
                )
                // Icon(Icons.stop)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  color: Colors.purple.shade50,
                  elevation: 2,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        "${_numberOfStepProviderWatch.hours.toString().padLeft(2, "0")}",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  ":",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Card(
                  color: Colors.purple.shade50,
                  elevation: 2,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        "${_numberOfStepProviderWatch.minutes.toString().padLeft(2, "0")}",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  ":",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Card(
                  color: Colors.purple.shade50,
                  elevation: 2,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        "${_numberOfStepProviderWatch.seconds.toString().padLeft(2, "0")}",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  color: Colors.amber,
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  // heroTag: "btn1",
                  // backgroundColor: Colors.purple,
                  // elevation: 100,
                  splashColor: Colors.white,
                  child: Icon(
                    _numberOfStepProviderRead.isRunMood()
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: !_numberOfStepProviderRead.isRunMood()
                      ? _numberOfStepProviderRead.initTimerAndRun
                      : _numberOfStepProviderRead.pauseTimer,
                ),
                FlatButton(
                  color: Colors.amber,
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  //  backgroundColor: Colors.purple,
                  splashColor: Colors.yellow,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: _numberOfStepProviderRead.killTimer,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: Colors.purple,
            ),

            Card(

              margin: EdgeInsets.all(25),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),

              ),
             // color: Colors.purple.shade100,
              child: Padding(
                padding: EdgeInsets.only(top: 13),
                child: BardChatWidget(),
              ),
            ),







            // LineChart(LineChartData(
            //   minX: 0,
            //   maxX: 11,
            //   minY: 0,
            //   maxY: 6,
            //   gridData: FlGridData(
            //     show: true,
            //     getDrawingHorizontalLine: (value) {
            //       return FlLine(
            //         color: Colors.purple,
            //       );
            //     },
            //     drawVerticalLine: true,
            //   ),
            //   backgroundColor: Colors.white,
            //   borderData: FlBorderData(
            //     show: true,
            //     border: Border.all(),
            //   ),
            //   lineBarsData: [
            //     LineChartBarData(spots: [
            //       FlSpot(0, 3),
            //       FlSpot(1, 6),
            //       FlSpot(2, 5),
            //       FlSpot(3, 1),
            //     ],
            //     isCurved: true,
            //       belowBarData: BarAreaData(
            //         show: true,
            //         colors: [
            //           Colors.yellowAccent.shade100,
            //           Colors.red
            //         ]
            //       )
            //     )
            //   ],
            // )),
          ],
        ),
      ),
    );
  }
}

class BardChatWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        maxY: 20,
        minY: 0,
        groupsSpace: 12,
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          topTitles: BarTitles.getTopBottomTitles(),
          bottomTitles: BarTitles.getTopBottomTitles(),
          leftTitles: BarTitles.getSideTitles(),
          rightTitles: BarTitles.getSideTitles(),
        ),
        gridData: FlGridData(
          checkToShowHorizontalLine: (value) => value % 5 == 0,
          getDrawingHorizontalLine: (value) {
            if (value == 0) {
              return FlLine(
                color: const Color(0xff363753),
                strokeWidth: 3,
              );
            } else {
              return FlLine(
                color: const Color(0xff2a2747),
                strokeWidth: 0.8,
              );
            }
          },
        ),
        barGroups: context.read<NumberOfStepProvider>().barData
            .map(
              (data) => BarChartGroupData(
            x: data.id,
            barRods: [
              BarChartRodData(
                y: data.y,
                width: 20,
                colors: [data.color],
                borderRadius: data.y > 0
                    ? BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                )
                    : BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
            ],
          ),
        )
            .toList(),
      ),
    );
  }


}

// class NumberOfStep extends StatelessWidget {

//}

//       Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text("النشاط الرياضي "),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () =>
//                   Navigator.pushReplacementNamed(context, HomeScreen.routeName),
//             )
//           ],
//         ),
//         body: Column(
//           children: [
//             SlideCountdownClock(
//               padding: EdgeInsets.all(10),
//               duration: _duration,
//               slideDirection: SlideDirection.Up,
//               separator: ":",
//               textStyle: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//               separatorTextStyle: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),
//
//               decoration: BoxDecoration(
//                 color: Colors.purple,
//                 shape: BoxShape.circle,
//               ),
//               onDone:()=> _key.currentState.showSnackBar(SnackBar(content:Text("gfds"))) ,
//
//             ),
//
//
//             SizedBox(
//               height: 10,
//             ),
//             // Center(
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     crossAxisAlignment: CrossAxisAlignment.center,
//             //     children: [
//             //       Card(
//             //         child: Container(
//             //             width: 80,
//             //             height: 80,
//             //             child: Center(
//             //               child: Text(
//             //                 "14\nHIR",
//             //                 style: TextStyle(
//             //                   fontSize: 25,
//             //                 ),
//             //               ),
//             //             )),
//             //       ),
//             //       Text(
//             //         ":",
//             //         style: TextStyle(
//             //           fontSize: 25,
//             //         ),
//             //       ),
//             //       Card(
//             //         child: Container(
//             //             width: 80,
//             //             height: 80,
//             //             child: Center(
//             //               child: Text(
//             //                 "43\nMIN",
//             //                 style: TextStyle(
//             //                   fontSize: 25,
//             //                 ),
//             //               ),
//             //             )),
//             //       ),
//             //       Text(
//             //         ":",
//             //         style: TextStyle(
//             //           fontSize: 25,
//             //         ),
//             //       ),
//             //       Card(
//             //         child: Container(
//             //             width: 80,
//             //             height: 80,
//             //             child: Center(
//             //               child: Text(
//             //                 "55\nSEC",
//             //                 style: TextStyle(
//             //                   fontSize: 25,
//             //                 ),
//             //               ),
//             //             )),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.pause_circle_outline),
//                   onPressed: () {},
//                   splashColor: Colors.purple,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.play_circle_outline),
//                   onPressed: () {},
//                   splashColor: Colors.purple,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.refresh),
//                   onPressed: () {},
//                   splashColor: Colors.purple,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Divider(
//               color: Colors.purple,
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomAppBar(
//           shape: const CircularNotchedRectangle(),
//           child: Container(
//             color: Colors.purple,
//             width: double.infinity,
//             height: 50.0,
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           tooltip: 'Increment Counter',
//           child: Icon(Icons.add),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       );
//   }
// }
//
//
//
//
