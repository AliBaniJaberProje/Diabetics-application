import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'dart:ui' as ui;

import 'food_history.dart';

class EventsHistory extends StatefulWidget {
  static String routeName = "/EventsHistory";
  EventsHistory({Key key}) : super(key: key);

  @override
  _EventsHistoryState createState() => _EventsHistoryState();
}

class _EventsHistoryState extends State<EventsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        title: Text(
          "مواعيدي الطبية ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textDirection: ui.TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple, width: 3)),
            child: Center(
              child: Text(
                "المواعيد الطبية خلال شهر 1-1-2021",
                style: TextStyle(
                  fontSize: 18,
                ),
                textDirection: ui.TextDirection.rtl,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (ctx, index) {
                return CardEventHistory(
                  border: Colors.amber,
                  eventTime: "2021-1-19 \t\t",
                  idEvent: "111478",
                  imgDoctor:
                      "https://scontent.fjrs13-1.fna.fbcdn.net/v/t1.6435-9/117613790_294791471973076_6768546932360132835_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=QYLTISzFCvkAX8G8B08&_nc_ht=scontent.fjrs13-1.fna&oh=08b2f69e606355e0399822ac358883cb&oe=609FEB92",
                  nameDocotr: "احمد بني جابر",
                  note: "يبسلللللللل بليايب يبلايلب يبلايبلا يبلايب يبلايب ",
                  shadoColro: Colors.amber.shade100,
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
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


              print(date.month);

            }
          });

        },
      ),
    );
  }
}

class CardEventHistory extends StatelessWidget {
  final String idEvent;
  final String eventTime;
  final String imgDoctor;
  final String nameDocotr;
  final String note;
  final Color border;
  final Color shadoColro;

  CardEventHistory(
      {this.idEvent,
      this.eventTime,
      this.imgDoctor,
      this.nameDocotr,
      this.note,
      this.border,
      this.shadoColro});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: EdgeInsets.all(10),
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(color: this.border, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "الموعد رقم : ${this.idEvent}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textDirection: ui.TextDirection.rtl,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    color: shadoColro,
                    height: 50,
                    width: 200,
                    child: Center(
                      child: Text(
                        " تاريخ الموعد ${this.eventTime}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        textDirection: ui.TextDirection.rtl,
                      ),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: this.border,
                        child: CircleAvatar(
                          radius: 39,
                          backgroundImage: NetworkImage(
                            this.imgDoctor,
                            //
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "د. ${this.nameDocotr}  ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textDirection: ui.TextDirection.rtl,
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: this.border,
              thickness: 2,
            ),
            Center(
              child: Text(
                "ملاحظات الطبيب",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: this.border),
              ),
            ),
            Center(
              child: Text(
                this.note
                //"jklfdg djolfkgh jdkl;fhg ol;dsjhfg ;sjfdgh l;dsfghjk ;sdfgkhj ;sdfggjkg ;sdffglkhj s;dfghjk sdlgfhjk sdfjkhg s;dfglhj ;sdfhg sl;dfhgj ;ldfkjgh d;fgklhj d;fghkj ;dfkghj, تنميبل تنمكسيب مسيبات منسيبتال سميكنبتلا سميبلات سنميكبتال مسينبتلالا"
                ,
                textDirection: ui.TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
