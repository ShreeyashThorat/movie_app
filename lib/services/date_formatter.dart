import 'package:intl/intl.dart';

class DateFormatter {
  static String longDate(String date) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    DateTime originalDate = dateFormat.parse(date);
    final formattedDate = DateFormat('MMMM d, y');
    return formattedDate.format(originalDate);
  }
}
