import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DailyReadingController.dart';

class MyDailyReadingBody extends StatefulWidget {
  @override
  _MyDailyReadingBodyState createState() => _MyDailyReadingBodyState();
}

class _MyDailyReadingBodyState extends State<MyDailyReadingBody> {
  @override
  void initState() {
    context.read<DailyReadingProvider>().setTimeForThisReading(DateTime.now());
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
      DailyReadingScreenController _dailyReadingScreenController=new DailyReadingScreenController(context);

    return LayoutBuilder(
      builder: (ctx, constran) => Column(children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: () {},
                splashColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  //side: BorderSide(color: Colors.red),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.purple.withOpacity(.5),
                  ),
                  child: Icon(
                    Icons.add_location_alt,
                    size: 40,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      "قرأتك لهذا اليوم",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${ctx.watch<DailyReadingProvider>().timeforthisreading.year}-"
                          "${ctx.watch<DailyReadingProvider>().timeforthisreading.month}-"
                          "${ctx.watch<DailyReadingProvider>().timeforthisreading.day}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: constran.maxWidth * .2,
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
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.withOpacity(.7),
                              Colors.purple.withOpacity(.1),
                            ],
                          )),
                      child: ExpansionTile(
                        backgroundColor: Colors.purple.withOpacity(.2),
                        title: Text(
                          "قبل الافطار \n ",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25),
                        ),
                        expandedAlignment: Alignment.topLeft,
                        leading: ctx
                                .watch<DailyReadingProvider>()
                                .listDailyReading[0]
                                .take
                            ? Text(
                                "لم تقم بالفحص ",
                                style: TextStyle(fontSize: 25),
                              )
                            : Container(
                                child: Text(
                                  "${ctx.watch<DailyReadingProvider>().listDailyReading[0].value}",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                        children: [
                          Divider(
                            color: Colors.black,
                          ),
                          ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(30)),
                                child: FlatButton.icon(
                                    onPressed: () {
                                      if (!_formKey.currentState.validate())
                                        return;

                                      _formKey.currentState.save();
                                      _dailyReadingScreenController.setValue(0, v1);
                                    
                                      print(v1);
                                    },
                                    icon: Icon(
                                      ctx
                                  .watch<DailyReadingProvider>()
                                  .listDailyReading[0]
                                  .take?Icons.save:Icons.edit,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      ctx
                                  .watch<DailyReadingProvider>()
                                  .listDailyReading[0]
                                  .take?'حفظ':'تعديل',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),),
                              ),
                              // trailing: Icon(Icons.arrow_forward_ios),

                              title: Container(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    autofocus: true,
                                    cursorHeight: 40,
                                    maxLength: 5,
                                    initialValue:
                                        "${ctx.watch<DailyReadingProvider>().listDailyReading[0].value}",
                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white70,
                                      prefix:
                                          Icon(Icons.add_location_alt_rounded),
                                      enabled: true,
                                      hintText: '',
                                      helperText: '',
                                      counterText: '',
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return "يرجى ادخال القيمة";
                                    },
                                    onSaved: (val) {
                                      v1 = double.parse(val);
                                    },
                                  ),
                                ),
                              ),
                              //subtitle: Text("Where You Can Register An Account "),
                              onTap: () {}),
                         
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.purple.withOpacity(.1),
                            ],
                          )),
                      child: ExpansionTile(
                        backgroundColor: Colors.purple.withOpacity(.2),
                        title: Text(
                          "بعد الافطار بساعتين",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25),
                        ),
                        expandedAlignment: Alignment.topLeft,
                        leading: ctx
                                .watch<DailyReadingProvider>()
                                .listDailyReading[1]
                                .take
                            ? Text(
                                "لم تقم بالفحص ",
                                style: TextStyle(fontSize: 25),
                              )
                            : Text(
                                "${ctx.watch<DailyReadingProvider>().listDailyReading[1].value}",
                                style: TextStyle(fontSize: 25),
                              ),
                        children: [
                          Divider(
                            color: Colors.black,
                          ),
                          ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(30)),
                                child: FlatButton.icon(
                                    onPressed: () {
                                      if (!_formKey.currentState.validate())
                                        return;

                                      _formKey.currentState.save();
                                      _dailyReadingScreenController.setValue(1, v2);
                                     
                                    },
                                    icon: Icon(
                                      ctx
                                  .watch<DailyReadingProvider>()
                                  .listDailyReading[1]
                                  .take?Icons.save:Icons.edit,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                       ctx
                                  .watch<DailyReadingProvider>()
                                  .listDailyReading[1]
                                  .take?'حفظ':'تعديل',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),),
                              ),
                              // trailing: Icon(Icons.arrow_forward_ios),

                              title: Container(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    autofocus: true,
                                    cursorHeight: 40,
                                    maxLength: 5,
                                    initialValue:
                                        "${ctx.watch<DailyReadingProvider>().listDailyReading[1].value}",
                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white70,
                                      prefix:
                                          Icon(Icons.add_location_alt_rounded),
                                      enabled: true,
                                      hintText: '',
                                      helperText: '',
                                      counterText: '',
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return "يرجى ادخال القيمة";
                                    },
                                    onSaved: (val) {
                                      v2 = double.parse(val);
                                    },
                                  ),
                                ),
                              ),
                              //subtitle: Text("Where You Can Register An Account "),
                              onTap: () {}),
                         
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.purple.withOpacity(.1),
                            ],
                          )),
                      child: ExpansionTile(
                        backgroundColor: Colors.purple.withOpacity(.2),
                        title: Text(
                          "بعد الغداء بساعتين",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25),
                        ),
                        expandedAlignment: Alignment.topLeft,
                        leading: ctx
                                .watch<DailyReadingProvider>()
                                .listDailyReading[2]
                                .take
                            ? Text(
                                "لم تقم بالفحص ",
                                style: TextStyle(fontSize: 25),
                              )
                            : Text(
                                "${ctx.watch<DailyReadingProvider>().listDailyReading[2].value}",
                                style: TextStyle(fontSize: 25),
                              ),
                        children: [
                          Divider(
                            color: Colors.black,
                          ),
                          ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(30)),
                                child: FlatButton.icon(
                                    onPressed: () {
                                      if (!_formKey.currentState.validate())
                                        return;

                                      _formKey.currentState.save();
                                      _dailyReadingScreenController.setValue(2, v3);
                                      print(v3);
                                    },
                                    icon: Icon(
                                      ctx
                                  .watch<DailyReadingProvider>()
                                  .listDailyReading[2]
                                  .take?Icons.save:Icons.edit,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                       ctx
                                  .watch<DailyReadingProvider>()
                                  .listDailyReading[2]
                                  .take?'حفظ':'تعديل',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),),
                              ),
                              // trailing: Icon(Icons.arrow_forward_ios),

                              title: Container(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    autofocus: true,
                                    cursorHeight: 40,
                                    maxLength: 5,
                                    initialValue:
                                        "${ctx.watch<DailyReadingProvider>().listDailyReading[2].value}",
                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white70,
                                      prefix:
                                          Icon(Icons.add_location_alt_rounded),
                                      enabled: true,
                                      hintText: '',
                                      helperText: '',
                                      counterText: '',
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return "يرجى ادخال القيمة";
                                    },
                                    onSaved: (val) {
                                      v3 = double.parse(val);
                                    },
                                  ),
                                ),
                              ),
                              //subtitle: Text("Where You Can Register An Account "),
                              onTap: () {}),
                         
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.purple.withOpacity(.1),
                            ],
                          )),
                      child: ExpansionTile(
                        backgroundColor: Colors.purple.withOpacity(.2),
                        title: Text(
                          "بعد العشاء بساعتين",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25),
                        ),
                        expandedAlignment: Alignment.topLeft,
                        leading: ctx
                                .watch<DailyReadingProvider>()
                                .listDailyReading[3]
                                .take
                            ? Text(
                                "لم تقم بالفحص ",
                                style: TextStyle(fontSize: 25),
                              )
                            : Text(
                                "${ctx.watch<DailyReadingProvider>().listDailyReading[3].value}",
                                style: TextStyle(fontSize: 25),
                              ),
                        children: [
                          Divider(
                            color: Colors.black,
                          ),
                          ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(30)),
                                child: FlatButton.icon(
                                    onPressed: () {
                                      if (!_formKey.currentState.validate())
                                        return;

                                      _formKey.currentState.save();
                                      _dailyReadingScreenController.setValue(3, v4);

                                      print(v1);
                                    },
                                    icon: Icon(
                                      ctx
                                  .watch<DailyReadingProvider>()
                                  .listDailyReading[3]
                                  .take?Icons.save:Icons.edit,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                       ctx
                                  .watch<DailyReadingProvider>()
                                  .listDailyReading[3]
                                  .take?'حفظ':'تعديل',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),),
                              ),
                              // trailing: Icon(Icons.arrow_forward_ios),

                              title: Container(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    autofocus: true,
                                    cursorHeight: 40,
                                    maxLength: 5,
                                    initialValue:
                                        "${ctx.watch<DailyReadingProvider>().listDailyReading[3].value}",
                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white70,
                                      prefix:
                                          Icon(Icons.add_location_alt_rounded),
                                      enabled: true,
                                      hintText: '',
                                      helperText: '',
                                      counterText: '',
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return "يرجى ادخال القيمة";
                                    },
                                    onSaved: (val) {
                                      v4 = double.parse(val);
                                    },
                                  ),
                                ),
                              ),
                              //subtitle: Text("Where You Can Register An Account "),
                              onTap: () {},),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],),
    );
  }
}
