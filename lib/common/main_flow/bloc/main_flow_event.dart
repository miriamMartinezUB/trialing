part of 'main_flow_bloc.dart';

abstract class MainFlowEvent {}

class ChangeMainScreenEvent extends MainFlowEvent {
  final DrawerItemId itemId;
  ChangeMainScreenEvent({required this.itemId});
}
