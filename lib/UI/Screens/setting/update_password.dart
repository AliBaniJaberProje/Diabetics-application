import 'dart:convert';

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/login/loginScreen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePassword extends StatefulWidget {
  static String routeName = "/UpdatePassword";
  UpdatePassword({Key key}) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  var idController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool toggle1=false;
  bool toggle2=false;
  bool toggle3=false;
  void toggleFunction1(){
    setState(() {
      toggle1=!toggle1;
    });
  }

  void toggleFunction2(){
    setState(() {
      toggle2=!toggle2;
    });
  }

  void toggleFunction3(){
    setState(() {
      toggle3=!toggle3;
    });
  }

  bool _obscurePassword;
  TextEditingController _prevesPassController;
  TextEditingController _newePass1;
  TextEditingController _newPass2;
  bool loading=false;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _prevesPassController = TextEditingController();
    _newPass2 = TextEditingController();
    _newePass1 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        title: Text(
          "  تغير كلمة السر ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textDirection: ui.TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 80,
              color: Colors.purple,
              child: Center(),
            ),
          ),
          Container(
            height: 500,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'كلمة السر السابقة',
                                fillColor: Colors.purple.shade100,

                                filled: true,
                                isDense: true,
                              ),
                              cursorHeight: 30,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: ui.TextDirection.ltr,
                              textAlign: TextAlign.end,
                              controller: _prevesPassController,
                              keyboardType: TextInputType.visiblePassword,
                              autocorrect: false,
                              obscureText: !toggle1,
                              validator: _validPrevesPass,
                            ),
                            IconButton(
                              onPressed: toggleFunction1,
                              icon: Icon(toggle1?Icons.visibility:Icons.visibility_off),
                              iconSize: 22,
                              splashRadius: 10,
                            )
                          ],
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        Stack(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'كلمة السر الجديدة',
                                fillColor: Colors.purple.shade100,

                                filled: true,
                                isDense: true,
                              ),
                              cursorHeight: 30,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: ui.TextDirection.ltr,
                              textAlign: TextAlign.end,
                              controller: _newePass1,
                              keyboardType: TextInputType.visiblePassword,
                              autocorrect: false,
                              obscureText: !toggle2,
                              validator: _validatePass1,
                            ),
                            IconButton(
                              onPressed: toggleFunction2,
                              icon: Icon(toggle2?Icons.visibility:Icons.visibility_off),
                              iconSize: 22,
                              splashRadius: 10,
                            )
                          ],
                        ),


                        SizedBox(
                          height: 30,
                        ),

                        Stack(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'كلمة السر الجديدة',
                                fillColor: Colors.purple.shade100,

                                filled: true,
                                isDense: true,
                              ),
                              cursorHeight: 30,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textDirection: ui.TextDirection.ltr,
                              textAlign: TextAlign.end,
                              controller: _newPass2,
                              keyboardType: TextInputType.visiblePassword,
                              autocorrect: false,
                              obscureText: !toggle3,
                              validator:(val)=>_validateRequired(_newePass1.text,val),
                            ),
                            IconButton(
                              onPressed: toggleFunction3,
                              icon: Icon(toggle3?Icons.visibility:Icons.visibility_off),
                              iconSize: 22,
                              splashRadius: 10,
                            )
                          ],
                        ),



                        SizedBox(
                          height: 30,
                        ),
                       loading?Center(child: CircularProgressIndicator(),): RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0)),
                            child: Text(
                              '  تغير كلمة السر',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            onPressed: _validateFormAndLogin),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomSheet: ClipPath(
        clipper: WaveClipperTwo(reverse: true, flip: true),
        child: Container(
          height: 70,
          color: Colors.purple,
          child: Center(),
        ),
      ),
    );
  }
  Center buildCenterFlushbar(String message,Color color) {
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
      backgroundColor: color,
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


  String _validatePass1(String value) {
    if (value == null || value == '') {
      return 'يجب ادخال كلمة المرور';
    }

    if (value.length < 8) {
      return 'يجب ان تكون كلمة السر من 8';
    }
    return null;
  }

  String _validPrevesPass(String value) {
    if (value == null || value == '') {
      return 'مطلوب كلمة السر السابقة';
    } else if (value.length < 8) {
      return "يجب ادخال كلمة المرور الصحيحة";
    } else {}

    return null;
  }

  void _validateFormAndLogin() async{
    var formState = _formKey.currentState;

    if (formState.validate()) {
      setState(() {
        loading=true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      http.Response response =await http.patch("https://jaber-server.herokuapp.com/password/forgetPassword",headers: {'x-auth-token': prefs.get('jwt')},body: {
        "password":_prevesPassController.text,
         "newPassword":_newPass2.text
      });

    print(jsonDecode(response.body));
    buildCenterFlushbar(jsonDecode(response.body)["msg"],response.statusCode==200?Colors.green.shade300:Colors.red.shade300);
    if(response.statusCode==200){
      setState(() {
        loading=false;
      });
      prefs.remove("id");
      prefs.remove("password");
      Navigator.pushReplacementNamed(
          context, LoginScreen.routeName);
    }

      print('Form is valid');
    } else {}
  }

  String _validateRequired(String val1, val2) {
    if (val1 != val2) {
      return "كلمة المرور مختلفة";
    }
    return null;
  }
}
