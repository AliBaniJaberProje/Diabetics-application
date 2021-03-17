import 'package:cloud_firestore/cloud_firestore.dart';

class DailyReadingItem {
  final String id;
  double value;
  Timestamp timestamp;

  bool take;

  DailyReadingItem(
      {this.id,
      this.value,
        this.timestamp,
      this.take = true});

  void setVale(double val) {
    this.value = val;
    take = false;
  }
}
