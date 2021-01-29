class DailyReadingItem {
  final String id;
  double value;
  final DateTime dateTimeForThis;
  final DateTime timeRegistration;
  bool take;

  DailyReadingItem(
      {this.id,
      this.value,
      this.dateTimeForThis,
      this.timeRegistration = null,
      this.take = true});

  void setVale(double val) {
    this.value = val;
    take = false;
  }
}
