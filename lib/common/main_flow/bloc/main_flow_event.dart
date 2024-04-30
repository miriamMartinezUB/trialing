part of 'main_flow_bloc.dart';

abstract class MainFlowEvent {}

class ChangeMainScreenEvent extends MainFlowEvent {
  final MainPagesId itemId;

  ChangeMainScreenEvent({required this.itemId});
}

class RefreshMainScreenEvent extends MainFlowEvent {}
