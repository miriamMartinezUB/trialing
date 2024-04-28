import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trialing/common/locale_storage_service.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/resoruces/storage_keys.dart';

enum ThemePreference { light, dark }

class ThemeService {
  late LocaleStorageService _localeStorageService;
  late StreamController<bool> themeChange;

  late ThemePreference _theme;

  void init(LocaleStorageService localeStorageService) {
    _localeStorageService = localeStorageService;
    int? themeValue = _localeStorageService.getInt(StorageKeys.themePreference);
    if (themeValue == null) {
      final Brightness brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      _theme = brightness.name == ThemePreference.light.name ? ThemePreference.light : ThemePreference.dark;
      _saveCurrentTheme();
    } else {
      _theme = ThemePreference.values[themeValue];
    }
  }

  ThemePreference get themePreference => _theme;

  PaletteColors get paletteColors => _theme == ThemePreference.light ? PaletteColorsLight() : PaletteColorsDark();

  void setTheme(ThemePreference themePreference) {
    _theme = themePreference;
    themeChange.add(true);
    _saveCurrentTheme();
  }

  void _saveCurrentTheme() => _localeStorageService.saveInt(StorageKeys.themePreference, _theme.index);
}
