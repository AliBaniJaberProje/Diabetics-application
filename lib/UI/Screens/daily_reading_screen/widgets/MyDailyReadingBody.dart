import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:flipping_card/flipping_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DailyReadingController.dart';

class MyDailyReadingBody extends StatefulWidget {
  @override
  _MyDailyReadingBodyState createState() => _MyDailyReadingBodyState();
}

class _MyDailyReadingBodyState extends State<MyDailyReadingBody> {
  bool _loading=true;
  @override
  void initState() {
    context.read<DailyReadingProvider>().setTimeForThisReading(DateTime.now());
    context.read<DailyReadingProvider>().fetchDailyReading().then((v){
      setState(() {
        this._loading=false;
      });
    });
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey();
  double v1 = 0;
  double v2 = 0;
  double v3 = 0;
  double v4 = 0;
  bool v1b = false;
  bool v2b = false;
  bool v3b = false;
  bool v4b = false;

  @override
  Widget build(BuildContext context) {
    DailyReadingScreenController _dailyReadingScreenController =
        new DailyReadingScreenController(context);

    return _loading?Center(child: CircularProgressIndicator(),):

      LayoutBuilder(
      builder: (ctx, constran) => Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FlatButton(
                //   onPressed: () {},
                //   splashColor: Colors.purple,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(50),
                //     //side: BorderSide(color: Colors.red),
                //   ),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(50),
                //       color: Colors.purple.withOpacity(.5),
                //     ),
                //     child: Icon(
                //       Icons.add_location_alt,
                //       size: 40,
                //     ),
                //   ),
                // ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "قرأتك لهذا اليوم",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        "${ctx.watch<DailyReadingProvider>().timeforthisreading.year}-"
                        "${ctx.watch<DailyReadingProvider>().timeforthisreading.month}-"
                        "${ctx.watch<DailyReadingProvider>().timeforthisreading.day}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4000),
                bottomRight: Radius.circular(4000),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constran.maxHeight * .02,
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  ///--------------------------------------------------
                  SizedBox(
                    height: 15,
                  ),

                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        "قبل الافطار",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 20),
                      ),
                      expandedAlignment: Alignment.topLeft,
                      leading: ctx
                              .watch<DailyReadingProvider>()
                              .listDailyReading[0]
                              .take
                          ? Text(
                              "لم تقم بالفحص ",
                              style: TextStyle(fontSize: 20),
                            )
                          : Text(
                              "${ctx.watch<DailyReadingProvider>().listDailyReading[0].value}",
                              style: TextStyle(fontSize: 20),
                            ),
                      children: [
                        ListTile(
                          leading: FlatButton.icon(
                            color: Colors.green,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: () {
                              if (!_formKey.currentState.validate()) return;

                              _formKey.currentState.save();
                              _dailyReadingScreenController.setValue(0, v1);

                              print(v1);
                            },
                            icon: Icon(
                              ctx
                                      .watch<DailyReadingProvider>()
                                      .listDailyReading[0]
                                      .take
                                  ? Icons.save
                                  : Icons.edit,
                              size: 25,
                              color: Colors.white,
                            ),
                            label: Text(
                              ctx
                                      .watch<DailyReadingProvider>()
                                      .listDailyReading[0]
                                      .take
                                  ? 'حفظ'
                                  : 'تعديل',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                          title: Form(
                            key: _formKey,
                            child: TextFormField(
                              cursorHeight: 40,

                              initialValue:
                                  "${ctx.watch<DailyReadingProvider>().listDailyReading[0].value}",
                              textAlign: TextAlign.end,

                              decoration: InputDecoration(
                                focusColor: Colors.green,
                                prefixIcon: Icon(
                                  Icons.dock_sharp,
                                  color: Colors.green,
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 2),
                                ),
                              ),
                              style: TextStyle(fontSize: 18),

                              // decoration: InputDecoration(
                              //   fillColor: Colors.white70,
                              //     border: OutlineInputBorder(),
                              //
                              // ),
                              keyboardType: TextInputType.datetime,
                              validator: (val) {
                                if (val.isEmpty) return "يرجى ادخال القيمة";
                              },
                              onSaved: (val) {
                                v1 = double.parse(val);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.indigo, width: 2),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.indigo.shade100,
                    ),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         Colors.green,
                    //         Colors.green.withOpacity(.1),
                    //       ],
                    //     )),
                    child: ExpansionTile(
                      title: Text(
                        "بعد الافطار بساعتين",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 20),
                      ),
                      expandedAlignment: Alignment.topLeft,
                      leading: ctx
                              .watch<DailyReadingProvider>()
                              .listDailyReading[1]
                              .take
                          ? Text(
                              "لم تقم بالفحص ",
                              style: TextStyle(fontSize: 20),
                            )
                          : Text(
                              "${ctx.watch<DailyReadingProvider>().listDailyReading[1].value}",
                              style: TextStyle(fontSize: 20),
                            ),
                      children: [
                        ListTile(
                            leading: FlatButton.icon(
                              color: Colors.indigo,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              onPressed: () {
                                if (!_formKey.currentState.validate()) return;

                                _formKey.currentState.save();
                                _dailyReadingScreenController.setValue(1, v2);
                              },
                              icon: Icon(
                                ctx
                                        .watch<DailyReadingProvider>()
                                        .listDailyReading[1]
                                        .take
                                    ? Icons.save
                                    : Icons.edit,
                                size: 25,
                                color: Colors.white,
                              ),
                              label: Text(
                                ctx
                                        .watch<DailyReadingProvider>()
                                        .listDailyReading[1]
                                        .take
                                    ? 'حفظ'
                                    : 'تعديل',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                            title: Form(
                              key: _formKey,
                              child: TextFormField(
                                autofocus: true,
                                style: TextStyle(fontSize: 20),
                                cursorHeight: 40,
                                initialValue:
                                    "${ctx.watch<DailyReadingProvider>().listDailyReading[1].value}",
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.datetime,
                                validator: (val) {
                                  if (val.isEmpty) return "يرجى ادخال القيمة";
                                },
                                onSaved: (val) {
                                  v2 = double.parse(val);
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.indigo,
                                  prefixIcon: Icon(
                                    Icons.dock_sharp,
                                    color: Colors.indigo,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Colors.indigo, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Colors.indigo, width: 2),
                                  ),
                                ),
                              ),
                            ),

                            //subtitle: Text("Where You Can Register An Account "),
                            onTap: () {}),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ///
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 2),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.amber.shade100,
                    ),
                    child: ExpansionTile(
                      // backgroundColor: Colors.purple.withOpacity(.2),
                      title: Text(
                        "بعد الغداء بساعتين",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 20),
                      ),
                      expandedAlignment: Alignment.topLeft,
                      leading: ctx
                              .watch<DailyReadingProvider>()
                              .listDailyReading[2]
                              .take
                          ? Text(
                              "لم تقم بالفحص ",
                              style: TextStyle(fontSize: 20),
                            )
                          : Text(
                              "${ctx.watch<DailyReadingProvider>().listDailyReading[2].value}",
                              style: TextStyle(fontSize: 20),
                            ),
                      children: [
                        ListTile(
                            leading: FlatButton.icon(
                              color: Colors.amber,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              onPressed: () {
                                if (!_formKey.currentState.validate()) return;

                                _formKey.currentState.save();
                                _dailyReadingScreenController.setValue(2, v3);
                                print(v3);
                              },
                              icon: Icon(
                                ctx
                                        .watch<DailyReadingProvider>()
                                        .listDailyReading[2]
                                        .take
                                    ? Icons.save
                                    : Icons.edit,
                                size: 25,
                                color: Colors.white,
                              ),
                              label: Text(
                                ctx
                                        .watch<DailyReadingProvider>()
                                        .listDailyReading[2]
                                        .take
                                    ? 'حفظ'
                                    : 'تعديل',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),

                            // trailing: Icon(Icons.arrow_forward_ios),

                            title: Container(
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  initialValue:
                                      "${ctx.watch<DailyReadingProvider>().listDailyReading[2].value}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 20),
                                  keyboardType: TextInputType.datetime,
                                  validator: (val) {
                                    if (val.isEmpty) return "يرجى ادخال القيمة";
                                  },
                                  onSaved: (val) {
                                    v3 = double.parse(val);
                                  },
                                  decoration: InputDecoration(
                                    focusColor: Colors.amber,
                                    prefixIcon: Icon(
                                      Icons.dock_sharp,
                                      color: Colors.amber,
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.amber, width: 2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //subtitle: Text("Where You Can Register An Account "),
                            onTap: () {}),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange, width: 2),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.deepOrange.shade100,
                    ),
                    child: ExpansionTile(
                      // backgroundColor: Colors.purple.withOpacity(.2),
                      title: Text(
                        "بعد العشاء بساعتين",
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 20),
                      ),
                      expandedAlignment: Alignment.topLeft,
                      leading: ctx
                              .watch<DailyReadingProvider>()
                              .listDailyReading[3]
                              .take
                          ? Text(
                              "لم تقم بالفحص ",
                              style: TextStyle(fontSize: 20),
                            )
                          : Text(
                              "${ctx.watch<DailyReadingProvider>().listDailyReading[3].value}",
                              style: TextStyle(fontSize: 20),
                            ),
                      children: [
                        ListTile(
                          leading: FlatButton.icon(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.deepOrange,
                            onPressed: () {
                              if (!_formKey.currentState.validate()) return;

                              _formKey.currentState.save();
                              _dailyReadingScreenController.setValue(3, v4);

                              print(v1);
                            },
                            icon: Icon(
                              ctx
                                      .watch<DailyReadingProvider>()
                                      .listDailyReading[3]
                                      .take
                                  ? Icons.save
                                  : Icons.edit,
                              size: 25,
                              color: Colors.white,
                            ),
                            label: Text(
                              ctx
                                      .watch<DailyReadingProvider>()
                                      .listDailyReading[3]
                                      .take
                                  ? 'حفظ'
                                  : 'تعديل',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),

                          // trailing: Icon(Icons.arrow_forward_ios),

                          title: Container(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                initialValue:
                                    "${ctx.watch<DailyReadingProvider>().listDailyReading[3].value}",
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 20),
                                keyboardType: TextInputType.datetime,
                                validator: (val) {
                                  if (val.isEmpty) return "يرجى ادخال القيمة";
                                },
                                onSaved: (val) {
                                  v4 = double.parse(val);
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.deepOrange,
                                  prefixIcon: Icon(
                                    Icons.dock_sharp,
                                    color: Colors.deepOrange,
                                  ),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Colors.deepOrange, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Colors.deepOrange, width: 2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //subtitle: Text("Where You Can Register An Account "),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
