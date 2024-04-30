import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trialing/common/hive_storage_service.dart';
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

  MedicationPlanService() {
    _events = [];
    _medicationPlan = Database().medicationPlan;
    _createAllEvents();
    HiveStorageService hiveStorageService = locator<HiveStorageService>();
    _boxTakenMedications = hiveStorageService.takenMedicationsBox;
    _boxLog = hiveStorageService.logBox;
  }

  List<MedicationScheduleEvent> get events => _events;

  List<String> get taken => _boxTakenMedications.values.toList();

  DateTime get _firstDate => DateTime.now();

  DateTime get _lastDate => DateTime.now().add(const Duration(days: 1));

  void _createAllEvents() {
    for (MedicationSchedule medicationSchedule in _medicationPlan.medications) {
      DateTime currentDate = _firstDate;
      DateTime endDate = _getEndDate(medicationSchedule.endDate);
      while (!isSameDay(currentDate, endDate) && currentDate.isBefore(endDate)) {
        if (medicationSchedule.frequency == Frequency.personified) {
          if (medicationSchedule.frequencyPersonifiedInDays!.contains(WeekDays.values[currentDate.weekday])) {
            _addAllEvents(currentDate, medicationSchedule);
          }
        } else {
          _addAllEvents(currentDate, medicationSchedule);
        }
        currentDate = _updateCurrentDate(
          currentDate: currentDate,
          frequency: medicationSchedule.frequency,
          frequencyPersonifiedInDays: medicationSchedule.frequencyPersonifiedInDays,
        );
      }
    }
  }

  void _addAllEvents(DateTime currentDate, MedicationSchedule medicationSchedule) {
    for (TimeOfTheDay timeOfTheDay in medicationSchedule.timesOfTheDay) {
      _events.add(MedicationScheduleEvent(
        dosage: medicationSchedule.dosage,
        medicationId: medicationSchedule.medicationId,
        pillTakingHour: PillTakingHour.fromTimeOfTheDay(timeOfTheDay),
        day: DateTime(currentDate.year, currentDate.month, currentDate.day),
      ));
    }
  }

  DateTime _getEndDate(DateTime? endDate) {
    if (endDate == null) {
      return _lastDate;
    }
    if (endDate.isAfter(_lastDate)) {
      return _lastDate;
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
      WeekDays currentWeekDay = WeekDays.values[currentDate.weekday];
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
