import 'package:flutter/material.dart';

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
  final TimeOfTheDay timeOfDay;

  ///The following fields, as mentioned above, should be customisable, but we will define them ourselves,
  ///depending on the time of the day.
  ///
  ///Time at which the medicine should be taken
  final TimeOfDay exactHour;

  ///Minutes of time you have to take the medication
  final int marginInMinutes;

  PillTakingHour._({
    required this.timeOfDay,
    required this.exactHour,
    this.marginInMinutes = 0,
  });

  factory PillTakingHour.fasting() {
    return PillTakingHour._(
        timeOfDay: TimeOfTheDay.fasting, exactHour: const TimeOfDay(hour: 7, minute: 30), marginInMinutes: 30);
  }

  factory PillTakingHour.breakfast() {
    return PillTakingHour._(
        timeOfDay: TimeOfTheDay.breakfast, exactHour: const TimeOfDay(hour: 8, minute: 30), marginInMinutes: 30);
  }

  factory PillTakingHour.lunchTime() {
    return PillTakingHour._(
        timeOfDay: TimeOfTheDay.lunchTime, exactHour: const TimeOfDay(hour: 13, minute: 30), marginInMinutes: 30);
  }

  factory PillTakingHour.snack() {
    return PillTakingHour._(
        timeOfDay: TimeOfTheDay.snack, exactHour: const TimeOfDay(hour: 18, minute: 0), marginInMinutes: 30);
  }

  factory PillTakingHour.dinner() {
    return PillTakingHour._(
        timeOfDay: TimeOfTheDay.dinner, exactHour: const TimeOfDay(hour: 21, minute: 0), marginInMinutes: 30);
  }

  factory PillTakingHour.beforeBedTime() {
    return PillTakingHour._(
        timeOfDay: TimeOfTheDay.beforeBedTime, exactHour: const TimeOfDay(hour: 23, minute: 0), marginInMinutes: 30);
  }

  factory PillTakingHour.ifNeeded({required TimeOfDay exactHour, int marginInMinutes = 0}) {
    return PillTakingHour._(timeOfDay: TimeOfTheDay.ifNeeded, exactHour: exactHour, marginInMinutes: marginInMinutes);
  }
}
