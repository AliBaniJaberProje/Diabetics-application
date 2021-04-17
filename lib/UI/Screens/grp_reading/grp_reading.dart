import 'dart:io';

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Widgets/MainDrawer/maindrawer.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

import 'package:syncfusion_flutter_charts/charts.dart';


class GrpReading extends StatefulWidget {
  static String routeName="/GrpReading";
  @override
  _State createState() => _State();
}

class _State extends State<GrpReading> {

  File pickedImage;
  String textData="";
  String firstWord="";
  String lastWord="";
  Future pickImage(ImageSource src) async{
    var tempStore=await ImagePicker.pickImage(source: src);
    setState(() {

        pickedImage=tempStore;
        readText();
        Navigator.pop(context);

    });
  }
  Future readText() async{
    final FirebaseVisionImage ourImage=FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizerText =FirebaseVision.instance.textRecognizer();
    VisionText readText= await recognizerText.processImage(ourImage);
    String text="";
    bool flag=true;
    for(TextBlock block in readText.blocks){
      for(TextLine line in block.lines){
        text+=line.text;
        for(TextElement word in line.elements ){
          if(flag){
            firstWord=word.text;
            flag=false;
          }
          lastWord=word.text;
          print(word.text);
        }
      }
    }
    setState(() {
      this.textData=text;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:  MainDrawer(),
      appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
      ),
      title: Text(
        "تسجيل فحص السكري التراكمي",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        textDirection: ui.TextDirection.rtl,
      ),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         pickedImage!=null? Container(
           margin: EdgeInsets.all(2),
            height: MediaQuery.of(context).size.height *.55,
            //color: Colors.purple,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple, width: 1),
                image: DecorationImage(
                  image:  FileImage(pickedImage),
                  fit: BoxFit.fill,

                )
              //fit: BoxFit.cover,
            ),
          ):SizedBox(  height: MediaQuery.of(context).size.height *.5,),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          pickedImage==null ?SizedBox(  height: MediaQuery.of(context).size.height *.2,): Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height *.2,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("تاريخ الفحص",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                    Text("نتيجة الفحص",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ]
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(this.firstWord,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                      Text(this.lastWord,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ]
                ),
              ],
            ),

            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.purple, width: 3)

            ),
          ),
        ],
      ),
    ),

    floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if(pickedImage==null)
        FloatingActionButton.extended(
          heroTag: "tag1",
          backgroundColor: Colors.purple,
          label: Text("تصوير الفحص",style: TextStyle(fontSize: 18),),
          icon: Icon(Icons.camera_alt_outlined,size: 30,),
          onPressed: (){
            var alertDialog = AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              title: Text(
                "اختيار الصورة من ",
                textAlign: TextAlign.end,
              ),
              content: Container(
                height: 150,
                child: Column(
                  children: [
                    Divider(
                      color: Colors.black,
                    ),
                    Container(
                      color: Colors.purple,
                      width: 300,
                      child: ListTile(
                        trailing: Icon(Icons.image),
                        title: Text(
                          "صوري",
                          textAlign: TextAlign.end,
                        ),
                        onTap: ()async {

                         pickImage(ImageSource.gallery);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      color: Colors.purple,
                      child: ListTile(
                          trailing: Icon(Icons.camera_alt),
                          title: Text(
                            "الكاميرا",
                            textAlign: TextAlign.end,
                          ),
                          onTap: () {
                            pickImage(ImageSource.camera);
                          }),
                    )
                  ],
                ),
              ),
            );
            showDialog(context: context, child: alertDialog);
          },
        ),
        if(pickedImage!=null)
        FloatingActionButton.extended(
          heroTag: "tag2",
          backgroundColor: Colors.green,
          label: Text("حفظ",style: TextStyle(fontSize: 18),),
          icon: Icon(Icons.save,size: 30,),
          onPressed: (){
            setState(() {
              pickedImage=null;
            });
          },
        ),
        if(pickedImage!=null)
          FloatingActionButton.extended(
            heroTag: "tag3",
            backgroundColor: Colors.red,
            label: Text("الغاء",style: TextStyle(fontSize: 18),),
            icon: Icon(Icons.close,size: 30,),
            onPressed: (){
              setState(() {
                pickedImage=null;
              });
            },
          ),
      ],
    ),





    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


