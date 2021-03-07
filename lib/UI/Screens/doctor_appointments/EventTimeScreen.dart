


import 'package:ali_muntaser_final_project/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:ali_muntaser_final_project/core/Providers/EventDateTimeProvier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Doctor_appointmentScreen.dart';

class DateTimeView extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade100,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.purple,
          width: .1,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 150,
        child: Text(
          '_medicalAppointmentProviderWatch.getDateTimeFormatToView()',
          style: TextStyle(
              fontSize: 20, color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}



class EventTimeScreen extends StatefulWidget {
  static String routeName="/EventTimeScreen";

  @override
  _EventTimeScreenState createState() => _EventTimeScreenState();
}

class _EventTimeScreenState extends State<EventTimeScreen> {

  @override
  void initState() {
    context.read<SlotDateTimeProvider>().getAllEventInSelectedDateTime();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var _eventProvider=context.watch<SlotDateTimeProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          _eventProvider.getDateTime(),

          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, DoctorAppointmentsScreen.routeName);

          },
        ),
      ),
    );
  }
}
