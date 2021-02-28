import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  static final String routeName = "/DoctorAppointmentsScreen";
  @override
  _DoctorAppointmentsScreenState createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "حجز مواعيد لمراجعة الطبيب ",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        ),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 50,
              color: Colors.purple,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyIconWidget(
                icon: Icons.arrow_back_ios,
                colorIcon: Colors.purple,
                colorContainer: Colors.purple.shade100,
                onPressed: () {
                  print("222222222");
                },
              ),
              Card(
                 color: Colors.amber.shade100,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.purple,
                    width: .1,
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 150,
                  child: Text(
                    "22-10-2021",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              MyIconWidget(
                icon: Icons.arrow_forward_ios,
                colorIcon: Colors.purple,
                colorContainer: Colors.purple.shade100,
                onPressed: () {
                  print("11111111111");
                },
              ),


            ],
          ),
          // ListTile(
          //   title: Card(
          //     // color: Colors.purple.shade100,
          //     shape: BeveledRectangleBorder(
          //       borderRadius: BorderRadius.circular(30),
          //       side: BorderSide(
          //         color: Colors.purple,
          //         width: .1,
          //       ),
          //     ),
          //     child: Container(
          //       alignment: Alignment.center,
          //       height: 50,
          //       width: 150,
          //       child: Text(
          //         "22-10-2021",
          //         style: TextStyle(
          //             fontSize: 20,
          //             color: Colors.purple,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ),
          //   trailing: MyIconWidget(
          //     icon: Icons.arrow_forward_ios,
          //     colorIcon: Colors.purple,
          //     colorContainer: Colors.purple.shade100,
          //     onPressed: () {
          //       print("11111111111");
          //     },
          //   ),
          //   leading: MyIconWidget(
          //     icon: Icons.arrow_back_ios,
          //     colorIcon: Colors.purple,
          //     colorContainer: Colors.purple.shade100,
          //     onPressed: () {
          //       print("222222222");
          //     },
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView(
              children: [
                MyCardItem(onPressed: (){
                  print("tttttttttt");
                },
                colorContainer: Colors.amber.shade100,
                colorButton: Colors.amber,
                textInfo: '8:30 - 9:00',
                ),


                MyCardItem(onPressed: (){
                  print("tttttttttt");
                },
                  colorContainer: Colors.red.shade100,
                  colorButton: Colors.red,
                  textInfo: '8:30 - 9:00',
                ),



                MyCardItem(onPressed: (){
                  print("tttttttttt");
                },
                  colorContainer: Colors.blueAccent.shade100,
                  colorButton: Colors.blueAccent,
                  textInfo: '8:30 - 9:00',
                ),


                MyCardItem(onPressed: (){
                  print("tttttttttt");
                },
                  colorContainer: Colors.greenAccent.shade100,
                  colorButton: Colors.greenAccent,
                  textInfo: '8:30 - 9:00',
                ),


                MyCardItem(onPressed: (){
                  print("tttttttttt");
                },
                  colorContainer: Colors.purpleAccent.shade100,
                  colorButton: Colors.purpleAccent,
                  textInfo: '8:30 - 9:00',
                ),

                MyCardItem(onPressed: (){
                  print("tttttttttt");
                },
                  colorContainer: Colors.tealAccent.shade100,
                  colorButton: Colors.tealAccent,
                  textInfo: '8:30 - 9:00',
                ),


                MyCardItem(onPressed: (){
                  print("tttttttttt");
                },
                  colorContainer: Colors.orangeAccent.shade100,
                  colorButton: Colors.orangeAccent,
                  textInfo: '8:30 - 9:00',
                ),

                MyCardItem(onPressed: (){
                  print("tttttttttt");
                },
                  colorContainer: Colors.lime.shade100,
                  colorButton: Colors.lime,
                  textInfo: '8:30 - 9:00',
                ),


              ],
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              padding: EdgeInsets.all(8),
            ),
          )
        ],
      ),
    );
  }
}

class MyCardItem extends StatelessWidget {

  final Function  onPressed;
  final String  textInfo ;
  final Color colorContainer;
  final Color colorButton;

  const MyCardItem({this.onPressed, this.textInfo, this.colorContainer, this.colorButton}) ;




  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
        color: this.colorContainer,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  this.textInfo,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  child: FlatButton.icon(
                    splashColor: Colors.white.withOpacity(0),
                    shape: CircleBorder(),
                    icon: Icon(
                      Icons.check,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: this.onPressed,
                    label: Text(
                      "حجز",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: this.colorButton,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),),);
  }
}

class MyIconWidget extends StatelessWidget {
  final IconData icon;
  final Color colorIcon;
  final Color colorContainer;
  final Function onPressed;

  MyIconWidget(
      {this.icon, this.onPressed, this.colorIcon, this.colorContainer});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(
          this.icon,
          size: 20,
          color: this.colorIcon,
        ),
        onPressed: this.onPressed,
      ),
      decoration: BoxDecoration(
          color: this.colorContainer, borderRadius: BorderRadius.circular(20)),
    );
  }
}
