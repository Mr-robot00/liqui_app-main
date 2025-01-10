// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


import 'package:intl/intl.dart';

class DateTimeHelper {
  // DatePickerTheme pickerTheme() {
  //   return DatePickerTheme(
  //       headerColor:
  //       Theme.of(Get.context!).primaryColor,
  //       backgroundColor: Theme.of(Get.context!)
  //           .scaffoldBackgroundColor,
  //       itemStyle: TextStyle(
  //           color: Theme.of(Get.context!)
  //               .textTheme
  //               .subtitle1!
  //               .color,
  //           fontWeight: FontWeight.bold,
  //           fontSize: myHelper.isTablet ? 25.0 : 20.0),
  //       cancelStyle: TextStyle(
  //           color: Colors.red, fontSize: myHelper.isTablet ? 22.0 : 18.0),
  //       doneStyle: TextStyle(
  //           color: Colors.white, fontSize: myHelper.isTablet ? 22.0 : 18.0));
  // }

  String serverTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';
    DateFormat outFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return outFormat.format(timestamp);
  }

  String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }
    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }
    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String dD(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("dd");
    var date = outFormat.format(inFormat.parse(timestamp));
    return '$date${getDayOfMonthSuffix(int.parse(date))}';
  }

  String dDMMM(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat ddFormat = DateFormat("dd");
    DateFormat mmmFormat = DateFormat("MMM");
    var dd = ddFormat.format(inFormat.parse(timestamp));
    var mmm = mmmFormat.format(inFormat.parse(timestamp));
    return '$dd${getDayOfMonthSuffix(int.parse(dd))} $mmm';
  }

  String hHMMA(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("hh:mm a");
    return outFormat.format(inFormat.parse(timestamp));
  }

  String hHMMADDMMMY(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("hh:mm a, dd MMM yyyy");
    return outFormat.format(inFormat.parse(timestamp));
  }

  String ddMMMMYYYY(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd");
    DateFormat outFormat = DateFormat("dd MMMM yyyy");
    return outFormat.format(inFormat.parse(timestamp));
  }

  String dDMMMYHHMMA(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("dd-MMM-yyyy hh:mm a");
    return outFormat.format(inFormat.parse(timestamp));
  }

  String dDMMMMYHHMMA(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("MMMM yyyy, hh:mm a");
    DateFormat dateFormat = DateFormat("dd");
    var date = dateFormat.format(inFormat.parse(timestamp));
    return '$date${getDayOfMonthSuffix(int.parse(date))} ${outFormat.format(inFormat.parse(timestamp))}';
  }

  String dDMMHHMMA(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("MMM, hh:mm a");
    DateFormat dateFormat = DateFormat("dd");
    var date = dateFormat.format(inFormat.parse(timestamp));
    return '$date${getDayOfMonthSuffix(int.parse(date))} ${outFormat.format(inFormat.parse(timestamp))}';
  }

  String dDMMYYHHMMA(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("MMM yyyy, hh:mm a");
    DateFormat dateFormat = DateFormat("dd");
    var date = dateFormat.format(inFormat.parse(timestamp));
    return '$date${getDayOfMonthSuffix(int.parse(date))} ${outFormat.format(inFormat.parse(timestamp))}';
  }

  String dDMMMMYE(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("MMMM yyyy, EEE");
    DateFormat dateFormat = DateFormat("dd");
    var date = dateFormat.format(inFormat.parse(timestamp));
    return '$date${getDayOfMonthSuffix(int.parse(date))} ${outFormat.format(inFormat.parse(timestamp))}';
  }

  String ddMMyyyy(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("dd-MM-yyyy");
    return outFormat.format(inFormat.parse(timestamp));
  }

  String date(DateTime timestamp) {
    DateFormat outFormat = DateFormat("dd-MM-yyyy");
    return outFormat.format(timestamp);
  }

  DateTime dateFormat(DateTime timestamp) {
    DateFormat outFormat = DateFormat("dd-MM-yyyy");
    return outFormat.parse(outFormat.format(timestamp));
  }

  String time(DateTime timestamp) {
    DateFormat outFormat = DateFormat("hh:mm a");
    return outFormat.format(timestamp);
  }

  String eEDDMM(DateTime timestamp) {
    DateFormat outFormat = DateFormat("EE\ndd\nMMM");
    return outFormat.format(timestamp);
  }

  String eEDDMMY(DateTime timestamp) {
    DateFormat dayFormat = DateFormat("EE");
    DateFormat dateFormat = DateFormat("dd");
    var day = dayFormat.format(timestamp);
    var date = dateFormat.format(timestamp);
    DateFormat outFormat = DateFormat("MMM, yyyy");
    return '$day, $date${getDayOfMonthSuffix(int.parse(date))} ${outFormat.format(timestamp)}';
  }

  String dDMMMYY(String timestamp) {
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat dateFormat = DateFormat("dd");
    var date = dateFormat.format(inFormat.parse(timestamp));
    DateFormat outFormat = DateFormat("MMM, yyyy");
    return '$date${getDayOfMonthSuffix(int.parse(date))} ${outFormat.format(inFormat.parse(timestamp))}';
  }

  String getFormattedDate(date, {String? outFormat, String? inFormat}) {
    var inputFormat = DateFormat(inFormat ?? 'yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat(outFormat ?? 'dd-MMM-yyyy');
    return outputFormat.format(inputDate);
  }

  String dayTYT(String timestamp) {
    if (timestamp.isEmpty) return '';
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateFormat outFormat = DateFormat("MMM");
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final dateToCheck = inFormat.parse(timestamp);
    final aDate =
    DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return 'Today';
    } else if (aDate == yesterday) {
      return 'Yesterday';
    } else if (aDate == tomorrow) {
      return 'Tomorrow';
    } else {
      DateFormat dateFormat = DateFormat("dd");
      var date = dateFormat.format(inFormat.parse(timestamp));
      return '$date${getDayOfMonthSuffix(int.parse(date))} ${outFormat.format(dateToCheck)}';
      // return outFormat.format(dateToCheck);
    }
  }

  DateTime updateTime(DateTime date, DateTime time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute,
        time.second, time.millisecond, time.microsecond);
  }

  DateTime parseDate(String timestamp) {
    DateFormat inFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    return inFormat.parse(timestamp);
  }
}

final dtHelper = DateTimeHelper();

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }
}
