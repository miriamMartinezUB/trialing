import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/features/settings/bloc/settings_bloc.dart';
import 'package:trialing/features/settings/views/single_select_question_view.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/circular_progress.dart';
import 'package:trialing/views/page_wrapper/page_wrapper.dart';
import 'package:trialing/views/texts.dart';
import 'package:trialing/views/wave_shape_app_bar.dart';
import 'package:uuid/uuid.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsBloc bloc = SettingsBloc();
    final ThemeService themeService = locator<ThemeService>();
    final LanguageService languageService = locator<LanguageService>();
    final NavigatorBloc navigatorBloc = BlocProvider.of<NavigatorBloc>(context);

    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        final PaletteColors paletteColors = themeService.paletteColors;
        if (state is SettingsLoadingState) {
          return const CircularProgress();
        }
        return PageWrapper(
          background: paletteColors.background,
          showAppBar: kIsWeb,
          isMainPage: true,
          appBarName: kIsWeb ? translate('settings') : null,
          onPop: () {
            if (kIsWeb) {
              navigatorBloc.add(BackNavigationEvent());
              navigatorBloc.add(CloseNavigationEvent());
            }
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!kIsWeb) ...[
                WaveShapeAppBar(
                  key: Key(const Uuid().v4()),
                  title: translate('settings'),
                  imagePath: 'settings.png',
                  isMainPage: true,
                ),
                const SizedBox(height: Dimens.paddingXLarge),
              ],
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.paddingLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          translate('language_app'),
                          type: TextTypes.bodyMedium,
                        ),
                        SingleSelectQuestionView(
                          values: languageService.languageCodes,
                          initialValue: languageService.currentLanguageCode,
                          onChange: (String preference) {
                            bloc.add(SettingsOnChangeThemeEvent(themePreference: preference));
                          },
                        ),
                        const SizedBox(height: Dimens.paddingLarge),
                        AppText(
                          translate('theme_app'),
                          type: TextTypes.bodyMedium,
                        ),
                        SingleSelectQuestionView(
                          values: themeService.themes,
                          initialValue: themeService.themePreference.name,
                          onChange: (String preference) {
                            bloc.add(SettingsOnChangeThemeEvent(themePreference: preference));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
