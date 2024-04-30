import 'package:trialing/domain/pill_taken_hour.dart';
import 'package:trialing/utils/medication_schedule_event_extension.dart';
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
  late String id;
  final DateTime day;
  final bool taken;

  MedicationScheduleEvent({
    required this.day,
    required String medicationId,
    required PillTakingHour pillTakingHour,
    required double dosage,
    this.taken = false,
  }) : super(
          medicationId: medicationId,
          dosage: dosage,
          type: EventType.scheduleItem,
          pillTakingHour: pillTakingHour,
        ) {
    id = getId();
  }

  MedicationScheduleEvent copyWith({required bool taken}) => MedicationScheduleEvent(
        day: day,
        medicationId: medicationId,
        pillTakingHour: pillTakingHour,
        dosage: dosage,
        taken: taken,
      );
}

class MedicationLogEvent extends Event {
  late DateTime logDate;

  MedicationLogEvent({
    required String medicationId,
    required PillTakingHour pillTakingHour,
    required double dosage,
    DateTime? logDate,
  }) : super(
          medicationId: medicationId,
          dosage: dosage,
          type: EventType.scheduleItem,
          pillTakingHour: pillTakingHour,
        ) {
    this.logDate = logDate ?? DateTime.now();
  }

  ///Returns whether the medicine has been taken at the correct time.
  bool getTookAtTime() {
    DateTime exactHour = pillTakingHour.exactHour.toDateTimeFromDate(logDate);
    DateTime marginHour = exactHour.add(Duration(minutes: pillTakingHour.marginInMinutes));
    return logDate.isAtSameMomentAs(exactHour) ||
        logDate.isAtSameMomentAs(marginHour) ||
        logDate.isBefore(marginHour) && logDate.isAfter(exactHour);
  }

  factory MedicationLogEvent.fromJson(Map<String, dynamic> json) {
    return MedicationLogEvent(
      medicationId: json['medicationId'],
      pillTakingHour: PillTakingHour.fromJson(json['pillTakingHour']),
      dosage: json['dosage'],
      logDate: DateTime.parse(json['logDate']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'medicationId': medicationId,
        'pillTakingHour': pillTakingHour.toJson(),
        'dosage': dosage,
        'logDate': logDate.toString(),
      };
}
