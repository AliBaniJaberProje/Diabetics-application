import 'dart:ui';

import 'package:ali_muntaser_final_project/UI/Screens/MyDoseScreen/widgets/IdDoseContainer.dart';
import 'package:ali_muntaser_final_project/UI/Screens/doctor_appointments/Doctor_appointmentScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/food_details.dart';
import 'package:ali_muntaser_final_project/core/Providers/food_provider.dart';
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
                                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
        onPressed: () {},
      ),
      drawerScrimColor: Colors.black,
    );
  }
}
