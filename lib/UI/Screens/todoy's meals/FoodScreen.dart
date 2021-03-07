import 'package:ali_muntaser_final_project/core/Model/FoodItem.dart';
import 'package:ali_muntaser_final_project/core/Providers/FoodProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'Widgets/FoodItemTemplate.dart';
import 'package:provider/provider.dart';

class FoodScreen extends StatelessWidget {

  static String routerName="/FoodScreen";

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      elevation: 5,
      // shape: BeveledRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topRight: Radius.circular(30),
      //     topLeft: Radius.circular(30),
      //   ),
      // ),
      context: context,
      builder: (ctx) {
        return Card(
          child: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.bottomLeft,
            child: const Text('Add shadow with color and elevation'),
            foregroundDecoration: const RotatedCornerDecoration(
                color: Colors.purple,
                geometry: const BadgeGeometry(width: 48, height: 48),
                badgeShadow: const BadgeShadow(color: Colors.black87, elevation: 1.5)),
          ),
        );

        // return Card(
        //  // height: MediaQuery.of(context).size.height * 0.4,
        //   shape: BeveledRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(30),
        //       topLeft: Radius.circular(30),
        //     ),
        //   ),
        //   child: ListView(
        //     children: [
        //       ListTile(
        //         trailing: Text(
        //           "  :  الكربوهيدرات  ",
        //           style: TextStyle(fontSize: 20),
        //         ),
        //       ),
        //       Divider(
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         trailing: Text(
        //           "  :  السكريات  ",
        //           style: TextStyle(fontSize: 20),
        //         ),
        //       ),
        //       Divider(
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         trailing: Text(
        //           "  :  الدهون  ",
        //           style: TextStyle(fontSize: 20),
        //         ),
        //       ),
        //       Divider(
        //         thickness: 1,
        //       ),
        //       ListTile(
        //         trailing: Text(
        //           "  :  الالياف  ",
        //           style: TextStyle(fontSize: 20),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: ListView.builder(
        itemBuilder: (ctx, index) {
          if (index == 0) {
            return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextField(
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                  // ),
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.red, width: 5.0),
                  // ),
                  focusColor: Colors.purple,

                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30),
                    ),
                  ),

                  hintStyle: TextStyle(fontSize: 17),
                  hintText: 'ابحث عن وجبة',
                  suffixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            );
          }
          return FoodItemTemplate(
            idView: (index).toString(),
            foodItem:new FoodItem(
                id: "2",
                content: "نص حبة بطاطا",
                food_type: FOOD_TYPE.DINNER,
                selected: true,
                color: Colors.tealAccent
            ),
          );
        },
        itemCount: 3,
      ),
      bottomSheet: Container(
        child: InkWell(
            onTap: () => displayBottomSheet(context),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.purpleAccent,
                child: Text(
                  " عرض الوحدات الغذائية  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
    );
  }
}
