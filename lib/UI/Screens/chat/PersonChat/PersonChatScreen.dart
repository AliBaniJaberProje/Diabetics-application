import 'package:ali_muntaser_final_project/UI/Screens/chat/MsgChat/MessagesScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/MessagesProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/PersonProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PersonChatScreen extends StatefulWidget {
  @override
  _PersonChatScreenState createState() => _PersonChatScreenState();
}

class _PersonChatScreenState extends State<PersonChatScreen> {
  bool _isloaded = true;
  @override
  void initState() {
    super.initState();
    context.read<PersonChatProvider>().clearPreavesDoctors();
    context.read<PersonChatProvider>().fetchDoctors().then((value) {
      setState(() {
        _isloaded = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _PersonChatProvider = context.read<PersonChatProvider>();
    var _ChatProvider = context.read<MessagesProvider>();
    var _ProfileProvider = context.read<ProfileProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isloaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                final docturobj = _PersonChatProvider.getDoctur(index);
                return Column(
                  children: [
                    InkWell(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${docturobj.getFormatLastMsgTime()}"),
                            docturobj.getNumberMsg() != 0
                                ? Container(
                                    margin: EdgeInsets.only(top: 5, left: 15),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(.4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "${docturobj.getNumberMsg()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18),
                                      textAlign: TextAlign.end,
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 30,
                                    right: 1,
                                  ),
                                  child: Text(
                                    docturobj.getName(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                Text(
                                  docturobj.getlastmsg(),
                                  style: TextStyle(
                                      color: Colors.purple, fontSize: 15),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, right: 10),
                              child: CircularProfileAvatar(
                                docturobj.getImgURL(),
                                borderWidth: 3,
                                borderColor: Colors.purple,
                                backgroundColor: Colors.purple.withOpacity(.4),
                                radius: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        _PersonChatProvider.showmsgForthisDoctur(
                            docturobj.getId());
                        _ChatProvider.setImgUrlSender(
                            _ProfileProvider.getImgUrl());
                        _ChatProvider.setImgRecever(docturobj.getImgURL());
                        _ChatProvider.setSenderId(_ProfileProvider.getId());
                        _ChatProvider.setReceverId(docturobj.getId());
                        _ChatProvider.setUserNameDoctor(docturobj.getName());
                        _ChatProvider.setStatusRecever(docturobj.isOnline());

                        Navigator.pushReplacementNamed(
                          context,
                          MessagesScreen.routeName,
                        );
                      },
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                );
              },
              itemCount: _PersonChatProvider.getNumberDoctur(),
            ),
    );
  }
}
