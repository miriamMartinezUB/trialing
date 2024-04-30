import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trialing/domain/event.dart';
import 'package:trialing/features/history/history_service.dart';
import 'package:uuid/uuid.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitialState()) {
    HistoryService historyService = HistoryService();
    on<HistoryLoadEvent>((event, emit) {
      emit(HistoryLoadedState(
        key: Key(const Uuid().v4()),
        firstDate: historyService.firstDate,
        lastDate: historyService.lastDate,
        selectedDay: historyService.selectedDay,
        focusedDay: historyService.focusedDay,
        calendarFormat: historyService.calendarFormat,
        events: historyService.selectedEvents,
        getEventsForDay: historyService.getEventsForDay,
      ));
    });
    on<HistoryOnDaySelectedEvent>((event, emit) {
      emit(HistoryLoadingState(key: Key(const Uuid().v4())));
      historyService.onDaySelected(event.selectedDay, event.focusedDay);
      emit(HistoryLoadedState(
        key: Key(const Uuid().v4()),
        firstDate: historyService.firstDate,
        lastDate: historyService.lastDate,
        selectedDay: historyService.selectedDay,
        focusedDay: historyService.focusedDay,
        calendarFormat: historyService.calendarFormat,
        events: historyService.selectedEvents,
        getEventsForDay: historyService.getEventsForDay,
      ));
    });
    on<HistoryOnFormatChangedEvent>((event, emit) {
      emit(HistoryLoadingState(key: Key(const Uuid().v4())));
      historyService.onFormatChanged(event.format);
      emit(HistoryLoadedState(
        key: Key(const Uuid().v4()),
        firstDate: historyService.firstDate,
        lastDate: historyService.lastDate,
        selectedDay: historyService.selectedDay,
        focusedDay: historyService.focusedDay,
        calendarFormat: historyService.calendarFormat,
        events: historyService.selectedEvents,
        getEventsForDay: historyService.getEventsForDay,
      ));
    });
  }
}
