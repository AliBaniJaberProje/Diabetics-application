import 'package:flutter/material.dart';
import 'package:sliding_card/sliding_card.dart';




class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purpleAccent[100];
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 1,
        size.width * 1.0, size.height * 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}



//
// class TestCard extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         title: Text("Stack Two Containers"),
//         backgroundColor: Colors.purpleAccent,
//       ),
//
//       body: Center(
//         child: Stack(
//           children: [
//             Card(
//               elevation: 6,
//               child: Container(
//                 color: Colors.deepPurple[100],
//                 width: double.infinity,
//                 height: 110,
//                 child: CustomPaint(
//                   painter: CurvePainter(),
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 Card(child: Icon(Icons.close),elevation: 9,)
//
//               ],
//             ),
//
//           ],
//         )
//       ),
//
//       // body: ListView(
//       //   children: [
//       //     Container(
//       //       height: 100,
//       //       margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
//       //       decoration: BoxDecoration( //decoration for the outer wrapper
//       //         color: Colors.deepOrange,
//       //         borderRadius: BorderRadius.circular(30), //border radius exactly to ClipRRect
//       //         boxShadow:[
//       //           BoxShadow(
//       //             color: Colors.grey.withOpacity(0.5), //color of shadow
//       //             spreadRadius: 5, //spread radius
//       //             blurRadius: 7, // blur radius
//       //             offset: Offset(0, 2), // changes position of shadow
//       //             //first paramerter of offset is left-right
//       //             //second parameter is top to down
//       //           ),
//       //           //you can set more BoxShadow() here
//       //         ],
//       //       ) ,
//       //       child: ClipRRect( //to clip overflown positioned containers.
//       //         borderRadius: BorderRadius.circular(30),
//       //         //if we set border radius on container, the overflown content get displayed at corner.
//       //         child:Container(
//       //
//       //             child: Stack(children: <Widget>[ //Stack helps to overlap widgets
//       //               Positioned( //positioned helps to position widget wherever we want.
//       //                   top:-20, left:-50, //position of the widget
//       //                   child:Container(
//       //                       height:250,
//       //                       width:250,
//       //                       decoration:BoxDecoration(
//       //                           shape:BoxShape.circle,
//       //                           color:Colors.purpleAccent.withOpacity(1) //background color with opacity
//       //                       )
//       //                   )
//       //               ),
//       //
//       //               Positioned(
//       //                   left:-80,top:-50,
//       //                   child:Container(
//       //                       height:180,
//       //                       width:180,
//       //                       decoration:BoxDecoration(
//       //                           shape:BoxShape.circle,
//       //                           color:Colors.purpleAccent.withOpacity(1)
//       //                       )
//       //                   )
//       //               ),
//       //
//       //               Positioned(  //main content container postition.
//       //                 child: Container(
//       //                     height:250,
//       //                     alignment: Alignment.center,
//       //                     child:Text("المستخدم الاول", style: TextStyle(
//       //                       color:Colors.white, fontSize:20,
//       //                     ),
//       //                       textAlign: TextAlign.center,
//       //                     )
//       //                 ),
//       //               )
//       //             ],)
//       //         ),
//       //       ),
//       //     ),
//       //     Container(
//       //       height: 100,
//       //       margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
//       //       decoration: BoxDecoration( //decoration for the outer wrapper
//       //         color: Colors.deepPurple,
//       //         borderRadius: BorderRadius.circular(30), //border radius exactly to ClipRRect
//       //         boxShadow:[
//       //           BoxShadow(
//       //             color: Colors.grey.withOpacity(0.5), //color of shadow
//       //             spreadRadius: 5, //spread radius
//       //             blurRadius: 7, // blur radius
//       //             offset: Offset(0, 2), // changes position of shadow
//       //             //first paramerter of offset is left-right
//       //             //second parameter is top to down
//       //           ),
//       //           //you can set more BoxShadow() here
//       //         ],
//       //       ) ,
//       //       child: ClipRRect( //to clip overflown positioned containers.
//       //         borderRadius: BorderRadius.circular(30),
//       //         //if we set border radius on container, the overflown content get displayed at corner.
//       //         child:Container(
//       //
//       //             child: Stack(children: <Widget>[ //Stack helps to overlap widgets
//       //               Positioned( //positioned helps to position widget wherever we want.
//       //                   top:-20, left:-50, //position of the widget
//       //                   child:Container(
//       //                       height:250,
//       //                       width:250,
//       //                       decoration:BoxDecoration(
//       //                           shape:BoxShape.circle,
//       //                           color:Colors.purpleAccent.withOpacity(1) //background color with opacity
//       //                       )
//       //                   )
//       //               ),
//       //
//       //               Positioned(
//       //                   left:-80,top:-50,
//       //                   child:Container(
//       //                       height:180,
//       //                       width:180,
//       //                       decoration:BoxDecoration(
//       //                           shape:BoxShape.circle,
//       //                           color:Colors.purpleAccent.withOpacity(1)
//       //                       )
//       //                   )
//       //               ),
//       //
//       //               Positioned(  //main content container postition.
//       //                 child: Container(
//       //                     height:250,
//       //                     alignment: Alignment.center,
//       //                     child:Text("المستخدم الاول", style: TextStyle(
//       //                       color:Colors.white, fontSize:20,
//       //                     ),
//       //                       textAlign: TextAlign.center,
//       //                     )
//       //                 ),
//       //               )
//       //             ],)
//       //         ),
//       //       ),
//       //     ),
//       //   ],
//       // )
//     );
//   }
// }

class TestCard extends StatefulWidget {
  static String routName = "TestCard";
  @override
  _TestCardState createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
  SlidingCardController controller ;
  @override
  void initState() {

    super.initState();
    controller = SlidingCardController();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(



            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




// class DolDurmaClipper extends CustomClipper<Path> {
//   DolDurmaClipper({@required this.right, @required this.holeRadius});
//
//   final double right;
//   final double holeRadius;
//
//   @override
//   Path getClip(Size size) {
//     final path = Path()
//       ..moveTo(0, 0)
//       ..lineTo(size.width - right - holeRadius, 0.0)
//       ..arcToPoint(
//         Offset(size.width - right, 0),
//         clockwise: false,
//         radius: Radius.circular(1),
//       )
//       ..lineTo(size.width, 0.0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width - right, size.height)
//       ..arcToPoint(
//         Offset(size.width - right - holeRadius, size.height),
//         clockwise: false,
//         radius: Radius.circular(1),
//       );
//
//     path.lineTo(0.0, size.height);
//
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(DolDurmaClipper oldClipper) => true;
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           //   color: Colors.pink,
//           child: Center(
//         child: Container(
//             width: double.infinity,
//             margin: EdgeInsets.symmetric(horizontal: 5),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.purpleAccent,
//             ),
//             height: 200,
//             child: Stack(
//               children: [
//                 Container(
//
//                     // shadowColor: Colors.amberAccent,
//                     // elevation: 9,
//
//                     ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(15),
//                             bottomLeft: Radius.circular(15)),
//                         color: Colors.grey[400],
//                       ),
//                       width: 100,
//                       height: double.infinity,
//                     ),
//                     Container(
//                       height: 150,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.red,
//                       ),
//                       child: ClipRect(
//                         clipBehavior: Clip.hardEdge,
//                         child: OverflowBox(
//                           maxHeight: 250,
//                           maxWidth: 250,
//                           child: Center(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                       Column(
//                       //  crossAxisAlignment:  CrossAxisAlignment.end,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(right: 3, top: 10),
//                           margin: EdgeInsets.only(bottom: 10),
//                           alignment: Alignment.topRight,
//                           child: CircularProfileAvatar(
//                             "https://www.tubefilter.com/wp-content/uploads/2018/07/merrell-twins.jpg",
//                             borderWidth: 2,
//                             progressIndicatorBuilder: (c, d, e) {
//                               return CircularProgressIndicator();
//                             },
//                             borderColor: Colors.black,
//                             backgroundColor: Colors.yellow,
//                             radius: 40,
//                           ),
//                         ),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 30, vertical: 0),
//                           child: Text("الدكتور احمد عبدالحق"),
//                         )
//                       ],
//                     ),
//                   ],
//                 )
//
//                 // Row(
//                 //   children: [
//                 //     Container(
//                 //       color: Colors.yellow,
//                 //       height: double.infinity,
//                 //       width: (MediaQuery.of(context).size.width -4)/3,
//                 //
//                 //       child: Icon(Icons.east),
//                 //     ),
//                 //     Container(
//                 //       color: Colors.yellow,
//                 //       height: double.infinity,
//                 //       width: (MediaQuery.of(context).size.width+8)/3,
//                 //
//                 //       child: Icon(Icons.east),
//                 //     ),
//                 //     Container(
//                 //       color: Colors.yellow,
//                 //       height: double.infinity,
//                 //       width: (MediaQuery.of(context).size.width -4)/3,
//                 //
//                 //       child: Icon(Icons.east),
//                 //     ),
//                 //
//                 //   ],
//                 // ),
//               ],
//             )),
//       )),
//     );
//   }
// }
