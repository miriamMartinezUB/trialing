import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/main_flow/bloc/main_flow_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/navigation_service.dart';

GetIt locator = GetIt.instance;

class SetUp {
  late LocaleStorageService localeStorageService;
  late LanguageService languageService;
  late ThemeService themeService;
  late NavigationService navigationService;
  late HiveStorageService hiveStorageService;
  late LocalNotificationsService localNotificationsService;

  SetUp() {
    localeStorageService = LocaleStorageService();
    languageService = LanguageService();
    themeService = ThemeService();
    navigationService = NavigationService();
    hiveStorageService = HiveStorageService();
    localNotificationsService = LocalNotificationsService();

    locator.registerLazySingleton(() => localeStorageService);
    locator.registerLazySingleton(() => languageService);
    locator.registerLazySingleton(() => themeService);
    locator.registerLazySingleton(() => navigationService);
    locator.registerLazySingleton(() => hiveStorageService);
    locator.registerLazySingleton(() => localNotificationsService);
  }

  /// Warning: the order is important, to keep the dependencies right
  Future<void> initializeSetupServices() async {
    await locator<LocaleStorageService>().init();
    await locator<LanguageService>().initDelegate(localeStorageService);
    locator<ThemeService>().init(localeStorageService);
    await locator<HiveStorageService>().init();
    if (!kIsWeb) {
      await locator<LocalNotificationsService>().init();
    }
  }

  GoRouter get router => navigationService.router;

  /// List of blocs that need to be accessed in all the application
  List<SingleChildWidget> getProviders(BuildContext context) => [
        BlocProvider<NavigatorBloc>(
          create: (context) => NavigatorBloc(0),
        ),
        BlocProvider<MainFlowBloc>(
          create: (context) => MainFlowBloc(),
        ),
      ];
}
