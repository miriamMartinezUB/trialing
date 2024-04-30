import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/features/history/bloc/history_bloc.dart';
import 'package:trialing/features/history/views/calendar_view.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/image_view.dart';
import 'package:trialing/views/page_wrapper/page_wrapper.dart';
import 'package:trialing/views/texts.dart';
import 'package:uuid/uuid.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoryBloc bloc = HistoryBloc();
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
                      child: BlocProvider(
                        create: (context) => bloc,
                        child: BlocBuilder<HistoryBloc, HistoryState>(
                          builder: (context, state) {
                            if (state is HistoryLoadedState) {
                              return Padding(
                                padding: const EdgeInsets.all(Dimens.paddingXLarge),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// The random key is important to refresh it every time and get refresh
                                    /// after change theme
                                    CalendarView(
                                      key: Key(const Uuid().v4()),
                                      firstDate: state.firstDate,
                                      lastDay: state.lastDate,
                                      calendarFormat: state.calendarFormat,
                                      selectedDay: state.selectedDay,
                                      focusedDay: state.focusedDay,
                                      notEvents: "not_taken_medication_events",
                                      eventsForDay: state.events,
                                      getEventsForDay: state.getEventsForDay,
                                      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                                        bloc.add(HistoryOnDaySelectedEvent(
                                            selectedDay: selectedDay, focusedDay: focusedDay));
                                      },
                                      onFormatChanged: (CalendarFormat format) {
                                        bloc.add(HistoryOnFormatChangedEvent(format: format));
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              if (state is HistoryInitialState) {
                                bloc.add(HistoryLoadEvent());
                              }
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                if (!kIsWeb)
                  const Padding(
                    padding: EdgeInsets.all(Dimens.paddingXLarge),
                    child: ImageView(
                      'history.png',
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
