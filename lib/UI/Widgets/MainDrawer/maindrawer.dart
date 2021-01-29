import 'package:ali_muntaser_final_project/UI/Widgets/MainDrawer/maindrawerController.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDrawer extends StatelessWidget {
  final String title;
  final IconData iconData;

  const ItemDrawer({@required this.title, @required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.purple.withOpacity(.2),
      child: ListTile(
        title: Text(
          this.title,
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        trailing: Icon(
          iconData,
          size: 20,
          color: Colors.purple,
        ),
        onTap: () {},
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainDrawerController _drawerController =
        new MainDrawerController(context);
    return Drawer(
      child: ListView(
        children: [
          InkWell(
            child: Container(
              color: Colors.purple.withOpacity(.4),
              height: 175,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 0, left: 75, right: 75),
                      child: CircularProfileAvatar(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWtMDksH9GzFdMinyAkGbtLJNx6xynLETTNN5akjxirL3QD5Rj',
                        errorWidget: (context, url, error) => Container(
                          child: Icon(Icons.error),
                        ),
                        placeHolder: (context, url) => Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                        radius: 150,
                        backgroundColor: Colors.transparent,
                        borderWidth: 2,
                        initialsText: Text(
                          "علي بني جابر",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        borderColor: Colors.purple,
                        elevation: 5.0,
                        onTap: _drawerController.goToMyPersonScreen,
                        cacheImage: true,
                        showInitialTextAbovePicture: false,
                      ),
                    ),
                    Text(
                      context.watch<ProfileProvider>().getUserName(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
            onTap: _drawerController.goToMyPersonScreen,
          ),
          SizedBox(
            height: 20,
          ),
          ItemDrawer(
              title: "مراجعة جرعاتي", iconData: Icons.donut_small_outlined),
          ItemDrawer(
              title: "الفحوصات", iconData: Icons.text_rotation_angleup_rounded),
          ItemDrawer(title: "وجباتي", iconData: Icons.fastfood_outlined),
          ItemDrawer(
              title: "هل هذا صحي لي ؟", iconData: Icons.camera_alt_outlined),
          ItemDrawer(title: "مواعيدي", iconData: Icons.date_range_outlined),
          ItemDrawer(title: "تماريني", iconData: Icons.do_not_step_sharp),
          ItemDrawer(
              title: "تعديل بيانات الدخول", iconData: Icons.lock_outline_sharp),
          ItemDrawer(
              title: "اقتراحات لتطوير التطبيق", iconData: Icons.mail_outline),
          ItemDrawer(title: "تسجيل الخروج", iconData: Icons.logout),
        ],
      ),
    );
  }
}
