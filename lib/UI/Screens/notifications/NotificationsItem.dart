import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatelessWidget {
  String mykey;
  String title;
  Timestamp timestamp;
  String imgurl;
  String body;
  String status;
  int numbernotification;
  DateTime convertTimeStampToDateTime(Timestamp time) => time.toDate();

  String getTimeSendFormat(Timestamp time) {
    DateTime t = time.toDate();
    if (DateTime.now().year == t.year &&
        DateTime.now().month == t.month &&
        DateTime.now().day == t.day) {
      return new DateFormat.Hms().format(t).toString();
    } else {
      return new DateFormat.yMMMd().format(t).toString();
    }
  }

  NotificationWidget({
    this.mykey,
    this.title,
    this.imgurl,
    this.timestamp,
    this.body,
    this.status,
  });

  Widget build(BuildContext context) {
    Color unseenColor = Colors.purpleAccent.withOpacity(.2);
    Color seenColor = Colors.white;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 70,
          decoration: new BoxDecoration(
            color: this.status == "seen" ? seenColor : unseenColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: new EdgeInsets.only(left: 10.0, right: 10.0),

                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(.3),

                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      getTimeSendFormat(timestamp),
                      style: new TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      body,
                      style: new TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(left: 10.0, right: 10.0),
                child: CircularProfileAvatar(
                  this.imgurl,
                  radius: 25,
                  placeHolder: (context, url) => Container(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.purple,
          height: 1,
        ),
      ],
    );
  }
}
