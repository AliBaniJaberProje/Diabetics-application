

import 'package:ali_muntaser_final_project/UI/Screens/MyDoseScreen/widgets/AppBarMyDoseScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/MyDoseScreen/widgets/MyDoseBody.dart';
import 'package:ali_muntaser_final_project/core/Providers/MyDoseProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDoseScreen extends StatelessWidget {
  static final routeName = "/MyDoseScreen";
  int n = 0;

  @override
  Widget build(BuildContext context) {
    print("88");
    return  Scaffold(
        appBar: AppBarMyDoseScreen(context),
        endDrawer: Drawer(),
        body: MyDoseBody(),
      //   floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       Provider.of<MyDoseProvider>(context, listen: false)
      //           .addDoseToListProvider();
      //     },
      //
      // ),
    );
  }
}
