import 'dart:convert';

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UpdatePassword extends StatefulWidget {
  static String routeName="/UpdatePassword";
  UpdatePassword({Key key}) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  var idController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _userId;
  String _password;

  bool _obscurePassword;
  bool _autovalidate;
  TextEditingController _prevesPassController;
  TextEditingController _newePass1;
  TextEditingController _newPass2;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _autovalidate = false;
    _prevesPassController = TextEditingController();
    _newPass2 = TextEditingController();
    _newePass1=TextEditingController();
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

                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'كلمة السر السابقة',

                            fillColor: Colors.purple.shade100,
                            prefixIcon:  Icon(Icons.person,size: 30,) ,
                            filled: true,
                            isDense: true,

                          ),
                          cursorHeight: 30,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                          textDirection: ui.TextDirection.ltr,
                          textAlign: TextAlign.end,
                          controller: _prevesPassController,
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,


                          validator: _validPrevesPass,
                        ),
                        SizedBox(height: 30,),

                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'كلمة السر الجديدة',
                            fillColor: Colors.purple.shade100,
                            prefixIcon:  Icon(Icons.visibility_off,size: 30,) ,
                            filled: true,
                            isDense: true,

                          ),
                          textAlign: TextAlign.end,
                          cursorHeight: 30,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                          textDirection: ui.TextDirection.ltr,

                          controller: _newePass1,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: _validatePass1,
                        ),
                        SizedBox(height: 30,),


                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'تاكيد كلمة السر',
                            fillColor: Colors.purple.shade100,
                            prefixIcon:  Icon(Icons.visibility_off,size: 30,) ,
                            filled: true,
                            isDense: true,
                          ),
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                          textDirection: ui.TextDirection.ltr,
                          obscureText: _obscurePassword,
                          autocorrect: false,
                          controller: _newPass2,
                          validator: (val) => _validateRequired(val, _newePass1.text),
                        ),
                        SizedBox(height: 30,),

                        RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                            child: Text('  تغير كلمة السر',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
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
        clipper: WaveClipperTwo(reverse: true,flip: true),
        child: Container(
          height: 70,
          color: Colors.purple,
          child: Center(),
        ),
      ),
    );
  }

  String _validatePass1(String value) {
    if (value == null || value == '') {
      return 'يجب ادخال كلمة المرور';
    }


    if (value.length<8) {
      return 'يجب ان تكون كلمة السر من 8';
    }
    return null;
  }



  String _validPrevesPass(String value) {
    if (value == null || value == '') {
      return 'ودي ركويست وافحص';
    }
    else if(value.length <8){
      return "يجب ادخال كلمة المرور الصحيحة";
    }
    else{

      SharedPreferences.getInstance().then((prefs){


      return   http.post("http://192.168.0.112:3000/patient/checkPrevious_passwordIsVaild",headers: {"x-auth-token":prefs.getString('jwt')},body: {
            "password":value
        }).then((result){
          // print(jsonDecode(result.body));
           if(jsonDecode(result.body)["msg"]=="yes"){

             return "";
           }else{

             return "كلمة المرور السابقة خاطئة";
           }
         });

    });


    }


    return null;
  }

  void _validateFormAndLogin() {
    var formState = _formKey.currentState;
    if (formState.validate()) {
      print('Form is valid');
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
  String _validateRequired(String val1, val2) {
    if (val1 != val2) {
      return  "كلمة المرور مختلفة";
    }
    return null;
  }

}