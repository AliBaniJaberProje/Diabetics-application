import 'dart:async';

import 'package:ali_muntaser_final_project/UI/Screens/login/loginScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/setting/rest_password_secren1.dart';
import 'package:ali_muntaser_final_project/UI/Screens/setting/update_forget_passward.dart';
import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';
import 'dart:ui' as ui;


class ResatPassword extends StatefulWidget {
  static String routeName="/ResatPassword";
  @override
  _ResatPasswordState createState() => _ResatPasswordState();
}

class _ResatPasswordState extends State<ResatPassword> {
 int cont=0;

  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    print("wwwwwwwwwwwwwwwwwwwwww");
    print(args.toString());
    if (otp == args["code"]) {
      Navigator.pushReplacementNamed(context,UpdateForgetPassward.routeName);
      return null;
    } else {
      cont++;
      if(cont==3){
        Navigator.pushReplacementNamed(context,RestPasswordSecren1.routeName);
      }
      return "الكود خاطىْ";
    }
  }

  void moveToNextScreen(context) {
    Navigator.pushReplacementNamed(context,UpdateForgetPassward.routeName,arguments: {"phone":args["phone"],"id":args["id"],"code":args["code"]});
  }
 var  args ;
  @override
  Widget build(BuildContext context) {
      args =
    ModalRoute.of(context).settings.arguments as Map<String ,String>;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
        ),
        title: Text(
          " استرجاع كلمة المرور ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textDirection: ui.TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: OtpScreen.withGradientBackground(
        topColor: Colors.purple.shade100,
        bottomColor: Colors.purple,
        otpLength: 5,
        validateOtp: validateOtp,
        routeCallback: moveToNextScreen,
        themeColor: Colors.white,
        titleColor: Colors.white,
        title: "مصداقة الحساب ",
        subTitle: "ادخل الكود المرسل الى \n ${args["phone"]}",
        icon: Icon(Icons.phone),
      ),
    );
  }

}
