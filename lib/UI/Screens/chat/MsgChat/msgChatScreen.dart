import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/core/Model/Person.dart';
import 'package:ali_muntaser_final_project/core/Model/msg.dart';
import 'package:ali_muntaser_final_project/core/Providers/MsgProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/messageProvider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoobleMessage extends StatelessWidget {
  final Person person;
  final Msg msg;

  const BoobleMessage({this.person, this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .07,
      child: !msg.isMe()
          ? Row(
              //doctur
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4, bottom: 4, left: 5),
                  child: CircularProfileAvatar(
                    person.getImgURL(),
                    borderWidth: 2,
                    borderColor: Colors.yellow,
                    backgroundColor: Colors.purple.withOpacity(.4),
                    radius: 25,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 6),
                  //width: MediaQuery.of(context).size.width * .4,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(.7),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Text(
                    msg.getMessage(),
                    style: TextStyle(),
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            )
          : Row(
              //me
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 6),
                  //width: MediaQuery.of(context).size.width * .4,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(.7),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                  child: Text(
                    msg.getMessage(),
                    style: TextStyle(),
                    textAlign: TextAlign.end,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4, bottom: 4, left: 5),
                  child: CircularProfileAvatar(
                    context.watch<ProfileProvider>().getImgUrl(),
                    borderWidth: 2,
                    borderColor: Colors.yellow,
                    backgroundColor: Colors.purple.withOpacity(.4),
                    radius: 25,
                  ),
                ),
              ],
            ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  static String routeName = "/MyWaveClipper";

  @override
  Widget build(BuildContext context) {
    final docturobj =
        ModalRoute.of(context).settings.arguments as Map<String, Person>;
    final doctur = docturobj["person"];
    context.read<MsgProvider>().setMsgFromServerForThisDoctur(doctur);

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            child: Container(
              padding: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 40),
                    child: doctur.isOnline()
                        ? Icon(
                            Icons.circle,
                            color: Colors.yellow,
                            size: 20,
                          )
                        : Text(""),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      doctur.getName(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    child: CircularProfileAvatar(
                      doctur.getImgURL(),
                      borderWidth: 2,
                      borderColor: Colors.yellow,
                      backgroundColor: Colors.purple.withOpacity(.4),
                      radius: 40,
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                reverse: true,
                itemBuilder: (ctx, index) => Container(
                  child: BoobleMessage(
                    person: doctur,
                    msg: context.watch<MsgProvider>().getMSG(index),
                  ),
                ),
                itemCount: context.watch<MsgProvider>().getNumberMsg(),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.amberAccent,
            height: 60,
            child: Text("new mesaage"),
          ),

          // ListView.builder(
          //   itemCount: context.watch<MessageProvider>().getNumberOfMsg(),
          //   itemBuilder: (ctx, index) => Container(
          //     child: Text("123"),
          //   ),
          // )
        ],
      ),
    );
  }
}
