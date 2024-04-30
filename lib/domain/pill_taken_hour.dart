import 'package:flutter/material.dart';
import 'package:trialing/utils/time_of_day_extension.dart';

enum TimeOfTheDay {
  ///Before breakfast
  fasting,

  ///At breakfast
  breakfast,

  ///At lunchtime
  lunchTime,

  ///Before the afternoon snack
  snack,

  ///At dinner time
  dinner,

  ///Before going to sleep
  beforeBedTime,

  ///It can be at any time of the day if necessary, in our model it will not be used,
  ///but it is contemplated so that it can be included at a later date.
  ifNeeded,
}

class PillTakingHour {
  final TimeOfTheDay timeOfTheDay;

  ///The following fields, as mentioned above, should be customisable, but we will define them ourselves,
  ///depending on the time of the day.
  ///
  ///Time at which the medicine should be taken
  final TimeOfDay exactHour;

  ///Minutes of time you have to take the medication
  final int marginInMinutes;

  PillTakingHour._({
    required this.timeOfTheDay,
    required this.exactHour,
    this.marginInMinutes = 0,
  });

  factory PillTakingHour.fromTimeOfTheDay(TimeOfTheDay timeOfTheDay) {
    switch (timeOfTheDay) {
      case TimeOfTheDay.fasting:
        return PillTakingHour.fasting();
      case TimeOfTheDay.breakfast:
        return PillTakingHour.breakfast();
      case TimeOfTheDay.lunchTime:
        return PillTakingHour.lunchTime();
      case TimeOfTheDay.snack:
        return PillTakingHour.snack();
      case TimeOfTheDay.dinner:
        return PillTakingHour.dinner();
      case TimeOfTheDay.beforeBedTime:
        return PillTakingHour.beforeBedTime();
      case TimeOfTheDay.ifNeeded:
        throw FlutterError('Type if needed is not contemplated in this constructor');
    }
  }

  factory PillTakingHour.fasting() {
    return PillTakingHour._(
        timeOfTheDay: TimeOfTheDay.fasting, exactHour: const TimeOfDay(hour: 07, minute: 30), marginInMinutes: 30);
  }

  factory PillTakingHour.breakfast() {
    return PillTakingHour._(
        timeOfTheDay: TimeOfTheDay.breakfast, exactHour: const TimeOfDay(hour: 08, minute: 30), marginInMinutes: 30);
  }

  factory PillTakingHour.lunchTime() {
    return PillTakingHour._(
        timeOfTheDay: TimeOfTheDay.lunchTime, exactHour: const TimeOfDay(hour: 13, minute: 30), marginInMinutes: 30);
  }

  factory PillTakingHour.snack() {
    return PillTakingHour._(
        timeOfTheDay: TimeOfTheDay.snack, exactHour: const TimeOfDay(hour: 18, minute: 00), marginInMinutes: 30);
  }

  factory PillTakingHour.dinner() {
    return PillTakingHour._(
        timeOfTheDay: TimeOfTheDay.dinner, exactHour: const TimeOfDay(hour: 21, minute: 00), marginInMinutes: 30);
  }

  factory PillTakingHour.beforeBedTime() {
    return PillTakingHour._(
        timeOfTheDay: TimeOfTheDay.beforeBedTime,
        exactHour: const TimeOfDay(hour: 23, minute: 00),
        marginInMinutes: 30);
  }

  factory PillTakingHour.ifNeeded({required TimeOfDay exactHour, int marginInMinutes = 0}) {
    return PillTakingHour._(
        timeOfTheDay: TimeOfTheDay.ifNeeded, exactHour: exactHour, marginInMinutes: marginInMinutes);
  }

  factory PillTakingHour.fromJson(Map<String, dynamic> json) {
    return PillTakingHour._(
      exactHour: ParseToTimeFromString(json['exactHour']).toTimeOfDay(),
      timeOfTheDay: TimeOfTheDay.values[json['timeOfTheDay']],
      marginInMinutes: json['marginInMinutes'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'exactHour': exactHour.toStr(),
        'timeOfTheDay': timeOfTheDay.index,
        'marginInMinutes': marginInMinutes,
      };
}
