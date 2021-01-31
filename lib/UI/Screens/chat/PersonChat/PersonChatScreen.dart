import 'package:ali_muntaser_final_project/UI/Screens/chat/MsgChat/msgChatScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/PersonProvider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemBuilder: (context, index) {
              final docturobj =
                  context.watch<PersonChatProvider>().getDoctur(index);
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
                        context.read<PersonChatProvider>().showmsgForthisDoctur(
                              docturobj.getId(),
                            );
                        Navigator.pushReplacementNamed(
                            context, ChatScreen.routeName,
                            arguments: {"person": docturobj});
                      }),
                  Divider(
                    color: Colors.black,
                  ),
                ],
              );
            },
            itemCount: context.watch<PersonChatProvider>().getNumberDoctur()));
  }
}
