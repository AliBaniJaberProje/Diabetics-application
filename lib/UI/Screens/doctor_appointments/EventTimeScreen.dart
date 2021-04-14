import 'dart:convert';

import 'package:ali_muntaser_final_project/core/Providers/EventDateTimeProvier.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/eventServesAPI.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flushbar/flushbar.dart';
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
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _statusScreen=-2;
      context.read<SlotDateTimeProvider>().clearAllEvents();
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

    });

    return null;
  }



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

  void showSuccess(){
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.purple,
      content: Container(
        child: Text(
          " تم حجز الموعد بنجاح  ",
          textAlign: TextAlign.end,
        ),
      ),
    ),);
  }
  int result=0;

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
      body: RefreshIndicator(
        key: refreshKey,
        child: this._statusScreen < 0
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
                            onPressed: ()  {

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
                                    onConfirmBtnTap: ()  async {
                                      result = await setSelectedOfEventIForId(
                                          _eventProviderRead
                                              .listEventSloat[index].id);
                                      Navigator.pop(ctx);

                                      if (result == -1) {
                                        showResultOfBuckenig(context: context,ctx: ctx,color: Colors.red.shade300,text:" قم باعادة عملية الحجز " );
                                      } else if (result == 0) {
                                        showResultOfBuckenig(context: context,ctx: ctx,color: Colors.red.shade300,text:"الموعد تم اختياره من مريض اخر قم باعدت تحميل الصفحة" );
                                      } else if (result == 1) {
                                        showResultOfBuckenig(context: context,ctx: ctx,color: Colors.green.shade300,text:"تم الحجز مع الطبيب للزيارة بنجاح" );
                                        _eventProviderRead.deleteEventById(_eventProviderWatch.listEventSloat[index].id);

                                        print(
                                            "11111111111111111111111111111111111");
                                        //  showSuccess();
                                      }
                                    },
                                );

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

          onRefresh: refreshList,
      )
    );
  }

  void showResultOfBuckenig({BuildContext context, BuildContext ctx,Color color, String text}) {
    Flushbar(
      duration: Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: FlatButton(
        child: Icon(Icons.close),
        onPressed: () {

         //   Navigator.of(context).pop();

        },
      ),
      icon: Icon(Icons.error_outline),
      backgroundColor: color,
      message: "pppppp",
      messageText: Text(
           text,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
    ).show(ctx);
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
