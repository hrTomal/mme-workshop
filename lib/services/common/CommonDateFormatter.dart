import 'package:intl/intl.dart';

class CommonDateFormatter {
  static String get12hr(String onlytime) {
    DateTime time = DateTime.parse("2023-04-04 $onlytime");
    return DateFormat('h:mm a').format(time);
  }

  static String getMonthandDate(String dateString) {
    final date = DateFormat('yyyy-MM-dd').parse(dateString);
    final month = DateFormat.MMMM().format(date);
    final day = DateFormat.d().format(date);
    final suffix = _getDaySuffix(int.parse(day));
    return '$month $day$suffix';
  }

  static _getDaySuffix(int day) {
    switch (day) {
      case 1:
      case 21:
      case 31:
        return 'st';
      case 2:
      case 22:
        return 'nd';
      case 3:
      case 23:
        return 'rd';
      default:
        return 'th';
    }
  }
}
