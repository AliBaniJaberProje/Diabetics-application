import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/core/Model/msg.dart';
import 'package:ali_muntaser_final_project/core/Providers/ChatProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/Servies_api/doctorsToShowInChat.dart';

import 'package:flutter/painting.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';

class BubbleMessage extends StatelessWidget {
  final Msg msg;

  const BubbleMessage({this.msg});

  @override
  Widget build(BuildContext context) {
    return msg.isMe()
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ChatBubble(
                clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
                alignment: Alignment.topRight,
                elevation: 3,
                margin: EdgeInsets.only(top: 3, bottom: 3),
                backGroundColor: Colors.purple[300],
                child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          msg.message,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        //Icon(Icons.remove_red_eye_outlined,size: 17,),
                        Wrap(
                          //alignment: WrapAlignment.spaceBetween,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.end,
                              children: [
                                Text(
                                  msg.getTimeSendFormat(),
                                  style: TextStyle(color: Colors.yellow),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  msg.isShow
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.check,
                                  color: Colors.yellow,
                                ),
                                // Icon(
                                //   Icons.check,
                                //   size: 13,
                                // ),
                                // Icon(
                                //   Icons.check,
                                //   size: 13,
                                // ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 4,
                ),
                child: CircularProfileAvatar(
                  context.read<ChatProvider>().getImgUrlSender(),
                  borderWidth: 2,
                  borderColor: Colors.yellow,
                  backgroundColor: Colors.purple.withOpacity(.4),
                  radius: 25,
                ),
              ),
            ],
          )
        : Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                ),
                child: CircularProfileAvatar(
                  context.read<ChatProvider>().getImgUrlRecever(),
                  borderWidth: 2,
                  borderColor: Colors.yellow,
                  backgroundColor: Colors.purple.withOpacity(.4),
                  radius: 25,
                ),
              ),
              ChatBubble(
                clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
                backGroundColor: Color(0xffE7E7ED),
                margin: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Column(
                      children: [
                        Text(
                          msg.message,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Wrap(
                          //alignment: WrapAlignment.spaceBetween,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.end,
                              children: [
                                Text(
                                  msg.getTimeSendFormat(),
                                  style: TextStyle(color: Colors.purple),
                                ),
                                // SizedBox(
                                //   width: 15,
                                // ),
                                // Icon(
                                //   Icons.remove_red_eye_outlined,
                                //   size: 17,
                                // ),
                                // Icon(
                                //   Icons.check,
                                //   size: 13,
                                // ),
                                // Icon(
                                //   Icons.check,
                                //   size: 13,
                                // ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
              )
            ],
          );

    ;
  }
}

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var meesageController = TextEditingController();

  String msgToSendText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //  color: Colors.amberAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,

              // here's the actual text box
              child: new TextField(
                textAlign: TextAlign.end,
                keyboardType: TextInputType.multiline,
                maxLines: null, //grow automatically

                controller: meesageController,
                onTap: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(context.read<ChatProvider>().getIdSender())
                      .update({"lastAccessTime": Timestamp.now()});
                },
                onChanged: (val) {
                  setState(() {
                    msgToSendText = val.trim();
                  });
                },
                //   onSubmitted: currentIsComposing ? _handleSubmitted : null,
                decoration: new InputDecoration.collapsed(
                    hintText: 'اكتب رسالة ', hintStyle: TextStyle()),
              ),
            ),
          ),
          Container(
            child: FlatButton.icon(
              label: Text(""),
              onPressed: msgToSendText.isEmpty
                  ? null
                  : () async {
                      await FirebaseFirestore.instance
                          .collection("chat")
                          .doc(context.read<ChatProvider>().getIdSender())
                          .collection(
                              context.read<ChatProvider>().getReceverId())
                          .add({
                        'isPatient': true,
                        'isShow': false,
                        'text': meesageController.text,
                        'timeSend': Timestamp.now(),
                      });

                      // await FirebaseFirestore.instance.collection("users").doc(context.read<ChatProvider>().getIdSender()).update({
                      //   "lastmsgtime":Timestamp.now(),
                      // });
                      //   await FirebaseFirestore.instance.collection("users").doc(context.read<ChatProvider>().getReceverId()).update({
                      //   "lastmsgtime":Timestamp.now(),
                      // });
                      //  FirebaseFirestore.instance
                      //     .collection("users")
                      //     .doc(context.read<ChatProvider>().getIdSender())
                      //     .update({"lastAccessTime": Timestamp.now()});

                      // setState(() {
                      //   meesageController.clear();
                      //   msgToSendText = "";
                      // });
                    },
              icon: Icon(
                Icons.send,
                size: 25,
                color: Colors.purple,
              ),
              //backgroundColor: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  static String routeName = "/MyWaveClipper";

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   void initState() {
//     super.initState();

//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(context.read<ChatProvider>().getIdSender())
//         .update({"lastAccessTime": Timestamp.now()}).then((value) {});

//     FirebaseFirestore.instance
//         .collection("users")
//         .doc(context.read<ChatProvider>().getReceverId())
//         .get()
//         .then((value) {
//       context
//           .read<ChatProvider>()
//           .setTimeLastAccessChat(value["lastAccessTime"] as Timestamp);
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 130,
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
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 40),
                    child: context.watch<ChatProvider>().isOnline()
                        ? Icon(
                            Icons.circle,
                            color: Colors.yellow,
                            size: 20,
                          )
                        : Icon(
                            Icons.trip_origin_rounded,
                            color: Colors.yellow,
                            size: 20,
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      context.watch<ChatProvider>().getUserNameDoctor(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    child: CircularProfileAvatar(
                      context.watch<ChatProvider>().getImgUrlRecever(),
                      borderWidth: 2,
                      borderColor: Colors.yellow,
                      backgroundColor: Colors.purple.withOpacity(.4),
                      radius: 30,
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chat")
                  .doc(context
                      .read<ProfileProvider>()
                      .getId()) //context.read<ProfileProvider>().getId()
                  .collection(context
                      .read<ChatProvider>()
                      .getReceverId()) //context.read<ChatProvider>().getReceverId()
                  .orderBy('timeSend', descending: true)
                  .snapshots(),
              builder: (ctx, snapshot) {
                // print("chat" +
                //     "${ctx.read<ProfileProvider>().getId()}" +
                //     "${ctx.read<ChatProvider>().getReceverId().toString()}");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {

                  return Expanded(
                    child: Container(
                      child: ListView.builder(
                        reverse: true,
                        itemBuilder: (ctx, index) {


                          return Container(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(context
                                        .read<ChatProvider>()
                                        .getReceverId())
                                    .snapshots(),
                                builder: (ctx, po) {
                                  int compervar = (snapshot.data.docs[index]
                                          ["timeSend"] as Timestamp)
                                      .compareTo(po.data["lastAccessTime"]
                                          as Timestamp);

                                  bool isSeen = false;
                                  if (compervar <= 0) {
                                    isSeen = true;
                                  }
                                  if (po.connectionState ==
                                          ConnectionState.waiting ||
                                      po.data == null) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return BubbleMessage(
                                      msg: Msg(
                                        message: snapshot.data.docs[index]
                                            ["text"],
                                        isShow: isSeen,
                                        isme: snapshot.data.docs[index]
                                            ["isPatient"],
                                        timesend: snapshot.data.docs[index]
                                            ["timeSend"],
                                      ),

                                      //isPatient
                                    );
                                  }
                                }),
                          );
                        },
                        itemCount: snapshot.data.documents.length,
                      ),
                    ),
                  );
                }
              }),
          if (context.read<ChatProvider>().getReceverId() ==
              StoragToPassDotorsId.idCurantDuctor)
            NewMessage(),
          if (context.read<ChatProvider>().getReceverId() !=
              StoragToPassDotorsId.idCurantDuctor)
            Container(
              width: double.infinity,
              color: Colors.purple,
              alignment: Alignment.center,
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      " لا يمكنك الارسال لطبيبك السابق",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.lock,
                      size: 25,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// FloatingActionButton(

// TextField(
//               keyboardType: TextInputType.multiline,
//               controller: meesageController,
//               decoration: InputDecoration(
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               onChanged: (val) {
//                 setState(() {
//                   msgToSendText = val.trim();
//                 });
//               },
//             ),
