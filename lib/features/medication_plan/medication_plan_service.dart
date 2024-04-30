import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/data/database.dart';
import 'package:trialing/domain/event.dart';
import 'package:trialing/domain/medication_schedule.dart';
import 'package:trialing/domain/pill_taken_hour.dart';

class MedicationPlanService {
  late MedicationPlan _medicationPlan;
  late List<MedicationScheduleEvent> _events;
  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  late Box<String> _boxTakenMedications;
  late Box<String> _boxLog;
  late LocalNotificationsService localNotificationsService;

  MedicationPlanService() {
    _medicationPlan = Database().medicationPlan;
    _events = _createAllEvents(_firstDate, _lastDate);
    HiveStorageService hiveStorageService = locator<HiveStorageService>();
    if (!kIsWeb) {
      localNotificationsService = locator<LocalNotificationsService>();
      localNotificationsService.cancelAllNotifications();
      _scheduleReminders();
    }
    _boxTakenMedications = hiveStorageService.takenMedicationsBox;
    _boxLog = hiveStorageService.logBox;
  }

  List<MedicationScheduleEvent> get events => _events;

  List<String> get taken => _boxTakenMedications.values.toList();

  DateTime get _firstDate => DateTime.now();

  DateTime get _lastDate => DateTime.now().add(const Duration(days: 1));

  void _scheduleReminders() {
    List<MedicationScheduleEvent> remindersEvents = [];
    remindersEvents.addAll(_events);
    remindersEvents.addAll(_createAllEvents(_lastDate, _lastDate.add(const Duration(days: 1))));
    for (MedicationScheduleEvent medicationScheduleEvent in remindersEvents) {
      DateTime dateTime = DateTime(
          medicationScheduleEvent.day.year,
          medicationScheduleEvent.day.month,
          medicationScheduleEvent.day.day,
          medicationScheduleEvent.pillTakingHour.exactHour.hour,
          medicationScheduleEvent.pillTakingHour.exactHour.minute);
      if (dateTime.isAfter(DateTime.now())) {
        localNotificationsService.scheduleNotification(
            dateTime,
            translate(medicationScheduleEvent.medicationId.toLowerCase()),
            '${translate('reminder_body')} ${medicationScheduleEvent.dosage} ${translate('reminder_body2')}');
      }
    }
  }

  List<MedicationScheduleEvent> _createAllEvents(DateTime firstDate, DateTime lastDate) {
    List<MedicationScheduleEvent> events = [];
    for (MedicationSchedule medicationSchedule in _medicationPlan.medications) {
      DateTime currentDate = firstDate;
      DateTime endDate = _getEndDate(lastDate, medicationSchedule.endDate);
      while (!isSameDay(currentDate, endDate) && currentDate.isBefore(endDate)) {
        if (medicationSchedule.frequency == Frequency.personified) {
          if (medicationSchedule.frequencyPersonifiedInDays!.contains(WeekDays.values[currentDate.weekday - 1])) {
            events.addAll(_addAllEvents(currentDate, medicationSchedule));
          }
        } else {
          events.addAll(_addAllEvents(currentDate, medicationSchedule));
        }
        currentDate = _updateCurrentDate(
          currentDate: currentDate,
          frequency: medicationSchedule.frequency,
          frequencyPersonifiedInDays: medicationSchedule.frequencyPersonifiedInDays,
        );
      }
    }
    return events;
  }

  List<MedicationScheduleEvent> _addAllEvents(DateTime currentDate, MedicationSchedule medicationSchedule) {
    List<MedicationScheduleEvent> events = [];
    for (TimeOfTheDay timeOfTheDay in medicationSchedule.timesOfTheDay) {
      events.add(MedicationScheduleEvent(
        dosage: medicationSchedule.dosage,
        medicationId: medicationSchedule.medicationId,
        pillTakingHour: PillTakingHour.fromTimeOfTheDay(timeOfTheDay),
        day: DateTime(currentDate.year, currentDate.month, currentDate.day),
      ));
    }
    return events;
  }

  DateTime _getEndDate(DateTime lastDate, DateTime? endDate) {
    if (endDate == null) {
      return lastDate;
    }
    if (endDate.isAfter(lastDate)) {
      return lastDate;
    }
    return endDate;
  }

  DateTime _updateCurrentDate(
      {required DateTime currentDate, required Frequency frequency, List<WeekDays>? frequencyPersonifiedInDays}) {
    int days = 0;
    if (frequency == Frequency.monthly) {
      days = 30;
    } else if (frequency == Frequency.weekly) {
      days = 7;
    } else if (frequency == Frequency.daily) {
      days = 1;
    } else if (frequency == Frequency.personified) {
      WeekDays currentWeekDay = WeekDays.values[currentDate.weekday - 1];
      if (frequencyPersonifiedInDays!.contains(currentWeekDay)) {
        int indexOfCurrentWeekDay = frequencyPersonifiedInDays.indexOf(currentWeekDay);
        days = frequencyPersonifiedInDays[indexOfCurrentWeekDay + 1].index -
            frequencyPersonifiedInDays[indexOfCurrentWeekDay].index;
      } else {
        days = 1;
      }
    }
    return currentDate.add(Duration(days: days));
  }

  void markEventAsDone(MedicationScheduleEvent event) {
    _boxTakenMedications.add(event.id);
    _boxLog.add(json.encode(MedicationLogEvent(
      medicationId: event.medicationId,
      pillTakingHour: event.pillTakingHour,
      dosage: event.dosage,
    ).toJson()));
  }
}
