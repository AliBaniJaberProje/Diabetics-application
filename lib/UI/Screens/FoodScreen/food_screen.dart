import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Widgets/MainDrawer/maindrawer.dart';
import '../../../core/Providers/food_details.dart';
import 'package:ali_muntaser_final_project/core/Providers/food_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'food_detalis.dart';

class FoodScreen2 extends StatefulWidget {
  static String routeName = "/FoodScreen";

  FoodScreen2({Key key}) : super(key: key);

  @override
  _FoodScreen2State createState() => _FoodScreen2State();
}

class _FoodScreen2State extends State<FoodScreen2> {
  _openDetail(context, foodInfo) {
    final route = MaterialPageRoute(
      builder: (context) => FoodDetails(
        foodInfo: foodInfo,
      ),
    );
    Navigator.push(context, route);
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
          "الوجبات الغذائية",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.purple.shade50,
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
            child: DropdownSearch<String>(
              popupTitle: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  "قم باختيار صنف الطعام الذي ترعب به",
                  style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w100,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              popupItemBuilder: (context, title, t) => ListTile(
                trailing: Icon(
                  Icons.remove,
                  size: 25,
                  color: Colors.purple,
                ),
                title: Text(
                  title,
                  textAlign: TextAlign.end,
                ),
              ),
              showAsSuffixIcons: true,
              mode: Mode.DIALOG,
              items: [
                "منتجات الألبان والبيض",
                "الدهون والزيوت",
                "اللحوم و الأسماك",
                "فواكه",
                "خضروات",
                "المشروبات",
                "البقوليات والمكسرات", //
                "النشويات", //
                "الحلويات", //
                "الورقيات", //
                //"وجبات خفيفة",//
              ],
              label: "  صنف الطعام    ",

              showSearchBox: true,
              showClearButton: true,
              showSelectedItem: true,
              onChanged: (val) {
                context.read<FoodProvider2>().sendRequestAndGetFoodList(val);
                context.read<FoodDetailsProvider>().categoryName = val;
              },
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.purple,
          ),
          Expanded(
            child: context.read<FoodProvider2>().loadingState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : AnimationLimiter(
                    child: GridView.builder(
                      padding: EdgeInsets.all(20),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: context.watch<FoodProvider2>().foodList.length,
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: "$index",
                          child: InkWell(
                            onTap: () => _openDetail(context,
                                context.read<FoodProvider2>().foodList[index]),
                            child: AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              columnCount: context
                                  .watch<FoodProvider2>()
                                  .foodList
                                  .length,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: Card(
                                    color: context
                                        .watch<FoodProvider2>()
                                        .foodList[index]
                                        .color,
                                    elevation: 1,
                                    shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: context
                                            .watch<FoodProvider2>()
                                            .foodList[index]
                                            .borderColor,
                                        width: .5,
                                      ),
                                    ),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Image.network(
                                          context
                                              .watch<FoodProvider2>()
                                              .foodList[index]
                                              .img,
                                          height: 100,
                                          width: 170,
                                          fit: BoxFit.fill,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          context
                                              .watch<FoodProvider2>()
                                              .foodList[index]
                                              .name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.purple),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
