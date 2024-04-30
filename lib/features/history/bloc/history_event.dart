part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class HistoryLoadEvent extends HistoryEvent {}

class HistoryOnDaySelectedEvent extends HistoryEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;

  HistoryOnDaySelectedEvent({required this.selectedDay, required this.focusedDay});
}

class HistoryOnFormatChangedEvent extends HistoryEvent {
  final CalendarFormat format;

  HistoryOnFormatChangedEvent({required this.format});
}
