part of 'medication_plan_bloc.dart';

abstract class MedicationPlanState {}

class MedicationPlanInitialState extends MedicationPlanState {}

class MedicationPlanLoadingState extends MedicationPlanState {
  MedicationPlanLoadingState({Key? key});
}

class MedicationPlanLoadedState extends MedicationPlanState {
  final List<MedicationScheduleEvent> fastingEvents;
  final List<MedicationScheduleEvent> breakfastEvents;
  final List<MedicationScheduleEvent> lunchTimeEvents;
  final List<MedicationScheduleEvent> snackEvents;
  final List<MedicationScheduleEvent> dinnerEvents;
  final List<MedicationScheduleEvent> beforeBedTimeEvents;
  final List<String> markedAsDone;

  MedicationPlanLoadedState({
    Key? key,
    required this.fastingEvents,
    required this.breakfastEvents,
    required this.lunchTimeEvents,
    required this.snackEvents,
    required this.dinnerEvents,
    required this.beforeBedTimeEvents,
    required this.markedAsDone,
  });
}
