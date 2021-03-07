import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/EventDateTimeProvier.dart';
import 'package:ali_muntaser_final_project/core/Providers/EventProvider.dart';
import '../../../core/Providers/EventProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'EventTimeScreen.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  static final String routeName = "/DoctorAppointmentsScreen";

  @override
  State<StatefulWidget> createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointmentsScreen> {
  bool loadingMySelectedTime = true;
  @override
  void initState() {
    context.read<EventProvider>().getAllWeekDay();
    super.initState();
  }

  List<Widget> screensEvent = [];

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
  @override
  Widget build(BuildContext context) {
    var eventProviderWatch = context.watch<EventProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "الايام المسموحة لزيارة الطبيب ",
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
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            eventProviderWatch.clearDaysNamedAndDateTime();
          },
        ),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 50,
              color: Colors.purple,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: eventProviderWatch.daysNamedAndDateTime.length,
              itemBuilder: (ctx, index) {
                return MyCardItem(
                  onPressed: () {

                    context.read<SlotDateTimeProvider>().dateTime = DateTime.parse(
                        eventProviderWatch.daysNamedAndDateTime[index]["id"]);
                    context.read<SlotDateTimeProvider>().dateName=eventProviderWatch.daysNamedAndDateTime[index]["date"];
                    Navigator.pushReplacementNamed(
                        context, EventTimeScreen.routeName);
                    eventProviderWatch.clearDaysNamedAndDateTime();

                  },
                  colorContainer: colorShadow[index % this.colorShadow.length],
                  colorBorder: color[index % this.color.length],
                  textInfoDate: eventProviderWatch.daysNamedAndDateTime[index]
                      ["date"],
                  textInfoDayName: eventProviderWatch
                      .daysNamedAndDateTime[index]["DateTime"],
                );
              },
              // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //   maxCrossAxisExtent: 200,
              //   childAspectRatio: 2 / 1,
              //   crossAxisSpacing: 15,
              //   mainAxisSpacing: 15,
              // ),
             // padding: EdgeInsets.all(30),
            ),
          )
        ],
      ),
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
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

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
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),

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
