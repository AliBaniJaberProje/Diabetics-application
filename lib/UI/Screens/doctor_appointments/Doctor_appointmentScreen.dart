

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Widgets/MainDrawer/maindrawer.dart';
import 'package:ali_muntaser_final_project/core/Model/EventStruct.dart';
import 'package:ali_muntaser_final_project/core/Providers/EventDateTimeProvier.dart';
import 'package:ali_muntaser_final_project/core/Providers/EventProvider.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/eventServesAPI.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/Providers/EventProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'EventTimeScreen.dart';

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

class DoctorAppointmentsScreen extends StatefulWidget {
  static final String routeName = "/DoctorAppointmentsScreen";

  @override
  State<StatefulWidget> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointmentsScreen> {
  bool _loadingMySelectedTime = true;
  bool _notSelectedTimeEvent = true;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  EventStruct eventSelected;
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {

      context.read<EventProvider>().clearDaysNamedAndDateTime();
      context.read<EventProvider>().getAllWeekDay();
      getEventSelectedInProfile().then((value) {
        setState(() {
          if (value.id == "-1") {
            this._notSelectedTimeEvent = true;
            this._loadingMySelectedTime = false;
          } else {
            eventSelected = value;
            this._notSelectedTimeEvent = false;
            this._loadingMySelectedTime = false;
          }
        });

        print(value.id + "ppppppppppppppppppppppppppppppppppppppppppppppppp");
      });

    });

    return null;
  }



  @override
  void initState() {
    context.read<EventProvider>().getAllWeekDay();
    getEventSelectedInProfile().then((value) {
      setState(() {
        if (value.id == "-1") {
          this._notSelectedTimeEvent = true;


        } else {
          eventSelected = value;
          this._notSelectedTimeEvent = false;

        }
        this._loadingMySelectedTime = false;
      });

      print(value.id + "ppppppppppppppppppppppppppppppppppppppppppppppppp");
    });
    super.initState();
  }

  List<Widget> screensEvent = [];
  String value = "";

  @override
  Widget build(BuildContext context) {
    var eventProviderWatch = context.watch<EventProvider>();
    return Scaffold(
        endDrawer:  MainDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "حجز موعد لزيارة الطبيب ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            eventProviderWatch.clearDaysNamedAndDateTime();
          },
        ),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        child: Column(
          children: [
            // ClipPath(
            //   clipper: WaveClipperTwo(),
            //   child: Container(
            //     height: 50,
            //     color: Colors.purple,
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),

            this._loadingMySelectedTime
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Container(
              padding: EdgeInsets.all(2),
              height: 170,
              width: double.infinity,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.purple, width: 2)),
              child: this._notSelectedTimeEvent
                  ? Center(
                child: Text(
                  "قم باختيار موعد مناسب من الايام المرفقة",
                  style:
                  TextStyle(fontSize: 20, color: Colors.purple),
                ),
              )
                  : Column(
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    this._notSelectedTimeEvent
                        ? "لم تقم باختيار موعد لمراجعة الطبيب"
                        : "قمت باختيار موعد لمراجعة الطبيب بتاريخ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    this._notSelectedTimeEvent
                        ? "لم تقم باختيار موعد لمراجعة الطبيب"
                        : eventSelected.getDateTimeString() +
                        " من " +
                        "\t\t ${eventSelected.getDateYMD()} \t\t",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    this._notSelectedTimeEvent
                        ? "لم تقم باختيار موعد لمراجعة الطبيب"
                        : eventSelected.getDateStarToEnd(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FlatButton.icon(
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.red,
                        ),
                        label: Text(
                          "الغاء الموعد",
                          style: TextStyle(
                              fontSize: 20, color: Colors.red),
                        ),
                        onPressed: () {


                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            backgroundColor: Colors.red,
                            title: "تأكيد الغاء الموعد ",
                            confirmBtnText: "نعم",
                            cancelBtnText: "  الغاء ",
                            confirmBtnTextStyle: TextStyle(
                                color: Colors.black54, fontSize: 15),
                            cancelBtnTextStyle: TextStyle(
                                color: Colors.black54, fontSize: 15),
                            confirmBtnColor: Colors.red,
                            onConfirmBtnTap: () async {


                              value=  await deleteEventById(
                                  eventSelected.id);
                              setState(() {
                                _notSelectedTimeEvent=true;
                              },);


                             // Navigator.pop(context);



                            },
                          );

                        },
                      )
                    ],
                  )
                ],
              ),
            ),

            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: eventProviderWatch.daysNamedAndDateTime.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1200),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: MyCardItem(
                            onPressed: () {
                              context.read<SlotDateTimeProvider>().dateTime =
                                  DateTime.parse(eventProviderWatch
                                      .daysNamedAndDateTime[index]["id"]);
                              context.read<SlotDateTimeProvider>().dateName =
                              eventProviderWatch.daysNamedAndDateTime[index]
                              ["date"];
                              Navigator.pushReplacementNamed(
                                  context, EventTimeScreen.routeName);
                              eventProviderWatch.clearDaysNamedAndDateTime();
                            },
                            colorContainer:
                            colorShadow[index % colorShadow.length],
                            colorBorder: color[index % color.length],
                            textInfoDate: eventProviderWatch
                                .daysNamedAndDateTime[index]["date"],
                            textInfoDayName: eventProviderWatch
                                .daysNamedAndDateTime[index]["DateTime"],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        onRefresh: refreshList,
      )
    );
  }
}

class MyCardItem extends StatelessWidget {
  final String textInfoDate;
  final String textInfoDayName;

  final Color colorContainer;
  final Color colorBorder;
  final Function onPressed;
  const MyCardItem(
      {this.textInfoDate,
      this.colorContainer,
      this.colorBorder,
      this.textInfoDayName,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 10,
        color: this.colorContainer,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: this.colorBorder,
            width: 2,
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                this.textInfoDayName,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
              Text(
                this.textInfoDate,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: this.onPressed,
    );
  }
}
