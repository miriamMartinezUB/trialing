import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/domain/event.dart';
import 'package:trialing/domain/pill_taken_hour.dart';
import 'package:trialing/features/medication_plan/bloc/medication_plan_bloc.dart';
import 'package:trialing/features/medication_plan/views/section_home.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/image_view.dart';
import 'package:trialing/views/page_wrapper/page_wrapper.dart';
import 'package:trialing/views/texts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MedicationPlanBloc bloc = MedicationPlanBloc();
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    final NavigatorBloc navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    return PageWrapper(
      background: paletteColors.primary,
      showAppBar: kIsWeb,
      isMainPage: true,
      appBarName: kIsWeb ? translate('home') : null,
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
                                translate('home'),
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
                        child: BlocBuilder<MedicationPlanBloc, MedicationPlanState>(
                          builder: (context, state) {
                            if (state is MedicationPlanLoadedState) {
                              return Padding(
                                padding: const EdgeInsets.all(Dimens.paddingXLarge),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: TimeOfTheDay.values.length,
                                    itemBuilder: (context, index) {
                                      TimeOfTheDay timeOfTheDay = TimeOfTheDay.values[index];
                                      if (timeOfTheDay == TimeOfTheDay.ifNeeded) {
                                        return const SizedBox();
                                      }
                                      List<MedicationScheduleEvent> events =
                                          state.getEventsByTimeOfTheDay(timeOfTheDay);
                                      if (events.isEmpty) {
                                        return const SizedBox();
                                      }
                                      return SectionHome(
                                        pillTakingHour: PillTakingHour.fromTimeOfTheDay(timeOfTheDay),
                                        events: events,
                                        onTap: (MedicationScheduleEvent event) {
                                          bloc.add(MedicationPlanMarkAsDoneEvent(event: event));
                                        },
                                        done: (String id) {
                                          return state.markedAsDone.contains(id);
                                        },
                                      );
                                    }),
                              );
                            } else {
                              if (state is MedicationPlanInitialState) {
                                bloc.add(MedicationPlanLoadEvent());
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
