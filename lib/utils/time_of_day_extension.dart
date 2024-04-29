import 'package:flutter/material.dart';

extension StringExtension on TimeOfDay {
  DateTime toDateTimeFromDate(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}
