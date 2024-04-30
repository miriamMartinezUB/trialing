import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/resoruces/palette_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SetUp setUp = SetUp();

  await Hive.initFlutter();

  await setUp.initializeSetupServices();

  LocalizationDelegate delegate = locator<LanguageService>().delegate;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(LocalizedApp(delegate, MyApp(setUp)));
  });
}

class MyApp extends StatelessWidget {
  final SetUp setUp;

  const MyApp(this.setUp, {super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageService languageService = locator<LanguageService>();

    return MultiBlocProvider(
      providers: setUp.getProviders(context),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          languageService.delegate,
        ],
        supportedLocales: languageService.supportedLocales,
        locale: languageService.currentLocale,
        theme: ThemeData(
          primarySwatch: PaletteMaterialColors.primary,
        ),
        routerConfig: setUp.router,
      ),
    );
  }
}
