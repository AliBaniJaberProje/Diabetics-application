import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/MessagesProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/PatientServes.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
class NotificationWidget extends StatelessWidget {
  String mykey;
  String title;
  Timestamp timestamp;
  String imgurl;
  String body;
  String status;
  int numbernotification;
  bool isRequest;
  String newDoctorId;
  String newDoctorName;
  int isAccept;
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
    this.isRequest,
    this.newDoctorId,
    this.newDoctorName,
    this.isAccept
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
                padding: new EdgeInsets.all(8),
              //  margin: EdgeInsets.only(left: 8),
                width: 100,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),

                  border: Border.all(
                    color: Colors.purple,
                    width: 1
                  )

                ),
                child :Text(
                      getTimeSendFormat(timestamp),
                      style: new TextStyle(fontSize: 14.0, color: Colors.black),
                  textAlign: TextAlign.center,

                ),
              ),
             this.isRequest? Expanded(
                child:
                    Text(
                      body,
                      style: new TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.end,
                    ),



              ):this.isAccept==-1?Expanded(child: Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 //SizedBox(width: 5,),
                 IconButton(onPressed: ()async{
                   SharedPreferences prefs = await SharedPreferences.getInstance();
                   http.Response response=await http.patch("https://jaber-server.herokuapp.com/patient/updateCurantDoctor",body: {
                      "newDoctorId":newDoctorId
                    },headers: {"x-auth-token":prefs.getString('jwt')});

                   if(response.statusCode==200){
                     context.read<NotificationsProvider>().updateAcceptOrRegect("",this.mykey,1);

                     getIdAndIdCurrentDoctor().then((value) {

                       context.read<MessagesProvider>().setReceverId(value['patientUser']["currentDoctor"]);
                       context.read<MessagesProvider>().setSenderId(value['patientUser']["id"]);
                       context.read<MessagesProvider>().createColectionToThisDoctor(value['patientUser']["id"],value['patientUser']["currentDoctor"]);
                       context.read<MessagesProvider>().startListenLastAccessTimeDoctor();
                       FirebaseDatabase().reference()
                           .child('notifications').child("doctors")
                           .child(value['patientUser']["currentDoctor"]).child('notification').push()
                           .set({
                         "imgPatient":value['patientUser']['imgURL'],
                         "idPatient":value['patientUser']["id"],
                         "isSeen":false,
                         "value":"تم قبول الطلب من ${value['patientUser']['username']} ",
                         "patientName":value['patientUser']['username'],
                          "type":"request",
                         "timestamp":Timestamp.now().millisecondsSinceEpoch


                       });
                     });


                   }


                   print("yes");
                 },icon: Icon(Icons.check,size: 25,color: Colors.green,),),
                 IconButton(onPressed: (){
                   context.read<NotificationsProvider>().updateAcceptOrRegect("",this.mykey,0);
                   print("no");
                 },icon: Icon(Icons.close_sharp,size: 25,color: Colors.red,),),

                 Text("طلب اضافة من د.${this.newDoctorName}",style: new TextStyle(fontSize: 15, color: Colors.black),
                   textAlign: TextAlign.end,),
                 //SizedBox(width: 5,),

               ],
             ),):Expanded(child: Container(
               margin: EdgeInsets.symmetric(horizontal: 10),
               padding: EdgeInsets.symmetric(horizontal: 10),
               decoration: BoxDecoration(
                 color:  this.isAccept==0?Colors.red.shade100:Colors.green.shade100,
                 borderRadius: BorderRadius.circular(10)
               ),

               child: Text(this.isAccept==0?"تم رفض طلب ${this.newDoctorName}":"تم قبول  طلب ${this.newDoctorName}",style: new TextStyle(fontSize: 18, color: Colors.black,),
                 textAlign: TextAlign.end,),
             ),)
               ,
              Padding(
                padding: new EdgeInsets.only(left: 10.0, right: 10.0),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.purple,
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
                )
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
