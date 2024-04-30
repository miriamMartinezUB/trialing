part of 'settings_bloc.dart';

abstract class SettingsState {}

class SettingsLoadingState extends SettingsState {
  SettingsLoadingState({Key? key});
}

class SettingsLoadedState extends SettingsState {
  SettingsLoadedState({Key? key});
}
