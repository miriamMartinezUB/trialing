import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/page_wrapper/page_wrapper.dart';
import 'package:trialing/views/wave_shape_app_bar.dart';
import 'package:uuid/uuid.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    final NavigatorBloc navigatorBloc = BlocProvider.of<NavigatorBloc>(context);

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
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Dimens.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
