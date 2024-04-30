import 'package:trialing/domain/event.dart';

extension MedicationScheduleEventExtension on MedicationScheduleEvent {
  String getId() => '${medicationId}_${day}_${pillTakingHour.exactHour}_$dosage';
}
