import 'dart:ui';

class EventHistoryModel {
  final String id;
  final String dateEventTime;
  final String doctorName;
  final String doctorImg;
  final String note;
  final Color shadowColor;
  final Color boderColor;

  EventHistoryModel(
      {this.id,
      this.dateEventTime,
      this.doctorName,
      this.doctorImg,
      this.note,
      this.shadowColor,
      this.boderColor});
}
