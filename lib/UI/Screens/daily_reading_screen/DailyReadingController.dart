import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:ali_muntaser_final_project/core/Providers/ProfileProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DailyReadingScreenController {
  BuildContext context;
  DailyReadingScreenController(this.context);

  void setValue(int id, double value,Function shownotification) {

    context.read<DailyReadingProvider>().setValueAndTake(id, value,shownotification,context.read<ProfileProvider>().patient.username);
  }

  void update(int id, double value,Function shownotification ) {
    context.read<DailyReadingProvider>().setValueAndTake(id, value,shownotification,context.read<ProfileProvider>().patient.username);
  }
}
