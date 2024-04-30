part of 'medication_plan_bloc.dart';

abstract class MedicationPlanState {}

class MedicationPlanInitialState extends MedicationPlanState {}

class MedicationPlanLoadingState extends MedicationPlanState {
  MedicationPlanLoadingState({Key? key});
}

class MedicationPlanLoadedState extends MedicationPlanState {
  final List<MedicationScheduleEvent> events;
  final List<String> markedAsDone;

  MedicationPlanLoadedState({
    Key? key,
    required this.events,
    required this.markedAsDone,
  });

  List<MedicationScheduleEvent> getEventsByTimeOfTheDay(TimeOfTheDay timeOfTheDay) {
    if (timeOfTheDay == TimeOfTheDay.ifNeeded) {
      throw FlutterError("Not implemented");
    }
    return events.where((element) => element.pillTakingHour.timeOfTheDay == timeOfTheDay).toList();
  }
}
