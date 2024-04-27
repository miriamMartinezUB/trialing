import 'package:get_it/get_it.dart';
import 'package:trialing/common/language_service.dart';
import 'package:trialing/common/locale_storage_service.dart';

GetIt locator = GetIt.instance;

class SetUp {
  late LocaleStorageService localeStorageService;
  late LanguageService languageService;

  SetUp() {
    locator.registerLazySingleton(() => LocaleStorageService());
    locator.registerLazySingleton(() => LanguageService());
  }

  /// Warning: the order is important, to keep the dependencies right
  Future<void> initializeSetupServices() async {
    await locator<LocaleStorageService>().init();
  }
}
