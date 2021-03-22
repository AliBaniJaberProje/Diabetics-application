import 'package:ali_muntaser_final_project/core/Providers/MyDoseProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'IdDoseContainer.dart';
import 'TimeDoseContainer.dart';
import 'TitleDoseContainer.dart';

class MyDoseBody extends StatefulWidget {
  @override
  _MyDoseBodyState createState() => _MyDoseBodyState();
}

class _MyDoseBodyState extends State<MyDoseBody> {
  @override
  void initState() {
    Provider.of<MyDoseProvider>(context, listen: false).filter_listDose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("11");

    return LayoutBuilder(
      builder: (ctx, constran) {
        var objProvider = Provider.of<MyDoseProvider>(ctx, listen: true);
        return Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: () {
                      Provider.of<MyDoseProvider>(ctx, listen: false)
                          .decremant_dateDose();
                    },
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
                        Icons.navigate_before,
                        size: 50,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "جرعاتي لهذا اليوم",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${objProvider.dateDose.year}-${objProvider.dateDose.month}-${objProvider.dateDose.day}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<MyDoseProvider>(ctx, listen: false)
                          .incremant_dataDose();
                    },
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
                        Icons.navigate_next,
                        size: 50,
                      ),
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
              child: ListView.builder(
                itemBuilder: (ctx, i) {
                  Color _color = (Provider.of<MyDoseProvider>(ctx, listen: true)
                          .listDose[i]
                          .color as Color)
                      .withOpacity(.56);

                  return Provider.of<MyDoseProvider>(context, listen: true)
                          .listDose[i]
                          .take
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                              color: _color,
                            ),
                          ),
                    width: double.infinity,
                    height: 80,
                    margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TimeDoseContainer(
                                  Provider.of<MyDoseProvider>(context,
                                          listen: true)
                                      .listDose[i]
                                      .time_dose,
                                  _color.withOpacity(.5)),
                              TitleDoseContainer(Provider.of<MyDoseProvider>(
                                      context,
                                      listen: true)
                                  .listDose[i]
                                  .dosetitle),
                              IdDoseContainer(
                                  Provider.of<MyDoseProvider>(context,
                                          listen: true)
                                      .listDose[i]
                                      .id,
                                  _color.withOpacity(.5),30),
                            ],
                          ),
                        )
                      : Container();
                },
                itemCount: Provider.of<MyDoseProvider>(context, listen: true)
                    .listDose
                    .length,
              ),
            ),
          ],
        );
      },
    );
  }
}
