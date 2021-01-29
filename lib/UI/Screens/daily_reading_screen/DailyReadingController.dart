import 'package:ali_muntaser_final_project/core/Providers/DailyReadingProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DailyReadingScreenController {
  BuildContext context;
  DailyReadingScreenController(this.context);

  void setValue(int id, double value) {
    context.read<DailyReadingProvider>().setValueAndTake(id, value);
  }

  void update(int id, double value) {
    context.read<DailyReadingProvider>().setValueAndTake(id, value);
  }
}
