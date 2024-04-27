import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/common/navigation/navigation_service.dart';
import 'package:trialing/resoruces/routes.dart';

class NavigatorBloc extends Bloc<NavigationEvent, dynamic> {
  final NavigationService _navigationService = locator<NavigationService>();

  NavigatorBloc(initialState) : super(initialState) {
    on<HomeNavigationEvent>((event, emit) => _navigationService.replace(Routes.home));
    on<BackNavigationEvent>((event, emit) => _navigationService.goBack());
    on<CloseNavigationEvent>((event, emit) => _navigationService.close());
    on<PushScreenNavigationEvent>((event, emit) => _navigationService.navigateTo(
          event.model.route,
          arguments: event.model.arguments,
        ));
  }
}
