import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:ali_muntaser_final_project/core/Providers/NumberOfStepProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Colors.purple,
                    elevation: 100,
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
                  Container(
                    width: 150,
                    height: 80,
                    child: Card(
                      color: Colors.purple[100],
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          _numberOfStepProviderWatch.count.toString(),
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Colors.purple,
                    splashColor: Colors.yellow,
                    child: Icon(Icons.refresh),
                    onPressed: _numberOfStepProviderRead.killTimer,
                  ),
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
              Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          _numberOfStepProviderRead.status == 'walking'
                              ? Icons.directions_walk
                              : _numberOfStepProviderRead.status == 'stopped'
                              ? Icons.accessibility_new
                              : Icons.error,
                          size: 100,
                        ),
                        Text(
                          _numberOfStepProviderRead.status,
                          style: _numberOfStepProviderRead.status == 'walking' || _numberOfStepProviderRead.status == 'stopped'
                              ? TextStyle(fontSize: 30)
                              : TextStyle(fontSize: 20, color: Colors.red),
                        ),

                      ],

                    )
                  ),
                  Center(
                    child: Card(
                      color: Colors.white70,
                      elevation: 1,
                      child: Container(
                        width: 300,
                        height: 300,
                      ),
                      shadowColor: Colors.purple,
                    ),
                  )
                  //Icon(Icons.stop)
                ],
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       'Steps taken:',
              //       style: TextStyle(fontSize: 30),
              //     ),
              //     Text(
              //       _steps,
              //       style: TextStyle(fontSize: 60),
              //     ),
              //     Divider(
              //       height: 100,
              //       thickness: 0,
              //       color: Colors.white,
              //     ),
              //     Text(
              //       'Pedestrian status:',
              //       style: TextStyle(fontSize: 30),
              //     ),
              //     Icon(
              //       _status == 'walking'
              //           ? Icons.directions_walk
              //           : _status == 'stopped'
              //               ? Icons.accessibility_new
              //               : Icons.error,
              //       size: 100,
              //     ),
              //     Center(
              //       child: Text(
              //         _status,
              //         style: _status == 'walking' || _status == 'stopped'
              //             ? TextStyle(fontSize: 30)
              //             : TextStyle(fontSize: 20, color: Colors.red),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
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
