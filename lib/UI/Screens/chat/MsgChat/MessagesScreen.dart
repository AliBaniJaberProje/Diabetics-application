import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/core/Model/messageStruct.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/chatProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/doctorChatProvider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

// ignore: must_be_immutable
class BubbleMessage extends StatelessWidget {
  MessageStruct msg;

   BubbleMessage({this.msg});

  @override
  Widget build(BuildContext context) {
    return msg.isMe
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ChatBubble(
                clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
                alignment: Alignment.topRight,
                elevation: 3,
                margin: EdgeInsets.only(top: 3, bottom: 3),
                backGroundColor: Colors.purple,
                child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        msg.isImageMessage()
                            ? Image.network(msg.data,loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },)
                            : Text(
                                msg.data,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                        Wrap(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.end,
                              children: [
                                Text(
                                  msg.getTimeSendFormat(),
                                  style: TextStyle(color: Colors.yellow),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  msg.isSeen
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.check,
                                  color: Colors.yellow,
                                ),
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
                  context.read<ChatProvider>().imgUrlPatient,
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
                  context.read<ChatProvider>().imgUrlDoctor,
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
                      msg.isImageMessage()
                          ? Image.network(msg.data,loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },)
                          : Text(
                              msg.data,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                      Wrap(
                        alignment: WrapAlignment.end,
                        children: [
                          Text(
                            msg.getTimeSendFormat(),
                            style: TextStyle(color: Colors.purple),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
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
    var chatProvider = context.read<ChatProvider>();


    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: new TextField(
                textAlign: TextAlign.end,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: meesageController,
                onTap: ()=>context.read<ChatProvider>().updateAccessTimePatient(),
                onChanged: (val) {
                  setState(() {
                    msgToSendText = val.trim();
                  });
                },
                decoration: new InputDecoration.collapsed(
                    hintText: 'اكتب رسالة... ', hintStyle: TextStyle()),
              ),
            ),
          ),
          Container(
            child: FlatButton.icon(
              label: Text(""),
              onPressed: msgToSendText.isEmpty
                  ? null
                  : () {
                      chatProvider.sendMessage(
                        data: msgToSendText,
                        type: "text",
                      );

                      meesageController.clear();
                      msgToSendText = "";
                    },
              icon: Icon(
                Icons.send,
                size: 25,
                color: Colors.purple,
              ),
              //backgroundColor: Colors.purple,
            ),
          ),
          Container(
            child: FlatButton.icon(
              label: Text(""),
              onPressed: () {
                var alertDialog = AlertDialog(
                  title: Text(
                    "اختيار الصورة من ",
                    textAlign: TextAlign.end,
                  ),
                  content: Container(
                    height: 150,
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.black,
                        ),
                        Container(
                          width: 300,
                          color: Colors.purple,
                          child: ListTile(
                            trailing: Icon(Icons.image),
                            title: Text(
                              "صوري",
                              textAlign: TextAlign.end,
                            ),
                            onTap: () {
                              chatProvider
                                  .getImageUrlToSend(ImageSource.gallery)
                                  .then((imgurl) {
                                if (imgurl != null && imgurl.isNotEmpty) {
                                  chatProvider.sendMessage(
                                      data: imgurl, type: "image");
                                }
                              });

                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          color: Colors.purple,
                          child: ListTile(
                              trailing: Icon(Icons.camera_alt),
                              title: Text(
                                "الكميرا",
                                textAlign: TextAlign.end,
                              ),
                              onTap: () {
                                chatProvider
                                    .getImageUrlToSend(ImageSource.camera)
                                    .then((imgurl) {
                                  if (imgurl != null && imgurl.isNotEmpty) {
                                    chatProvider.sendMessage(
                                        data: imgurl, type: "image");
                                  }
                                  print(imgurl);
                                });
                                Navigator.of(context).pop();
                              }),
                        )
                      ],
                    ),
                  ),
                );
                showDialog(context: context, child: alertDialog);
              },
              icon: Icon(
                Icons.photo_camera,
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


class CantAccessChatWidget extends StatelessWidget {
  const CantAccessChatWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.purple,
      alignment: Alignment.bottomCenter,
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
    );
  }
}

class MessagesScreen extends StatefulWidget {
  static String routeName = "/MyWaveClipper";

  @override
  _MessagesScreen createState() => _MessagesScreen();
}

class _MessagesScreen extends State<MessagesScreen> {
  bool isSeen = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatProvider>().startListenLastAccessTimeDoctor();
    context.read<ChatProvider>().startStreamChat();

    //  context.read<ChatProvider>().fetchLastMessages();

    // final fbm =FirebaseMessaging();
    // fbm.configure(onMessage: (msg){
    //   print(msg);
    //   return ;
    // },
    // onLaunch: (msg){
    //   print(msg);
    //   return ;
    // },
    // onResume: (msg){
    //   print(msg);
    //   return ;
    // }
    // );
    // fbm.subscribeToTopic("chat");
    // fbm.subscribeToTopic("testnot");
    // fbm.getToken().then((value) {
    //   print(value);
    // });
    //
    // fbm.subscribeToTopic("notification_msg");
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(

                margin: EdgeInsets.only(right: 30),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                    context.read<ChatProvider>().clearChatWhenClose();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 40),
                child: Icon(
                  Icons.circle,
                  color: Colors.yellow,
                  size: 15,
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 40),
                child: Text(
                  context.read<ChatProvider>().usernameDoctor,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 4),
                child: CircularProfileAvatar(
                  context.watch<ChatProvider>().imgUrlDoctor,
                  borderWidth: 2,
                  borderColor: Colors.yellow,
                  backgroundColor: Colors.purple.withOpacity(.4),
                 radius: 25,
                ),
              ),
            ],
          ),)
        ],
      ),
        body: Container(
      child: Column(
        children: [
          // HeaderChatScreen(),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: context.watch<ChatProvider>().getNumberMessages(),
              itemBuilder: (ctx, index){

                return BubbleMessage(msg: context.read<ChatProvider>().getMessageAt(index : index),);
              }
            ),
          ),
          if(context.read<ChatProvider>().idDoctor==context.read<DoctorChatProvider>().currentDoctorId)
          NewMessage(),
          if(context.read<ChatProvider>().idDoctor!=context.read<DoctorChatProvider>().currentDoctorId)
            CantAccessChatWidget(),
        ],
      ),
    ),);
    //  HeaderChatScreen(),
    // StreamBuilder(
    //   stream: _messagesProvider.fetchStreamMessages(
    //       _messagesProvider.getIdSenderPatient(),
    //       _messagesProvider.getReceverId()),
    //   builder: (context, snap) {
    //     if (snap.hasData &&
    //         !snap.hasError &&
    //         snap.data.snapshot.value != null) {
    //       Map data = snap.data.snapshot.value;
    //       List item = [];
    //
    //       data.forEach((index, data) {
    //         item.add({"key": index, ...data});
    //       });
    //
    //       return Expanded(
    //         child: ListView.builder(
    //           reverse: true,
    //           itemCount: item.length,
    //           itemBuilder: (context, index) {
    //             item.sort((b, a) {
    //               return int.parse(a['timestamp'].toString()).compareTo(
    //                 int.parse(
    //                   b['timestamp'].toString(),
    //                 ),
    //               );
    //             });
    //
    //             if (item[item.length - 1]["lastaccesstimedoctor"] >
    //                 item[index]["timestamp"]) {
    //               isSeen = true;
    //             } else {
    //               isSeen = false;
    //             }
    //             if (item[index]["key"] != "time") {
    //               return Container(
    //                 child: BubbleMessage(
    //                   msg: Message(
    //                     message: item[index]["message"],
    //                     isShow: isSeen,
    //                     isme: item[index]["isPatient"],
    //                     typemessage: item[index]["type"],
    //                     timesend: Timestamp.fromMicrosecondsSinceEpoch(
    //                       item[index]["timestamp"],
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             } else {
    //               return Center(
    //                 child: Text(""),
    //               );
    //             }
    //           },
    //         ),
    //       );
    //     }
    //     if (snap.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else
    //       return Center(
    //         child: Text("لا نوجد محادثه سابقه"),
    //       );
    //   },
    // ),
    // if (context.read<MessagesProvider>().getReceverId() ==
    //     StoragToPassDotorsId.idCurantDuctor)
    //   NewMessage(),
    // if (context.read<MessagesProvider>().getReceverId() !=
    //     StoragToPassDotorsId.idCurantDuctor)
    //   CantAccessChatWidget(),
  }
}
