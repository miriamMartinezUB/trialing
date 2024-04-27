import 'package:trialing/common/navigation/navigation_modal.dart';

abstract class NavigationEvent {}

class BackNavigationEvent extends NavigationEvent {
  BackNavigationEvent();
}

class CloseNavigationEvent extends NavigationEvent {
  CloseNavigationEvent();
}

class HomeNavigationEvent extends NavigationEvent {
  HomeNavigationEvent();
}

class PushScreenNavigationEvent extends NavigationEvent {
  final NavigationModel model;

  PushScreenNavigationEvent({required this.model});
}
