import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  DateTime toDateTimeFromDate(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  String toStr() {
    String s = toString();
    s = s.replaceAll("TimeOfDay", "");
    s = s.replaceAll("(", "");
    s = s.replaceAll(")", "");
    return s;
  }
}

extension ParseToTimeFromString on String {
  TimeOfDay toTimeOfDay() {
    List<String> parts = split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
