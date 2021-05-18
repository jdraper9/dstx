class Day {

  final int month;
  final int day;
  final int year;

  Day({ this.month, this.day, this.year });

  String toDayRef() {
    return '${this.month}-${this.day}-${this.year}';
  }

}