import 'dart:ui';

import 'package:ali_muntaser_final_project/UI/Screens/MyDoseScreen/widgets/IdDoseContainer.dart';
import 'package:ali_muntaser_final_project/core/Providers/food_details.dart';
import 'package:ali_muntaser_final_project/core/Providers/food_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:provider/provider.dart';

class FoodDetails extends StatefulWidget {
  FoodItem2 foodInfo;

  FoodDetails({this.foodInfo});

  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  TextEditingController _textFieldGram = TextEditingController();

  _displayDialog(BuildContext context,Color color,Color co) {
    showDialog(
        context: context,


        child:AlertDialog(

          titlePadding:   EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          title:Image.network("https://zovon.s3.amazonaws.com/wp-content/uploads/2018/07/img-diabetes-diet-what-to-follow-2018-08.gif",
                    fit: BoxFit.fill,
                  ),
              content: Container(
                height: MediaQuery.of(context).size.height * .2,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xFFFFFF),
                  borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                ),
                child: Column(
                  children: [
                    Text("كمية الطعام المتناولة بالغرام ؟",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Container(
                      width: 150,
                      height: 60,

                      margin: EdgeInsets.symmetric(horizontal: 40),
                     child:  TextFormField(
                        showCursor:true ,
                       cursorColor: Colors.deepPurple,
                       cursorHeight: 25,
                       textAlign: TextAlign.end,
                       maxLength: 5,

                       keyboardType: TextInputType.datetime,
                       style: TextStyle(fontSize: 25,),
                       controller: _textFieldGram,

                       decoration: InputDecoration(
                         filled: true,
                         fillColor:color,
                         hintStyle: TextStyle(
                           color:
                           Colors.purpleAccent.withOpacity(.3),
                           fontSize: 25,
                         ),

                         focusedBorder:OutlineInputBorder(
                           gapPadding: 10,

                           borderSide:  BorderSide(color: co, width: 1),
                           //borderRadius: BorderRadius.circular(25.0),
                         ),
                         enabledBorder: OutlineInputBorder(
                           gapPadding: 10,
                           borderSide:  BorderSide(color: co, width: 1),
                           //borderRadius: BorderRadius.circular(25.0),
                         ),
                       ),
                     ),
                    ),
                    SizedBox(height: 20,),

                    RaisedButton(

                      shape: StadiumBorder(),
                      color: Colors.green,
                      onPressed: () {
                        if(_textFieldGram.text.isEmpty) return;
                        print(_textFieldGram.text);
                        _textFieldGram.text="";
                      },
                      child: Text("حفظ",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),),
                    )
                    // Container(
                    //   height: 50.0,
                    //   margin: EdgeInsets.symmetric(horizontal: 50,),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       if(_textFieldGram.text.isEmpty) return;
                    //            print(_textFieldGram.text);
                    //       _textFieldGram.text="";
                    //     },
                    //     child: Container(
                    //       //color: Colors.white60,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color:Colors.green,
                    //           style: BorderStyle.solid,
                    //           width: 1.0,
                    //         ),
                    //         color: Colors.transparent,
                    //         borderRadius: BorderRadius.circular(30.0),
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           Center(
                    //             child: Text(
                    //               "حفظ",
                    //               style: TextStyle(
                    //                 color: Colors.green,
                    //                 fontFamily: 'Montserrat',
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.w600,
                    //                 letterSpacing: 1,
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )

                  ],
                ),
              ),




    ));
  }

  @override
  void initState() {
    context
        .read<FoodDetailsProvider>()
        .sendRequestToGetDetails(widget.foodInfo.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var foodDetailsProviderRead = context.read<FoodDetailsProvider>();
    var foodDetailsProviderWatch = context.watch<FoodDetailsProvider>();

    String title = " : كل 100 غرام من ال${widget.foodInfo.name} يحتوي على ";
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 10,
            shadowColor: widget.foodInfo.borderColor,
            backgroundColor: widget.foodInfo.color,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(top: 10),
              title: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                color: (widget.foodInfo.borderColor).withOpacity(.5),
                child: Text(
                  "${widget.foodInfo.name}",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              background: Hero(
                tag: "${widget.foodInfo.id}",
                child: Image.network(
                  "${widget.foodInfo.img}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
              child: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: widget.foodInfo.color,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
          )),

          SliverToBoxAdapter(
            child: Container(
              child: AnimationLimiter(
                child: context.watch<FoodDetailsProvider>().loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: foodDetailsProviderWatch.component.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1000),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 2,
                                      color: widget.foodInfo.borderColor,
                                    ),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 70,
                                  // shape: StadiumBorder(
                                  //   side: BorderSide(
                                  //     color:(widget.foodInfo.borderColor).withOpacity(.9),
                                  //     width: 2.0,
                                  //   ),
                                  // ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${foodDetailsProviderWatch.component[index].unit.padLeft(10, " ")}",
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Text(
                                            "${foodDetailsProviderWatch.component[index].value.padLeft(10, " ")}",
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.start,
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Text(
                                            "${foodDetailsProviderWatch.component[index].nameFoodItem.padLeft(20, " ")}",
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IdDoseContainer(
                                          "${index + 1}",
                                          widget.foodInfo.borderColor
                                              .withOpacity(.4),
                                          20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          )

          // Container(width: MediaQuery.of(context).size.width,color: Colors.amberAccent,child: Text("dfghghgfhd"),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.foodInfo.borderColor,
        child: Icon(
          Icons.add,
          size: 20,
        ),
        onPressed: () {
          _displayDialog(context,widget.foodInfo.color,widget.foodInfo.borderColor);

          // AwesomeDialog(
          //     context: context,
          //     dialogType: DialogType.WARNING,
          //     headerAnimationLoop: true,
          //     animType: AnimType.TOPSLIDE,
          //     showCloseIcon: true,
          //     closeIcon: Icon(Icons.clear),
          //     title: 'تحذير',
          //     desc: 'لا تكثر من هذا الطعام',
          //     //btnCancelText: "الغاء",
          //     btnOkText: "استمرار",
          //     body: Text(
          //       "لا تكثر من هذا الطعام",
          //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //     ),
          //
          //     // btnCancelOnPress: () {},
          //     btnOkOnPress: () {})
          //   ..show();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawerScrimColor: Colors.black,
    );
  }
}
