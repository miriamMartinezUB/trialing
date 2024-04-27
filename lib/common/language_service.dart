import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/locale_storage_service.dart';
import 'package:trialing/resoruces/languages.dart';
import 'package:trialing/resoruces/storage_keys.dart';

class LanguageService {
  late LocalizationDelegate _delegate;
  late LocaleStorageService _localeStorageService;

  Future<LocalizationDelegate> initDelegate(LocaleStorageService localeStorageService) async {
    _localeStorageService = localeStorageService;
    String languagePreference = _localeStorageService.getString(StorageKeys.languagePreference);
    _delegate = await LocalizationDelegate.create(
      fallbackLocale: languagePreference.isEmpty ? LanguageCode.byDefault : languagePreference,
      supportedLocales: languageCodes,
      basePath: 'locale',
    );

    return _delegate;
  }

  List<String> get languageCodes {
    return [
      LanguageCode.spanish,
    ];
  }

  List<Locale> get supportedLocales {
    return _delegate.supportedLocales;
  }

  LocalizationDelegate get delegate {
    return _delegate;
  }

  String get currentLanguageCode {
    return _delegate.currentLocale.languageCode;
  }

  Locale get currentLocale {
    return _delegate.currentLocale;
  }

  String get defaultLocaleCode => LanguageCode.byDefault;

  Future<void> changeCurrentLocale(String languageCode) async {
    if (_delegate.currentLocale.languageCode != languageCode) {
      await _delegate.changeLocale(Locale(languageCode, ''));
      await _localeStorageService.saveString(StorageKeys.languagePreference, languageCode);
    }
  }
}
