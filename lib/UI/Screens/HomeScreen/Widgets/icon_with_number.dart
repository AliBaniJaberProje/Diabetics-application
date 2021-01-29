import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconWithNumber extends StatelessWidget {

  final IconData icon;
  final int number;

  IconWithNumber({@required this.icon,@required this.number});


  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Stack(
        children: <Widget>[
          Icon(icon,size: 30,),
          Positioned(
            right: 0,
            child: number>0? Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                maxWidth: 30,
                minHeight: 12,
              ),
              child: Text('${number}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
                textAlign: TextAlign.center,
              ),
            ):ClipRRect(),
          ),
        ],
      ),
    );
  }
}
