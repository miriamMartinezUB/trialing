import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialing/common/index.dart';
import 'package:uuid/uuid.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsLoadedState()) {
    final ThemeService themeService = locator<ThemeService>();
    final LanguageService languageService = locator<LanguageService>();
    on<SettingsOnChangeThemeEvent>((event, emit) {
      emit(SettingsLoadingState(key: Key(const Uuid().v4())));
      themeService.setTheme(event.themePreference);
      emit(SettingsLoadedState(key: Key(const Uuid().v4())));
    });
    on<SettingsOnChangeLanguageEvent>((event, emit) async {
      emit(SettingsLoadingState(key: Key(const Uuid().v4())));
      await languageService.changeCurrentLocale(event.languageCode);
      emit(SettingsLoadedState(key: Key(const Uuid().v4())));
    });
  }
}
