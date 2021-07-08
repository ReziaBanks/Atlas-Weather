//Displays only the date-based information; excludes time
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month
        && this.day == other.day;
  }
}

//Changes the precision of double to a given decimal place
extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}