part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsOnChangeThemeEvent extends SettingsEvent {
  final String themePreference;

  SettingsOnChangeThemeEvent({required this.themePreference});
}

class SettingsOnChangeLanguageEvent extends SettingsEvent {
  final String languageCode;

  SettingsOnChangeLanguageEvent({required this.languageCode});
}
