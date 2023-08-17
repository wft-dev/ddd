import 'package:intl/intl.dart';

class FormatDate {
  static String dateToString(DateTime date,
      [String formatString = 'dd-MM-yyyy']) {
    return DateFormat(formatString).format(date);
  }

  static String date(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static DateTime getDateUtc(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }
}
