


import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberOfStep extends StatelessWidget {
  static String routeName="/NumberOfStep";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("الرياضة"),
        actions: [
          IconButton(icon: Icon(Icons.arrow_back), onPressed:()=> Navigator.pushReplacementNamed(context,HomeScreen.routeName),
          )
        ],
      ),
      body:Column(
        children: [
          SizedBox(height: 10,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(

                  child: Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Text("14\nHIR",style: TextStyle(fontSize: 25,),),
                      )
                  ),

                ),
                Text(":",style: TextStyle(fontSize: 25,),),
                Card(

                  child: Container(
                      width: 80,
                      height: 80,
                      child:Center(
                        child: Text("43\nMIN",style: TextStyle(fontSize: 25,),),
                      )
                  ),

                ),
                Text(":",style: TextStyle(fontSize: 25,),),
                Card(

                  child: Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Text("55\nSEC",style: TextStyle(fontSize: 25,),),
                      )
                  ),

                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: Icon(Icons.pause_circle_outline),onPressed: (){},splashColor: Colors.purple,),
              IconButton(icon: Icon(Icons.play_circle_outline),onPressed: (){},splashColor: Colors.purple,),
              IconButton(icon: Icon(Icons.refresh),onPressed: (){},splashColor: Colors.purple,),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          Divider(
            color: Colors.purple,
          ),



        ],
      ),

      bottomNavigationBar:BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          color: Colors.purple,
          width: double.infinity,
          height: 50.0,
        ),
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}


