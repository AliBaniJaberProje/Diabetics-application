import 'dart:async';

import 'package:ali_muntaser_final_project/UI/Screens/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';
import 'dart:ui' as ui;


class ResatPassword extends StatefulWidget {
  static String routeName="/ResatPassword";
  @override
  _ResatPasswordState createState() => _ResatPasswordState();
}

class _ResatPasswordState extends State<ResatPassword> {


  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == "12345") {
      return null;
    } else {
      return "The entered Otp is wrong";
    }
  }

  void moveToNextScreen(context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => SuccessfulOtpScreen()));
  }

  @override
  Widget build(BuildContext context) {
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
        subTitle: "ادخل الكود المرسل الى \n +919876543210",
        icon: Icon(Icons.phone),
      ),
    );
  }


}
class SuccessfulOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text("Otp verification successful",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),),
        ),
      ),
    );
  }
}