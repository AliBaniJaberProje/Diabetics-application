import 'package:ali_muntaser_final_project/UI/Screens/MyDoseScreen/MyDoseScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/StepCount/StepScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/daily_reading_screen/dailyReadingScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/doctor_appointments/Doctor_appointmentScreen.dart';
import 'package:ali_muntaser_final_project/core/Constant/HomePageConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "../../todoy's meals/Today's_MealsScreen.dart";

class HeaderContainer extends StatelessWidget {
  final bool showname;

  const HeaderContainer({@required this.showname});
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
                      Text(
                        "د أسامة جميل ",
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
              } else if (data['title'] == MainFeture[3]['title']) {
                print("وجبتي هذا اليوم");
                Navigator.pushReplacementNamed(context, TodayMeals.routeName);
              } else if (data['title'] == MainFeture[4]['title']) {
                //  Navigator.pushReplacementNamed(context, TestScreen.routName);
                Navigator.pushReplacementNamed(context, DoctorAppointmentsScreen.routeName);
                print('حجز موعد');
              } else if (data['title'] == MainFeture[5]['title']) {
                Navigator.pushReplacementNamed(context, NumberOfStep.routeName);

                print("عدد الخطوات ");
              } else if (data['title'] == MainFeture[6]['title']) {
                print('معلومات ونصائح ');


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

class TipOfDayContainer extends StatelessWidget {
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
          padding: EdgeInsets.only(right: 7),
          width: MediaQuery.of(ctx).size.width,
          height: 100,
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
                "الوزن الصحي يمنحك القدرة على معواجهة اي مرض بكفاء أكبر . ويساعدك في التحكم في نسبة السكر بالدم ",
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                    color: Colors.black87
                  //fontStyle: FontStyle.italic
                ),
                maxLines: 2,
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
          
          maxCrossAxisExtent: 400,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
      ),
    );
  }
}

class BodyHonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (ctx, constraint) => Column(
          children: [
            HeaderContainer(
              showname: true,
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
