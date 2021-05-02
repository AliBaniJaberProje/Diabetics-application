import 'package:ali_muntaser_final_project/UI/Screens/FoodScreen/food_screen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/MyDoseScreen/MyDoseScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/StepCount/StepScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/daily_reading_screen/dailyReadingScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/doctor_appointments/Doctor_appointmentScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/information/informationScreen.dart';
import 'package:ali_muntaser_final_project/core/Constant/HomePageConstant.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Screens/grp_reading/grp_reading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HeaderContainer extends StatelessWidget {
  final bool showname;
  final String doctorName;

  const HeaderContainer({@required this.showname, this.doctorName});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: showname
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "أتمنى ان تكون بصحة جيدة ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      context.watch<ProfileProvider>().loadingNameInHome?CircularProgressIndicator() :Text(
                        " د. ${doctorName}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ],
              )
            : Column(),
        width: double.infinity,
        height: showname ? 100 : 40,
        decoration: BoxDecoration(
          color: showname ? Colors.white : Colors.purple,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4000),
            bottomRight: Radius.circular(4000),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 0,
              offset: Offset(0, 5),
            ),
          ],
        ),
      ),
      //color: Colors.grey,
    );
  }
}

class MyGridTitle extends StatelessWidget {
  final Map<String, String> data;

  MyGridTitle(this.data);

  @override
  Widget build(BuildContext context) {
    //_bloc.add(HomePageEvent());

    return Container(
      decoration: BoxDecoration(),
      child: ClipRRect(
        child: GridTile(
          child: GestureDetector(
            onTap: () async {
              if (data['title'] == MainFeture[0]['title']) {
                print("الفرأت اليومية ");

                Navigator.pushReplacementNamed(
                    context, DailyReadingScreen.routeName);
              } else if (data["title"] == MainFeture[1]['title']) {
                Navigator.pushReplacementNamed(context, MyDoseScreen.routeName);

                print("دليل جرعاتي ");
              } else if (data['title'] == MainFeture[2]['title']) {
                // var res= await http.get("http://192.168.0.111:3000");
                // int x=55;
                // print(res);
                print("هل هذا صحي لي ؟");
                Navigator.pushReplacementNamed(context, FoodScreen2.routeName);

              } else if (data['title'] == MainFeture[3]['title']) {

                print("وجبتي هذا اليوم");
                Navigator.pushReplacementNamed(context, DoctorAppointmentsScreen.routeName);
              } else if (data['title'] == MainFeture[4]['title']) {
                //  Navigator.pushReplacementNamed(context, TestScreen.routName);
                Navigator.pushReplacementNamed(context, NumberOfStep.routeName);
                print('حجز موعد');
              } else if (data['title'] == MainFeture[5]['title']) {
                Navigator.pushReplacementNamed(context, InformationScreen.routeName);

                // Navigator.pushReplacementNamed(context, GrpReading.routeName);

                print("عدد الخطوات ");
              } else if (data['title'] == MainFeture[6]['title']) {
                print('معلومات ونصائح ');
                Navigator.pushReplacementNamed(context, InformationScreen.routeName);

                //  Navigator.pushReplacementNamed(context, MyPersonScreen.routeName);
              }
            },
            child: Image.asset(
              data['image'],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}




class TipOfDayContainer extends StatefulWidget {
  @override
  _TipOfDayContainerState createState() => _TipOfDayContainerState();
}

class _TipOfDayContainerState extends State<TipOfDayContainer> {
  String tip="الوزن الصحي يمنحك القدرة على معواجهة اي مرض بكفاء أكبر . ويساعدك في التحكم في نسبة السكر بالدم ";
  @override
  void initState() {
    http.get("https://jaber-server.herokuapp.com/information/patient/getTip").then((val){
      if(val.statusCode==200) {
         tip = jsonDecode(val.body)["data"];
      }
      },);



        super.initState();
        }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, c) => Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color:Colors.purple.shade500,
            width: 1,
          ),


        ),
        color:Colors.purple.shade200,
        elevation: 5,
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          padding: EdgeInsets.all( 3),
          width: MediaQuery.of(ctx).size.width,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                " نصيحة اليوم",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black87
                ),
              ),
              Text(
                tip,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                  //fontStyle: FontStyle.italic
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }


}




class MainFituerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        padding: EdgeInsets.all(10),
        children: MainFeture.map((e) => MyGridTitle(e)).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          
          maxCrossAxisExtent: MediaQuery.of(context).size.width * .6,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
      ),
    );
  }
}

class BodyHonePage extends StatelessWidget {
  final String doctorName;

  const BodyHonePage({ this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (ctx, constraint) => Column(
          children: [
            HeaderContainer(
              showname: true,
              doctorName: doctorName,

            ),
            SizedBox(
              height: constraint.maxHeight * .03,
            ),
            TipOfDayContainer(),
            SizedBox(
              height: constraint.maxHeight * .02,
            ),
            MainFituerContainer(),
          ],
        ),
      ),
    );
  }
}
