part of 'medication_plan_bloc.dart';

abstract class MedicationPlanEvent {}

class MedicationPlanLoadEvent extends MedicationPlanEvent {}

class MedicationPlanMarkAsDoneEvent extends MedicationPlanEvent {
  final MedicationScheduleEvent event;

  MedicationPlanMarkAsDoneEvent({required this.event});
}
