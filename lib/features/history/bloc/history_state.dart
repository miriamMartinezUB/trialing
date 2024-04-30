part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {
  HistoryLoadingState({Key? key});
}

class HistoryLoadedState extends HistoryState {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final CalendarFormat calendarFormat;
  final List<MedicationLogEvent> events;
  final List<MedicationLogEvent> Function(DateTime day) getEventsForDay;

  HistoryLoadedState({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.events,
    required this.getEventsForDay,
  });
}
