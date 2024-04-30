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
    on<MedicationPlanLoadEvent>((event, emit) async {
      emit(MedicationPlanLoadedState(
        key: Key(const Uuid().v4()),
        events: medicationPlanService.events,
        markedAsDone: medicationPlanService.taken,
      ));
    });
    on<MedicationPlanMarkAsDoneEvent>((event, emit) {
      emit(MedicationPlanLoadingState(key: Key(const Uuid().v4())));
      medicationPlanService.markEventAsDone(event.event);
      emit(MedicationPlanLoadedState(
        key: Key(const Uuid().v4()),
        events: medicationPlanService.events,
        markedAsDone: medicationPlanService.taken,
      ));
    });
  }
}
