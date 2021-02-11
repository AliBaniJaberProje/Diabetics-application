import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/Widgets/body_hone_page.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/Providers/ProfileProvider.dart';

Color colorOne = Colors.purple.withOpacity(.02);
Color colorTwo = Colors.purple[300];
Color colorThree = Colors.purple[100];

final appTheme = ThemeData(
  primarySwatch: Colors.purple,
);

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.70,
        size.width * 0.17, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.20, size.height, size.width * 0.25, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.40,
        size.width * 0.50, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.85,
        size.width * 0.65, size.height * 0.65);
    path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.90, size.width, 0);
    path.close();

    paint.color = colorThree;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
        size.width * 0.15, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
        size.width * 0.27, size.height * 0.60);
    path.quadraticBezierTo(
        size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
        size.width * 0.75, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorTwo;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.55,
        size.width * 0.22, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.90,
        size.width * 0.40, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.52, size.height * 0.50,
        size.width * 0.65, size.height * 0.70);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.85, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = colorOne;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 300.0,
      ),
      painter: CurvePainter(),
    );
  }
}

class MyPersonScreen extends StatefulWidget {
  static String routeName = "/MyPersonScreen";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyPersonScreen> {
  double updateWeight;
  double updateLength;
  String updatePhone;
  String updateLocation;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _formKey1 = GlobalKey();
  final GlobalKey<FormState> _formKey2 = GlobalKey();
  final GlobalKey<FormState> _formKey3 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
            ),
            Container(
              child: Text(
                "ملفي الشخصي",
              ),
              padding: EdgeInsets.all(10),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              HeaderContainer(
                showname: false,
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                child: ListTile(
                  trailing: Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "${context.watch<ProfileProvider>().getUserName()}",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  trailing: Icon(
                    Icons.date_range,
                    size: 35,
                    color: Colors.purple,
                  ),
                  title: Text(
                    context.watch<ProfileProvider>().getDateBirth(),
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  trailing: Icon(
                    Icons.info,
                    size: 35,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "${context.watch<ProfileProvider>().getId()}", //context.watch<ProfileProvider>().getId()
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  leading: !context.watch<ProfileProvider>().getUpdatePhone()
                      ? FlatButton.icon(
                          onPressed: () {
                            context.read<ProfileProvider>().toggleUpdatePhone();
                          },
                          icon: Icon(Icons.edit),
                          label: Text(""))
                      : FlatButton.icon(
                          onPressed: () {
                            context.read<ProfileProvider>().toggleUpdatePhone();
                            if (!_formKey2.currentState.validate()) return;
                            _formKey2.currentState.save();
                            context
                                .read<ProfileProvider>()
                                .setPhoneNumber(updatePhone);
                          },
                          icon: Icon(Icons.save),
                          label: Text("حفظ")),
                  title: !context.watch<ProfileProvider>().getUpdatePhone()
                      ? Text(
                          context.watch<ProfileProvider>().getPhoneNumber(),
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.end,
                        )
                      : Form(
                          key: _formKey2,
                          child: TextFormField(
                            autofocus: true,
                            cursorHeight: 40,
                            maxLength: 40,
                            initialValue: context
                                .watch<ProfileProvider>()
                                .getPhoneNumber(),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              //prefix: Icon(Icons.person),
                              enabled: true,
                              hintText: '',
                              helperText: '',
                              counterText: '',
                            ),
                            keyboardType: TextInputType.datetime,
                            validator: (val) {
                              if (val.isEmpty) return "يرجى ادخال القيمة";
                            },
                            onSaved: (val) {
                              updatePhone = val;
                            },
                          ),
                        ),
                  trailing: Icon(
                    Icons.phone,
                    size: 35,
                    color: Colors.purple,
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  leading: !context.watch<ProfileProvider>().getUpdateLocation()
                      ? FlatButton.icon(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .toggleUpdateLocation();
                          },
                          icon: Icon(Icons.edit),
                          label: Text(""))
                      : FlatButton.icon(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .toggleUpdateLocation();
                            if (!_formKey3.currentState.validate()) return;
                            _formKey3.currentState.save();
                            context
                                .read<ProfileProvider>()
                                .setLocation(updateLocation);
                            context
                                .read<ProfileProvider>()
                                .setLocation(updateLocation);
                          },
                          icon: Icon(Icons.save),
                          label: Text("حفظ")),
                  title: !context.watch<ProfileProvider>().getUpdateLocation()
                      ? Text(
                          context.watch<ProfileProvider>().getLocation(),
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.end,
                        )
                      : Form(
                          key: _formKey3,
                          child: TextFormField(
                            autofocus: true,
                            cursorHeight: 40,
                            maxLength: 40,
                            initialValue:
                                "${context.watch<ProfileProvider>().getLocation()}",
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              //prefix: Icon(Icons.person),
                              enabled: true,
                              hintText: '',
                              helperText: '',
                              counterText: '',
                            ),
                            keyboardType: TextInputType.name,
                            validator: (val) {
                              if (val.isEmpty) return "يرجى ادخال القيمة";
                            },
                            onSaved: (val) {
                              updateLocation = val;
                            },
                          ),
                        ),
                  trailing: Icon(
                    Icons.add_location_alt,
                    size: 35,
                    color: Colors.purple,
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  leading: !context.watch<ProfileProvider>().getUpdateWeight()
                      ? FlatButton.icon(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .toggleUpdateWeight();
                          },
                          icon: Icon(Icons.edit),
                          label: Text(""))
                      : FlatButton.icon(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .toggleUpdateWeight();
                            if (!_formKey1.currentState.validate()) return;
                            _formKey1.currentState.save();
                            context
                                .read<ProfileProvider>()
                                .setWeight(updateWeight);
                            context
                                .read<ProfileProvider>()
                                .setWeight(updateWeight);
                          },
                          icon: Icon(Icons.save),
                          label: Text("حفظ")),
                  title: !context.watch<ProfileProvider>().getUpdateWeight()
                      ? Text(
                          "${context.watch<ProfileProvider>().getWeight()}",
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.end,
                        )
                      : Form(
                          key: _formKey1,
                          child: TextFormField(
                            autofocus: true,
                            cursorHeight: 40,
                            maxLength: 40,
                            initialValue:
                                "${context.watch<ProfileProvider>().getWeight()}",
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              //prefix: Icon(Icons.person),
                              enabled: true,
                              hintText: '',
                              helperText: '',
                              counterText: '',
                            ),
                            keyboardType: TextInputType.datetime,
                            validator: (val) {
                              if (val.isEmpty) return "يرجى ادخال القيمة";
                            },
                            onSaved: (val) {
                              updateWeight = double.parse(val);
                            },
                          ),
                        ),
                  trailing: Icon(
                    Icons.vertical_align_center_rounded,
                    size: 35,
                    color: Colors.purple,
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  leading: !context.watch<ProfileProvider>().getUpdateLength()
                      ? FlatButton.icon(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .toggleUpdateLength();
                          },
                          icon: Icon(Icons.edit),
                          label: Text(""))
                      : FlatButton.icon(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .toggleUpdateLength();
                            if (!_formKey.currentState.validate()) return;
                            _formKey.currentState.save();
                            context
                                .read<ProfileProvider>()
                                .setLength(updateLength);
                            context
                                .read<ProfileProvider>()
                                .setLength(updateLength);
                          },
                          icon: Icon(Icons.save),
                          label: Text("حفظ")),
                  title: !context.watch<ProfileProvider>().getUpdateLength()
                      ? Text(
                          "${context.watch<ProfileProvider>().getLength()}",
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.end,
                        )
                      : Form(
                          key: _formKey,
                          child: TextFormField(
                            autofocus: true,
                            cursorHeight: 40,
                            maxLength: 40,
                            initialValue:
                                "${context.watch<ProfileProvider>().getLength()}",
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              fillColor: Colors.white70,
                              //prefix: Icon(Icons.person),
                              enabled: true,
                              hintText: '',
                              helperText: '',
                              counterText: '',
                            ),
                            keyboardType: TextInputType.datetime,
                            validator: (val) {
                              if (val.isEmpty) return "يرجى ادخال القيمة";
                            },
                            onSaved: (val) {
                              updateLength = double.parse(val);
                            },
                          ),
                        ),
                  trailing: Icon(
                    Icons.history_edu,
                    size: 35,
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 50, left: 140),
            width: 150,
            height: 150,
            child: CircularProfileAvatar(
              context.watch<ProfileProvider>().getImgUrl(),
              errorWidget: (context, url, error) => Container(
                child: Icon(Icons.error),
              ),
              placeHolder: (context, url) => Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                ),
              ),
              radius: 90,
              backgroundColor: Colors.transparent,
              borderWidth: 3,

//                  initialsText: Text(
//                    "AD",
//                    style: TextStyle(fontSize: 40, color: Colors.white),
//                  ),
              borderColor: Colors.purple.withOpacity(.3),
              elevation: 5.0,
              onTap: () {
                print('adil');
              },
              cacheImage: true,
              showInitialTextAbovePicture: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add_a_photo_outlined),
        onPressed: () {
          var alertDialog = AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                    color: Colors.purple,
                    width: 300,
                    child: ListTile(
                      trailing: Icon(Icons.image),
                      title: Text(
                        "صوري",
                        textAlign: TextAlign.end,
                      ),
                      onTap: () {
                        context
                            .read<ProfileProvider>()
                            .getImage(ImageSource.gallery);
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
                          "الكاميرا",
                          textAlign: TextAlign.end,
                        ),
                        onTap: () {
                          context
                              .read<ProfileProvider>()
                              .getImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              ),
            ),
          );
          showDialog(context: context, child: alertDialog);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
