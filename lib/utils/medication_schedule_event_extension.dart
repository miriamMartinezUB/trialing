import 'package:trialing/domain/event.dart';

extension MedicationScheduleEventExtension on MedicationScheduleEvent {
  String getId() => '${medicationId}_${day}_${pillTakingHour.exactHour}_$dosage';
}

extension DosageExtension on double {
  String getStr() {
    if (this % 1 != 0) {
      return toString();
    }
    return toInt().toString();
  }
}
