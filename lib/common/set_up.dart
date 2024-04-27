import 'package:get_it/get_it.dart';
import 'package:trialing/common/language_service.dart';

GetIt locator = GetIt.instance;

class SetUp {
  late LanguageService languageService;

  SetUp() {
    locator.registerLazySingleton(() => LanguageService());
  }

  /// Warning: the order is important, to keep the dependencies right
  Future<void> initializeSetupServices() async {
    await locator<LanguageService>().initDelegate();
  }
}
