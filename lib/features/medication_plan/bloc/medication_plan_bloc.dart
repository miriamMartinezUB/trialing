import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialing/domain/event.dart';
import 'package:trialing/domain/pill_taken_hour.dart';
import 'package:trialing/features/medication_plan/medication_plan_service.dart';
import 'package:uuid/uuid.dart';

part 'medication_plan_event.dart';
part 'medication_plan_state.dart';

class MedicationPlanBloc extends Bloc<MedicationPlanEvent, MedicationPlanState> {
  MedicationPlanBloc() : super(MedicationPlanInitialState()) {
    MedicationPlanService medicationPlanService = MedicationPlanService();
    List<MedicationScheduleEvent> fastingEvents = medicationPlanService.events
        .where((element) => element.pillTakingHour.timeOfTheDay == TimeOfTheDay.fasting)
        .toList();
    List<MedicationScheduleEvent> breakfastEvents = medicationPlanService.events
        .where((element) => element.pillTakingHour.timeOfTheDay == TimeOfTheDay.breakfast)
        .toList();
    List<MedicationScheduleEvent> lunchTimeEvents = medicationPlanService.events
        .where((element) => element.pillTakingHour.timeOfTheDay == TimeOfTheDay.lunchTime)
        .toList();
    List<MedicationScheduleEvent> snackEvents = medicationPlanService.events
        .where((element) => element.pillTakingHour.timeOfTheDay == TimeOfTheDay.snack)
        .toList();
    List<MedicationScheduleEvent> dinnerEvents = medicationPlanService.events
        .where((element) => element.pillTakingHour.timeOfTheDay == TimeOfTheDay.dinner)
        .toList();
    List<MedicationScheduleEvent> beforeBedTimeEvents = medicationPlanService.events
        .where((element) => element.pillTakingHour.timeOfTheDay == TimeOfTheDay.beforeBedTime)
        .toList();
    on<MedicationPlanLoadEvent>((event, emit) async {
      emit(MedicationPlanLoadedState(
        key: Key(const Uuid().v4()),
        fastingEvents: fastingEvents,
        breakfastEvents: breakfastEvents,
        lunchTimeEvents: lunchTimeEvents,
        snackEvents: snackEvents,
        dinnerEvents: dinnerEvents,
        beforeBedTimeEvents: beforeBedTimeEvents,
        markedAsDone: medicationPlanService.taken,
      ));
    });
    on<MedicationPlanMarkAsDoneEvent>((event, emit) {
      emit(MedicationPlanLoadingState(key: Key(const Uuid().v4())));
      medicationPlanService.markEventAsDone(event.event);
      emit(MedicationPlanLoadedState(
        key: Key(const Uuid().v4()),
        fastingEvents: fastingEvents,
        breakfastEvents: breakfastEvents,
        lunchTimeEvents: lunchTimeEvents,
        snackEvents: snackEvents,
        dinnerEvents: dinnerEvents,
        beforeBedTimeEvents: beforeBedTimeEvents,
        markedAsDone: medicationPlanService.taken,
      ));
    });
  }
}
