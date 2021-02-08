import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/LogInProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/NotificationProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/firebase/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'Widgets/HeaderLogin.dart';

class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
//-------------------------data-------------------------------------------------
  var idController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _userId = "";
  String _password = "";
  UsersFirebase usersFirebase = new UsersFirebase();

  DateTime convertTimeStampToDateTime(Timestamp time) => time.toDate();

  //------------------------------ login function ------------------------------
  Future sleep2() {
    return new Future.delayed(const Duration(seconds: 1), () => "2");
  }

  bool isValidUserId() {
    if (_userId.isEmpty || _userId.length < 9) return false;
    return true;
  }

  bool isValidPassword() {
    if (_password.isEmpty || _password.length < 5) return false;
    return true;
  }

  void errorLogin(String message) {
    buildCenterFlushbar(message);
    context.read<LoginProvider>().reastLodingLoginStatus();
  }

  void _trySubmit() async {
    // fbm.getToken().then((value) => print(value));
    var _loginProvider = context.read<LoginProvider>();
    _loginProvider.setLodingLoginStatus();
    _formKey.currentState.save();
    FocusScope.of(context).unfocus();

    if (isValidUserId() && isValidPassword()) {
      _formKey.currentState.save();
      var resultLogin = await usersFirebase.isAuthorized(_userId, _password);
      if (resultLogin["status"] == "yes") {
        print("yes");
        Patient userLogedin = resultLogin["patient"];
        context.read<LoginProvider>().reastLodingLoginStatus();
        var _profileProvider = context.read<ProfileProvider>();
        _profileProvider.setUserName(userLogedin.username);
        _profileProvider.setLength(userLogedin.length);
        _profileProvider.setId(userLogedin.id);
        _profileProvider.setWeight(userLogedin.weight);
        _profileProvider.setdateBirth(convertTimeStampToDateTime(userLogedin.dateBirth));
        _profileProvider.setLocation(userLogedin.location);
        _profileProvider.setImgUrl(userLogedin.imgurl);
        _profileProvider.setPhoneNumber(userLogedin.phoneNumber);
        _profileProvider.setdiabetesType(userLogedin.diabtesType);


        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        errorLogin("لا يوجد مستخدم بالبيانات المدخلة");
        print("no");
      }
    } else {
      errorLogin("تاكد من ادخال البيانات ");
      sleep2().then((value) {
        idController.clear();
        passwordController.clear();
        context.read<LoginProvider>().reastLodingLoginStatus();
      });
    }
  }

//------------------------------------error widgit -----------------------------
  Center buildCenterFlushbar(String message) {
    Flushbar(
      duration: Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.BOTTOM,
      mainButton: FlatButton(
        child: Icon(Icons.close),
        onPressed: () {
          setState(() {
            Navigator.of(context).pop();
          });
        },
      ),
      icon: Icon(Icons.error_outline),
      backgroundColor: Colors.redAccent,
      message: "الرجاء المحاولة مرة اخرى ",
      messageText: Text(
        message,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
    ).show(context);
  }

//----------------------------build LoginFormWidge -----------------------------
  @override
  Widget build(BuildContext context) {
    var _loginProvider = context.read<LoginProvider>();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 0,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: Colors.white,
                          height: 70,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(

                                    key: ValueKey('id_user'),
                                    cursorColor: Colors.deepPurple,
                                    cursorHeight: 25,
                                    onSaved: (val) => _userId = val,
                                    keyboardType: TextInputType.datetime,
                                    style: TextStyle(fontSize: 25),
                                    controller: idController,
                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      border: InputBorder.none,
                                      hintText: "رقم الهوية",
                                      hintStyle: TextStyle(
                                        color:
                                            Colors.purpleAccent.withOpacity(.3),
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.purple,
                                  width: 40,
                                  height: 70,
                                  child:
                                      Icon(Icons.person, color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white,
                        height: 70,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(

                                      key: ValueKey('password'),
                                      onSaved: (val) => _password = val,
                                      cursorColor: Colors.deepPurple,

                                      cursorHeight: 25,
                                      style: TextStyle(fontSize: 25),
                                      obscureText: !context
                                          .watch<LoginProvider>()
                                          .visibilStatePassword(),
                                      textAlign: TextAlign.end,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[300],
                                        border: InputBorder.none,
                                        hintText: "كلمة المرور",
                                        hintStyle: TextStyle(
                                          color: Colors.purpleAccent
                                              .withOpacity(.3),
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.purple,
                                    width: 40,
                                    height: 70,
                                    child:
                                        Icon(Icons.lock, color: Colors.white),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: IconButton(
                                  onPressed: () {
                                    _loginProvider.toggleVisibilStatePassword();
                                  },
                                  icon: Icon(
                                    context
                                            .watch<LoginProvider>()
                                            .visibilStatePassword()
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.purple,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            context.watch<LoginProvider>().lodingLoginStatus()
                ? CircularProgressIndicator()
                : Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.purple.withOpacity(.6),
                        ],
                      ),
                    ),
                    child: InkWell(
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        _trySubmit();
                        _loginProvider.setLodingLoginStatus();
                      },
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Text(
              "هل نسيت كلمة السر ؟",
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  static final String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderLogin(),
              LoginFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
