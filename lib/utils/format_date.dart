import 'package:intl/intl.dart';

class FormatDate {
  // Get the format string for the date.
  static String dateToString(DateTime date,
      [String formatString = 'dd-MM-yyyy']) {
    return DateFormat(formatString).format(date);
  }

  // Get [yMMMd] format string from date.
  static String date(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  // Get week from the date.
  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  // Get [DateTime] in the utc format.
  static DateTime getDateUtc(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }
}
