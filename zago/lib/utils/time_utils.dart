import 'package:easy_localization/easy_localization.dart';
import 'package:zago/utils/language_utils.dart';

class Time {
  static String getDate(int timeStamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

    if (date.isToday) {
      final hour = DateTime.now().hour - date.hour;
      return '$hour ${KeyLang.messageHour.tr()}';
    }

    final dateFormatted1 = DateFormat('dd/MM/yyyy').format(date);
    return dateFormatted1;
  }
}

extension DateUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}
