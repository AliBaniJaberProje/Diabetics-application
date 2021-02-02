import 'package:ali_muntaser_final_project/UI/Screens/MyDoseScreen/MyDoseScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/ProfilePersonly/ProfilePersonly.dart';
import 'package:ali_muntaser_final_project/UI/Screens/chat/MsgChat/msgChatScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/daily_reading_screen/dailyReadingScreen.dart';
import 'package:ali_muntaser_final_project/core/Constant/HomePageConstant.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  final bool showname;

  const HeaderContainer({@required this.showname});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child:showname? Column(
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
        ):Column(),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4000),
            bottomRight: Radius.circular(4000),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.5),
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
            onTap: () {
              if (data['title'] == MainFeture[0]['title']) {
                print("الفرأت اليومية ");

                Navigator.pushReplacementNamed(
                    context, DailyReadingScreen.routeName);
              } else if (data["title"] == MainFeture[1]['title']) {
                 Navigator.pushReplacementNamed(context, MyDoseScreen.routeName);

                print("دليل جرعاتي ");
              } else if (data['title'] == MainFeture[2]['title']) {
                 Navigator.pushReplacementNamed(context, ChatScreen.routeName);
                print("هل هذا صحي لي ؟");
              } else if (data['title'] == MainFeture[3]['title']) {
                print("وجبتي هذا اليوم");
              } else if (data['title'] == MainFeture[4]['title']) {
                print('حجز موعد');
              } else if (data['title'] == MainFeture[5]['title']) {
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
        color: Colors.purpleAccent.withOpacity(.5),
        elevation: 5,
              child: Container(
          
          margin: EdgeInsets.only(left: 10, right: 10),
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
                ),
              ),
              Text(
                "الوزن الصحي يمنحك القدرة على معواجهة اي مرض بكفاء أكبر . ويساعدك في التحكم في نسبة السكر بالدم ",
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic
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
        children: MainFeture.map((e) => MyGridTitle(e)).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}

class BodyHonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.grey,
      child: LayoutBuilder(
        builder: (ctx, constraint) => Column(
          children: [
            HeaderContainer(showname: true,),
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
