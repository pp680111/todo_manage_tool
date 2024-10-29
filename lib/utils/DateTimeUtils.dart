import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateFormat yyyyMMddHHmmssFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static DateFormat yyyyMMddHHmmFormat = DateFormat('yyyy-MM-dd HH:mm');

  static String formatDateTime(DateTime? dateTime, DateFormat format) {
    if (dateTime == null) {
      return "";
    }
    return format.format(dateTime);
  }
}