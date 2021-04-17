import 'package:ali_muntaser_final_project/UI/Screens/login/loginScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/setting/verfiy.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class RestPasswordSecren1 extends StatefulWidget {

  static String routeName="/RestPasswordSecren1";
  @override
  _RestPasswordSecren1State createState() => _RestPasswordSecren1State();
}

class _RestPasswordSecren1State extends State<RestPasswordSecren1> {


  final _formKey = GlobalKey<FormState>();


  bool _obscurePassword;
  TextEditingController _idController;
  TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _obscurePassword = false;
    _phoneNumberController = TextEditingController();
    _idController=TextEditingController();
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
          "  استرجاع الحساب ",
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

          SizedBox(height: MediaQuery.of(context).size.height * .1,),

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
                            hintText: 'رقم الهوية',
                            fillColor: Colors.purple.shade100,
                            prefixIcon:  Icon(Icons.person,size: 30,),
                            filled: true,
                            isDense: true,

                          ),
                          textAlign: TextAlign.end,
                          cursorHeight: 30,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                          textDirection: ui.TextDirection.ltr,

                          controller: _idController,
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          validator: _vaildatId,
                        ),
                        SizedBox(height: 30,),


                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'اخر اربع ارقام من رقمك الهاتف',
                            fillColor: Colors.purple.shade100,
                            prefixIcon:  Icon(Icons.phone,size: 30,) ,
                            filled: true,
                            isDense: true,
                          ),
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                          textDirection: ui.TextDirection.ltr,
                          obscureText: _obscurePassword,
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          controller: _phoneNumberController,
                          validator: (val) => _validateRequired(val, _idController.text),
                        ),
                        SizedBox(height: 30,),

                        RaisedButton(
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(10),
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                            child: Text('ارسال كود',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                            onPressed:()=> _validateFormAndLogin(context)),

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

  String _vaildatId(String value) {
    if (value.length!=9) {
      return 'رقم الهوية خاطىْ';
    }

    return null;
  }


  void _validateFormAndLogin(BuildContext context) {
    var formState = _formKey.currentState;
    if (formState.validate()) {
      Navigator.pushReplacementNamed(context,ResatPassword.routeName,arguments: {"phone":_phoneNumberController.text});
      print('Form is valid');
    } else {

    }
  }

  String _validateRequired(String val1, val2) {
    if (val1.length!=4) {
      return  "ادخل اخر اربع ارقام من رقم الجوال ";
    }
    return null;
  }


}