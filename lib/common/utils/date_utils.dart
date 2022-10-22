part of '../utils.dart';

class DateUtils {
  static const List<String> normalFullFormat = [
    HH,
    ':',
    nn,
    ' - ',
    dd,
    '/',
    mm,
    '/',
    yyyy
  ];

  static const List<String> transactionFormat = [
    HH,
    ':',
    nn,
    ' - ',
    dd,
    ' thg ',
    mm,
    ', ',
    yyyy
  ];

  static const List<String> normalDateFormat = [dd, '/', mm, '/', yyyy];

  static const List<String> dateOfWeekFormat = [
    D,
    ', ',
    dd,
    ' Thg ',
    mm,
    ', ',
    yyyy
  ];

  static const List<String> normalUTCFormat = [yyyy, '/', mm, '/', dd];
}

extension DateUtilsExtention on DateTime {
  String serverToTransaction() {
    return formatDate(
      toLocal(),
      DateUtils.transactionFormat,
    );
  }

  String serverToNormalDateFormat() {
    return formatDate(
      toLocal(),
      DateUtils.normalDateFormat,
    );
  }

  String toNormalDateFormat() {
    return formatDate(
      this,
      DateUtils.normalDateFormat,
    );
  }

  String serverToNormalFullFormat() {
    return formatDate(
      toLocal(),
      DateUtils.normalFullFormat,
    );
  }

  String serverToDateOfWeek(BuildContext context) {
    return formatDate(
      toLocal(),
      DateUtils.dateOfWeekFormat,
      locale: Localizations.localeOf(context).languageCode == 'en'
          ? const EnglishDateLocale()
          : const VietnameseDateLocale(),
    );
  }

  String toServerNormalUTCFormat() {
    return formatDate(
      toUtc(),
      DateUtils.normalUTCFormat,
    );
  }

  // String toVietnameseNormalDateFormat() {
  //   return formatDate(date, formats),
  // }
}
