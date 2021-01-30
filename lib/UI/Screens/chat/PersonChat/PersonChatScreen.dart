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
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      "${context.watch<PersonChatProvider>().getDoctur(index).getFormatLastMsgTime()}"),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 15),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${context.watch<PersonChatProvider>().getDoctur(index).getNumberMsg()}",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                      textAlign: TextAlign.end,
                    ),
                  ),
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
                          context
                              .watch<PersonChatProvider>()
                              .getDoctur(index)
                              .getName(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Text(
                        context
                            .watch<PersonChatProvider>()
                            .getDoctur(index)
                            .getlastmsg(),
                        style: TextStyle(color: Colors.purple, fontSize: 15),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ],
                  ),
                
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                    child: CircularProfileAvatar(
                      context
                          .watch<PersonChatProvider>()
                          .getDoctur(index)
                          .getImgURL(),
                      borderWidth: 3,
                      borderColor: Colors.purple,
                      backgroundColor: Colors.purple.withOpacity(.4),
                      radius: 40,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
        itemCount: context.watch<PersonChatProvider>().getNumberDoctur(),
      ),
    );
  }
}
