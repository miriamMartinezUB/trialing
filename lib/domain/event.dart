import 'package:trialing/domain/pill_taken_hour.dart';
import 'package:trialing/utils/time_of_day_extension.dart';

abstract class Event {
  final String medicationId;
  final PillTakingHour pillTakingHour;
  final double dosage;
  final EventType type;

  Event({
    required this.medicationId,
    required this.pillTakingHour,
    required this.dosage,
    required this.type,
  });
}

enum EventType { scheduleItem, log }

class MedicationScheduleEvent extends Event {
  final bool taken;

  MedicationScheduleEvent({
    required String medicationId,
    required PillTakingHour pillTakingHour,
    required double dosage,
    this.taken = false,
  }) : super(
          medicationId: medicationId,
          dosage: dosage,
          type: EventType.scheduleItem,
          pillTakingHour: pillTakingHour,
        );

  MedicationScheduleEvent copyWith({required bool taken}) => MedicationScheduleEvent(
        medicationId: medicationId,
        pillTakingHour: pillTakingHour,
        dosage: dosage,
        taken: taken,
      );
}

class MedicationLogEvent extends Event {
  final DateTime logDate;

  MedicationLogEvent({
    required String medicationId,
    required PillTakingHour pillTakingHour,
    required double dosage,
    required this.logDate,
  }) : super(
          medicationId: medicationId,
          dosage: dosage,
          type: EventType.scheduleItem,
          pillTakingHour: pillTakingHour,
        );

  ///Returns whether the medicine has been taken at the correct time.
  bool getTookAtTime() {
    DateTime exactHour = pillTakingHour.exactHour.toDateTimeFromDate(logDate);
    DateTime marginHour = exactHour.add(Duration(minutes: pillTakingHour.marginInMinutes));
    return logDate.isAtSameMomentAs(exactHour) ||
        logDate.isAtSameMomentAs(marginHour) ||
        logDate.isBefore(marginHour) && logDate.isAfter(exactHour);
  }
}
