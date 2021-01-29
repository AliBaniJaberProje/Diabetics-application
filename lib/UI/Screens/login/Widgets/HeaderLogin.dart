


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FadeAnimation.dart';

class HeaderLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login1.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      width: 80,
                      height: 200,
                      left: 30,
                      child: FadeAnimation(
                        1.6,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/light-1.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: 80,
                      height: 150,
                      left: 140,
                      child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/light-2.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 30,
                      top: 40,
                      height: 150,
                      width: 80,
                      child: FadeAnimation(
                        1.6,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/clock.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeAnimation(
                        2,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "تسجيل الدخول ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
