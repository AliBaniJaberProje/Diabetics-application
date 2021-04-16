import 'dart:ui';

import 'package:ali_muntaser_final_project/UI/Screens/history/dose_history_dose.dart';
import 'package:ali_muntaser_final_project/UI/Screens/history/events_history.dart';
import 'package:ali_muntaser_final_project/UI/Screens/history/food_history.dart';
import 'package:ali_muntaser_final_project/UI/Screens/history/grp_history.dart';
import 'package:ali_muntaser_final_project/UI/Screens/history/number_steps_history.dart';
import 'package:ali_muntaser_final_project/UI/Screens/history/suqar_reding_history.dart';
import 'package:ali_muntaser_final_project/UI/Screens/setting/update_password.dart';
import 'package:ali_muntaser_final_project/UI/Widgets/MainDrawer/maindrawerController.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:provider/provider.dart';
import '../../Screens/login/loginScreen.dart';
class MainDrawer extends StatefulWidget {
  _MainDrawer createState() => _MainDrawer();
}

class _MainDrawer extends State<MainDrawer> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    final MainDrawerController _drawerController =
        new MainDrawerController(context);
    return Drawer(
      child: ListView(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 140,
              color: Colors.purple,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: _drawerController.goToMyPersonScreen,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          // "علي بني جابر",
                          context.watch<ProfileProvider>().getUserName(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          // margin: EdgeInsets.only(top: 0, left: 75, right: 75),
                          child: CircularProfileAvatar(
                            context.watch<ProfileProvider>().getImgUrl(),
                            // "https://play-images-prod-cms.tech.tvnz.co.nz/api/v1/web/image/content/dam/images/entertainment/shows/p/person-of-interest/personofinterest_coverimg.png.2017-03-08T11:21:33+13:00.jpg?width=960&height=540" //context.watch<ProfileProvider>().getImgUrl(),
                            //,
                            errorWidget: (context, url, error) => Container(
                              child: Icon(Icons.error),
                            ),
                            placeHolder: (context, url) => Container(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            ),
                            radius: 150,
                            backgroundColor: Colors.transparent,
                            borderWidth: 1,
                            // initialsText: Text(
                            //   "",
                            //   style: TextStyle(fontSize: 40, color: Colors.black),
                            // ),
                            borderColor: Colors.black87,
                            elevation: 2,

                            //showInitialTextAbovePicture: false,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            selectedTileColor: Colors.purple,
            focusColor: Colors.purple,
            trailing: Container(
              margin: EdgeInsets.all(0),
              child: Image.asset(
                "assets/images/icon_dose.png",
                color: Colors.white,
              ),
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            title: Text(
              "جرعاتي الطبية",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
            leading: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.lightBlueAccent,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, DoseHistoryDose.routeName);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            selectedTileColor: Colors.purple,
            focusColor: Colors.purple,
            trailing: Container(
              margin: EdgeInsets.all(0),
              child: Icon(
                Icons.wallet_membership,
                color: Colors.white,
              ),
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            title: Text(
              "فحوصات السكري",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
            leading: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.lightGreen,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, SuqarRedingHistory.routName);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            selectedTileColor: Colors.purple,
            focusColor: Colors.purple,
            trailing: Container(
              margin: EdgeInsets.all(0),
              child: Icon(
                Icons.directions_run_rounded,
                color: Colors.white,
              ),
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.purpleAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            title: Text(
              "النشاط الرياضي",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
            leading: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.purpleAccent,
            ),
            onTap: () {

              Navigator.pushReplacementNamed(context, NumberStepsHistory.routeName);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            trailing: Container(
              margin: EdgeInsets.all(0),
              child: Icon(
                Icons.fastfood_outlined,
                color: Colors.white,
              ),
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.tealAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            title: Text(
              "وجباتي الغذائية",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
            leading: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.tealAccent,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, FoodHistory.routName);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            trailing: Container(
              margin: EdgeInsets.all(0),
              child: Icon(
                Icons.access_time_rounded,
                color: Colors.white,
              ),
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            title: Text(
              "مواعيدي الطبية",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
            leading: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.deepPurple,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, EventsHistory.routeName);

            },
          ),
          SizedBox(
            height: 10,
          ),


          ListTile(
            selectedTileColor: Colors.purple,
            focusColor: Colors.purple,
            trailing: Container(
              margin: EdgeInsets.all(0),
              child: Icon(
                Icons.thermostat_outlined,
                color: Colors.white,
              ),
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            title: Text(
              "السكري التراكمي",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
            leading: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.amberAccent,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, GrpHistory.routeName);
//

            },
          ),
          SizedBox(
            height: 10,
          ),
          ExpansionTile(
            backgroundColor: Colors.black12,
            title: Text(
              "الاعدادات",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
            trailing: Container(
              margin: EdgeInsets.all(0),
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            leading: Icon(
              Icons.arrow_drop_down_outlined,
              size: 20,
              color: Colors.black87,
            ),
            children: [
              SizedBox(
                height: 10,
              ),
              ListTile(
                selectedTileColor: Colors.purple,
                focusColor: Colors.purple,
                trailing: Container(
                  margin: EdgeInsets.all(0),
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  width: 30,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                title: Text(
                  "تعديل بيانات تسجيل الدخول",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.end,
                ),
                leading: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 15,
                  color: Colors.lightBlueAccent,
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, UpdatePassword.routeName);
                  //UpdatePassword
                },
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                selectedTileColor: Colors.purple,
                focusColor: Colors.purple,
                trailing: Container(
                  margin: EdgeInsets.all(0),
                  child: Icon(
                    Icons.online_prediction,
                    color: Colors.white,
                  ),
                  width: 30,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                title: Text(
                  "تفعيل الاتصال",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.end,
                ),
                leading: GFToggle(
                  disabledThumbColor: Colors.grey,
                  disabledTrackColor: Colors.grey,
                  enabledTrackColor: Colors.purple,
                  enabledThumbColor: Colors.grey,
                  onChanged: (value) {
                    print("VALUE : $value");
                    setState(() {
                      status = value;
                    });
                  },
                  value: status,
                  type: GFToggleType.android,
                ),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            trailing: Container(
              margin: EdgeInsets.all(0),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            title: Text(
              "تسجيل الخروج",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.end,
            ),
            leading: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.redAccent,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
