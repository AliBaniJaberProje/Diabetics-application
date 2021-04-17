import 'dart:io';

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/history/suqar_reding_history.dart';
import 'package:ali_muntaser_final_project/UI/Widgets/MainDrawer/maindrawer.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:ui' as ui;

import 'package:image_picker/image_picker.dart';

class GrpHistory extends StatefulWidget {
  static String routeName="/GrpHistory";
  GrpHistory({Key key}) : super(key: key);

  @override
  _GrpHistoryState createState() => _GrpHistoryState();
}

class _GrpHistoryState extends State<GrpHistory> {
  File pickedImage;
  int tableChart=1;


  Future<DateTime> selectYear(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      initialDatePickerMode: DatePickerMode.year,
      initialEntryMode: DatePickerEntryMode.calendar,

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
                primary: Colors.purple,
                secondary: Colors.amber
            ),
          ),
          child: child,
        );
      },
    );
    return picked;
  }


  Future pickImage() async{
    var tempStore=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage=tempStore;
    });
  }
  String textData="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:MainDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        title: Text(
          " السكري التراكمي ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textDirection: ui.TextDirection.rtl,
        ),
        centerTitle: true,
      ),

      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple,width: 3)
            ),

            child: Center(
              child: Text(
                "قم باختيار السنة لمرفة فحوصات السكري التراكمي",
                style: TextStyle(
                  fontSize: 18,
                ),
                textDirection: ui.TextDirection.rtl,
              ),
            ),
          ),
          Card_GRP(color: Colors.amber.shade100,borderColor: Colors.amber,dateGRP: "19-2-2021",valueGRP: "6.1",),
          Card_GRP(color: Colors.green.shade100,borderColor: Colors.green,dateGRP: "19-2-2021",valueGRP: "5.3",),


          Card_GRP(color: Colors.orange.shade100,borderColor: Colors.orange,dateGRP: "19-2-2021",valueGRP: "6.1",),
          Card_GRP(color: Colors.purple.shade100,borderColor: Colors.purple,dateGRP: "19-2-2021",valueGRP: "6.1",),
        ],
      ),


      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.date_range_sharp,size: 30,),
        label: Text("معرفة الفحوصات السابقة"),
        onPressed: (){},
      ),

    );
  }

  Column buildTestORC() {
    return Column(
      children: [
        pickedImage==null?Center():Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
              image:  FileImage(pickedImage),
                fit: BoxFit.fill,
              )
              //fit: BoxFit.cover,
            ),
          ),
        ),
        RaisedButton(
          child: Text("select"),
          onPressed: pickImage,
        ),

        RaisedButton(
          child: Text("read text "),
          onPressed: readText,
        ),
        Text(this.textData)
      ],
    );
  }

  Future readText() async{
    final FirebaseVisionImage ourImage=FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizerText =FirebaseVision.instance.textRecognizer();
    VisionText readText= await recognizerText.processImage(ourImage);
    String text="";
    for(TextBlock block in readText.blocks){
       for(TextLine line in block.lines){
         text+=line.text;
         for(TextElement word in line.elements ){

           print(word.text);
         }
       }
    }
    setState(() {
      this.textData=text;
    });

  }
}

class Card_GRP extends StatelessWidget {
  final Color borderColor;
  final Color color;
  final String dateGRP;
  final String valueGRP;

  const Card_GRP({ this.borderColor, this.color, this.dateGRP, this.valueGRP});


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 10,
      color:this.color,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color:this.borderColor,
          width: 2,
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "تاريخ الفحص",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
                Text(
                  this.dateGRP,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "قيمة الفحص",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
                Text(
                  this.valueGRP,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}