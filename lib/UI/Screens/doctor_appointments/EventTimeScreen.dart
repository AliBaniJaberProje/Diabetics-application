import 'dart:convert';

import 'package:ali_muntaser_final_project/core/Providers/EventDateTimeProvier.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/eventServesAPI.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Doctor_appointmentScreen.dart';

class EventTimeScreen extends StatefulWidget {
  static String routeName = "/EventTimeScreen";

  @override
  _EventTimeScreenState createState() => _EventTimeScreenState();
}

List<Color> color = [
  Colors.greenAccent,
  Colors.amber,
  Colors.blueAccent,
  Colors.purpleAccent,
  Colors.orangeAccent,
];
List<Color> colorShadow = [
  Colors.greenAccent.shade100,
  Colors.amber.shade100,
  Colors.blueAccent.shade100,
  Colors.purpleAccent.shade100,
  Colors.orangeAccent.shade100,
];

class _EventTimeScreenState extends State<EventTimeScreen> {
  int _statusScreen = -2;

  @override
  void initState() {
    context
        .read<SlotDateTimeProvider>()
        .getAllEventInSelectedDateTime()
        .then((value) {
      setState(() {
        this._statusScreen = value;
      });
      print(value.toString() +
          "---------------------------------------------------------");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _eventProviderWatch = context.watch<SlotDateTimeProvider>();
    var _eventProviderRead = context.read<SlotDateTimeProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          _eventProviderWatch.getDateTime(),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            _eventProviderRead.clearAllEvents();

            Navigator.pushReplacementNamed(
                context, DoctorAppointmentsScreen.routeName);
          },
        ),
      ),
      body: this._statusScreen < 0
          ? Center(
              child: this._statusScreen == -1
                  ? Text("لا يوجد مواعيد متاحة")
                  : CircularProgressIndicator(),
            )
          : AnimationLimiter(
              child: GridView.builder(
                padding: EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 16 / 9,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: _eventProviderWatch.listEventSloat.length,
                itemBuilder: (ctx, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: _eventProviderWatch.listEventSloat.length,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: colorShadow[index % colorShadow.length],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: color[index % color.length],
                                spreadRadius: 1,
                                blurRadius: 0,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TimeStartToEndWidget(
                                  startToEndText: _eventProviderWatch
                                      .listEventSloat[index]
                                      .getDateStarToEnd()),
                              SizedBox(
                                height: 10,
                              ),
                              FlatButton.icon(
                                color: color[index % color.length],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                      color: color[index % color.length],
                                    )),
                                onPressed: () {
                                  _eventProviderRead.clearAllEvents();
                                  context
                                      .read<SlotDateTimeProvider>()
                                      .getAllEventInSelectedDateTime()
                                      .then((value) async {
                                    setState(() {
                                      this._statusScreen = value;
                                    });

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.info,
                                        backgroundColor: colorShadow[
                                            index % colorShadow.length],
                                        title: "تأكيد الحجز لزيارة الطبيب ",
                                        confirmBtnText: "نعم",
                                        cancelBtnText: "  الغاء ",
                                        confirmBtnTextStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                        cancelBtnTextStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                        confirmBtnColor:
                                            color[index % colorShadow.length],
                                        showCancelBtn: true,
                                        onConfirmBtnTap: () {
                                          print("yessssssss");
                                          Navigator.pop(context);

                                          setSelectedOfEventIForId(
                                                  _eventProviderWatch
                                                      .listEventSloat[index].id)
                                              .then((value) {
                                            if (jsonDecode(value.body)["msg"] ==
                                                "error operation") {
                                              CoolAlert.show(
                                                backgroundColor: colorShadow[
                                                    index % colorShadow.length],
                                                confirmBtnColor: color[
                                                    index % colorShadow.length],
                                                cancelBtnTextStyle: TextStyle(
                                                    color: Colors.black54),
                                                confirmBtnText: "الغاء",
                                                context: context,
                                                type: CoolAlertType.error,
                                                //   title: "Oops...",
                                                title:
                                                    "لا يمكن الحجز بهذا الموعد يرجى الغاء الحجز السابق",
                                              );
                                            } else if (jsonDecode(
                                                    value.body)["msg"] ==
                                                "selected operation done") {
                                              CoolAlert.show(
                                                  backgroundColor: colorShadow[
                                                      index %
                                                          colorShadow.length],
                                                  context: context,
                                                  type: CoolAlertType.success,
                                                  title:
                                                      " تم اختيار موعد لزيارة الطبيب بتاريخ",
                                                  text: _eventProviderWatch
                                                          .getDateTime() +
                                                      "\n" +
                                                      _eventProviderWatch
                                                          .listEventSloat[index]
                                                          .getDateStarToEnd(),
                                                  confirmBtnText: "تم",
                                                  confirmBtnColor:
                                                      Colors.green);
                                            }

                                            print(value.body);
                                          });
                                        },
                                        onCancelBtnTap: () {
                                          print("nooooo");
                                          Navigator.pop(context);
                                        });

                                    print(value.toString() +
                                        "---------------------------------------------------------");
                                  });
                                },
                                icon: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "حجز",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class TimeStartToEndWidget extends StatelessWidget {
  final String startToEndText;

  TimeStartToEndWidget({
    this.startToEndText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      startToEndText,
      style:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w400, wordSpacing: 5),
    );
  }
}
