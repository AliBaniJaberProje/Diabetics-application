import 'package:ali_muntaser_final_project/UI/Screens/login/loginScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/setting/rest_password_secren1.dart';
import 'package:ali_muntaser_final_project/UI/Screens/setting/verfiy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'dart:ui' as ui;

class UpdateForgetPassward extends StatefulWidget {
  static String routeName="/UpdateForgetPassward";

  UpdateForgetPassward({Key key}) : super(key: key);

  @override
  _UpdateForgetPasswardState createState() => _UpdateForgetPasswardState();
}

class _UpdateForgetPasswardState extends State<UpdateForgetPassward> {
  var idController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  bool _obscurePassword;
  TextEditingController _prevesPassController;
  TextEditingController _newePass1;
  TextEditingController _newPass2;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _prevesPassController = TextEditingController();
    _newPass2 = TextEditingController();
    _newePass1=TextEditingController();
  }





  @override
  Widget build(BuildContext context) {
   final args =
    ModalRoute.of(context).settings.arguments as Map<String ,dynamic>;
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

                        SizedBox(height: MediaQuery.of(context).size.height * .1,),


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





  void _validateFormAndLogin() {
    var formState = _formKey.currentState;
    if (formState.validate()) {
      print('Form is valid');
    } else {

    }
  }
  String _validateRequired(String val1, val2) {
    if (val1 != val2) {
      return  "كلمة المرور مختلفة";
    }
    return null;
  }

}