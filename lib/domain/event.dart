import 'package:flutter/widgets.dart';
import 'package:trialing/domain/medication_schedule.dart';

abstract class Event {
  final String medicationId;
  final DateTime? exactHour;
  final TimeOfDay? timeOfDay;
  final double dosage;
  final EventType type;

  Event({
    required this.medicationId,
    this.exactHour,
    this.timeOfDay,
    required this.dosage,
    required this.type,
  }) {
    if (exactHour == null && timeOfDay == null) {
      throw FlutterError("You must indicate the exact hour or the time of the day, both cannot be null");
    }
  }
}

enum EventType { scheduleItem, log }

class MedicationScheduleEvent extends Event {
  final bool taken;

  MedicationScheduleEvent({
    required String medicationId,
    DateTime? exactHour,
    TimeOfDay? timeOfDay,
    required double dosage,
    this.taken = false,
  }) : super(
          medicationId: medicationId,
          dosage: dosage,
          type: EventType.scheduleItem,
          timeOfDay: timeOfDay,
          exactHour: exactHour,
        );

  MedicationScheduleEvent copyWith({required bool taken}) => MedicationScheduleEvent(
        medicationId: medicationId,
        exactHour: exactHour,
        timeOfDay: timeOfDay,
        dosage: dosage,
        taken: taken,
      );
}

class MedicationLogEvent extends Event {
  final DateTime logDate;

  MedicationLogEvent({
    required String medicationId,
    DateTime? exactHour,
    TimeOfDay? timeOfDay,
    required double dosage,
    required this.logDate,
  }) : super(
          medicationId: medicationId,
          dosage: dosage,
          type: EventType.scheduleItem,
          timeOfDay: timeOfDay,
          exactHour: exactHour,
        );
}
