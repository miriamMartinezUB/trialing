import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/calendar_view.dart';
import 'package:trialing/views/image_view.dart';
import 'package:trialing/views/page_wrapper/page_wrapper.dart';
import 'package:trialing/views/texts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    final NavigatorBloc navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    return PageWrapper(
      background: paletteColors.primary,
      showAppBar: kIsWeb,
      isMainPage: true,
      appBarName: kIsWeb ? translate('history') : null,
      onPop: () {
        if (kIsWeb) {
          navigatorBloc.add(BackNavigationEvent());
          navigatorBloc.add(CloseNavigationEvent());
        }
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Column(
                  children: [
                    if (!kIsWeb)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimens.paddingXLarge),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: Dimens.paddingXLarge),
                            Expanded(
                              child: AppText(
                                translate('history'),
                                type: TextTypes.titleBold,
                                color: paletteColors.appBar,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: kIsWeb
                            ? null
                            : const BorderRadius.only(
                                topLeft: Radius.circular(Dimens.radiusXLarge),
                                topRight: Radius.circular(Dimens.radiusXLarge),
                              ),
                        color: paletteColors.background,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimens.paddingXLarge),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// The random key is important to refresh it every time and get refresh
                            /// after change theme
                            CalendarView(key: Key('tfgyhbj')),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (!kIsWeb)
                  const Padding(
                    padding: EdgeInsets.all(Dimens.paddingXLarge),
                    child: ImageView(
                      'medication_schedule.png',
                      height: Dimens.iconXLarge,
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
