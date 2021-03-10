
import 'package:ali_muntaser_final_project/UI/Screens/chat/MsgChat/MessagesScreen.dart';
import 'package:ali_muntaser_final_project/core/Model/doctorChatStruct.dart';
import 'package:ali_muntaser_final_project/core/Providers/MessagesProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/chatProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/doctorChatProvider.dart';
import 'package:ali_muntaser_final_project/core/Servies_api/nodeServers/PatientServes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PersonCardChat extends StatelessWidget {
  DoctorChatStruct _doctorChat;
  PersonCardChat({DoctorChatStruct doctor}) {
    this._doctorChat = doctor;
  }
  @override
  Widget build(BuildContext context) {
    var _doctorChatProvider=context.read<DoctorChatProvider>();
    bool isValidDoctor =
        _doctorChat.id == _doctorChatProvider.currentDoctorId;
    return Column(
      children: [
        InkWell(
          child: Container(
            height: 100,
            //color: Colors.grey.withOpacity(.5),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Container(
                    width: 50,
                    padding: new EdgeInsets.only(left: 10.0, right: 10.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(10),
                          child: isValidDoctor
                              ? _doctorChat.isOnline()
                                  ? Icon(
                                      Icons.circle,
                                      color: Colors.purple,
                                      size: 20,
                                    )
                                  : Icon(
                            Icons.radio_button_off,
                                      color: Colors.purple,
                                      size: 20,
                                    )
                              : Icon(
                                  Icons.lock,
                                  size: 20,
                                  color: Colors.purple,
                                ),
                        )
                      ],
                    )),
                Container(
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          _doctorChat.name,
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  //  color: Colors.pinkAccent.withOpacity(.2),
                  margin: EdgeInsets.only(left: 15),
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35,
                      child: ClipOval(
                        child: Image.network(
                          _doctorChat.imgUrl,
                          fit: BoxFit.fill,
                          width: 100,
                          height: 100,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          splashColor: Colors.purple.withOpacity(.3),
          highlightColor: Colors.purple.withOpacity(.1),
          onTap: () {

            context.read<MessagesProvider>().setSenderId(context.read<DoctorChatProvider>().idPatient);
            context.read<MessagesProvider>().setImgUrlSender(context.read<DoctorChatProvider>().imgurlPatient);
            context.read<MessagesProvider>().setUserNameDoctor(_doctorChat.name);
            context.read<MessagesProvider>().setReceverId(_doctorChat.id);
            context.read<MessagesProvider>().setImgRecever(_doctorChat.imgUrl);
            context.read<MessagesProvider>().online=_doctorChat.online;
            Navigator.pushReplacementNamed(context, MessagesScreen.routeName);
          },
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.purple,
        )
      ],
    );
  }
}

class PersonChatScreen extends StatefulWidget {
  @override
  _PersonChatScreenState createState() => _PersonChatScreenState();
}

class _PersonChatScreenState extends State<PersonChatScreen> {
  bool _isloaded = true;
  @override
  void initState() {
    super.initState();
    var _doctorChatProvider = context.read<DoctorChatProvider>();

    _doctorChatProvider.fetchDoctors().then((value) {
      setState(() {
        _isloaded = false;
      });


    });

    // _doctorChatProvider.fetchDoctors().then((value) {
    //   setState(() {
    //     _isloaded = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    var _doctorChatProvider = context.read<DoctorChatProvider>();
    return Scaffold(
      // backgroundColor: Colors.white,
      body: _isloaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _doctorChatProvider.numberOfDoctor(),
              itemBuilder: (context, index) {
                return PersonCardChat(
                  doctor: _doctorChatProvider.getDotorAt(index),
                );
              },
            ),
    );
  }
}
