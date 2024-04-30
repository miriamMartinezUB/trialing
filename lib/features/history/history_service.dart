import 'dart:collection';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trialing/common/hive_storage_service.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/data/database.dart';
import 'package:trialing/domain/event.dart';
import 'package:trialing/domain/medication_schedule.dart';

class HistoryService {
  late MedicationPlan _medicationPlan;
  late LinkedHashMap<DateTime, List<MedicationLogEvent>> _events;
  final List<MedicationLogEvent> _allEvents = [];
  late List<MedicationLogEvent> _selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  late Box<String> _boxLog;

  HistoryService() {
    HiveStorageService hiveStorageService = locator<HiveStorageService>();
    _boxLog = hiveStorageService.logBox;
    _createAllEvents();
    _medicationPlan = Database().medicationPlan;
    _getEvents();
  }

  DateTime get firstDate => _medicationPlan.creationDate;

  DateTime get lastDate => DateTime.now();

  List<MedicationLogEvent> get selectedEvents => _selectedEvents;

  void _createAllEvents() {
    for (String element in _boxLog.values) {
      _allEvents.add(MedicationLogEvent.fromJson(json.decode(element)));
    }
    _allEvents.sort((a, b) => a.logDate.compareTo(b.logDate));
  }

  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat != format) {
      calendarFormat = format;
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
      _selectedEvents = getEventsForDay(selectedDay);
    }
  }

  void _getEvents() {
    List<DateTime> days = [];
    DateTime startDay = DateTime.now();
    if (isSameDay(startDay, lastDate)) {
      days.add(startDay);
    } else {
      while (!isSameDay(startDay, lastDate)) {
        days.add(startDay);
        startDay = startDay.add(const Duration(days: 1));
      }
      days.add(lastDate);
    }
    _events = LinkedHashMap<DateTime, List<MedicationLogEvent>>(
      equals: isSameDay,
      hashCode: _getHashCode,
    )..addAll(
        {for (DateTime day in days) day: _allEvents.where((element) => isSameDay(day, element.logDate)).toList()});
    _selectedEvents = getEventsForDay(selectedDay);
  }

  List<MedicationLogEvent> getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  int _getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
