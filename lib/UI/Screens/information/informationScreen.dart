import 'dart:convert';
import 'dart:math';

import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:http/http.dart' as http;

class DocumantModel {
  String title;
  String documant;

  DocumantModel({this.title, this.documant});
}

List<DocumantModel> documants=[];



final all  = [
  "سكري نوع أ",
  "سكري نوع ب",
  "سكري الحمل",
  "ممارسة الرياضة",
  "تنظيم الطعام",
  "فحوصات السكري",
  "جرعات السكري",
  "ارشادات عند الصيام",

];
final ids=[];



final allDetails=[




];


List<Color> color = [
  Colors.greenAccent,
  Colors.amber,
  Colors.blueAccent,
  Colors.purpleAccent,
  Colors.orangeAccent,
  Colors.red
];
List<Color> colorShadow = [
  Colors.greenAccent.shade100,
  Colors.amber.shade100,
  Colors.blueAccent.shade100,
  Colors.purpleAccent.shade100,
  Colors.orangeAccent.shade100,
  Colors.red.shade100
];
bool loading=true;
class InformationScreen extends StatefulWidget {
  static String routeName = "/InformationScreen";

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  CarouselController buttonCarouselController = CarouselController();
  int index=0;
  String documant="";


  @override
  void initState() {
    Random random = new Random();
    int randomNumber = random.nextInt(all.length);
    index=randomNumber;
    setState(() {
      loading=true;
    });

    http.get("https://jaber-server.herokuapp.com/information/title").then((result){
      var data= jsonDecode(result.body);
      all.clear();
      allDetails.clear();
      for(int i=0;i<data.length;i++){
       all.add(data[i]["title"]);

       allDetails.add(data[i]["documant"]);

      }

      // http.get("http://192.168.0.101:3000/information/documant/${ids[this.index]}").then((value){
      //   print(jsonDecode(value.body));
      //   setState(() {
      //     this.documant=jsonDecode(value.body)["documant"];
      //     loading=false;
      //   });
      // });

     setState(() {
       loading=false;
     });




    });

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {

            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
        title: Text(
          'مقالات عن مرض السكري',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch()).then((val) {

                setState(() {
                  this.index=int.parse(val);
                });

                // setState(() {
                //   loading=true;
                // });
                //
                // setState(() {
                //   ;
                //   http.get("http://192.168.0.101:3000/information/documant/${ids[this.index]}").then((value){
                //     print(jsonDecode(value.body));
                //     this.documant=jsonDecode(value.body)["documant"];
                //
                //   });
                // });
                // setState(() {
                //   loading=false;
                // });
                // print(all[]);
              });
            },
          ),
        ],

        centerTitle: true,
      ),

      body:loading?Center(child: CircularProgressIndicator(),): Container(
        margin: EdgeInsets.all(10),
        child:  ListView(
            children: <Widget>[

              Text(
                all[index],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              Text(
                allDetails[index],

                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,

              ),


              //
              // Container(
              //   margin: EdgeInsets.all(4),
              //   padding: EdgeInsets.all(10),
              //   height: MediaQuery.of(context).size.height*.85,
              //   decoration: BoxDecoration(
              //       color: colorShadow[index%color.length],
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(
              //           color: color[index%color.length],
              //           width: 2
              //       )
              //   ),
              //    child:
              //    Expanded(
              //      child:
              //    ListView(
              //      children: [
              //
              //
              //
              //
              //
              //      ],
              //    ) ,
              //   // margin: EdgeInsets.all(4),
              //   // padding: EdgeInsets.all(10),
              // ),)
              //



            ],
          )
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final recent = all;

  @override
  List<Widget> buildActions(BuildContext context) {
    // action  for appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // return Card(
    //   color: Colors.yellow,
    //     shape: StadiumBorder(),
    //   child: Center(
    //     child: Text(query),
    //   ),
    // );

    // return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recent
        : all.where((value) => value.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // loading=true;
          close(context, index.toString());
        },
        trailing: Icon(Icons.search),

        title: RichText(
          text: TextSpan(
              text: query,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ],),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
