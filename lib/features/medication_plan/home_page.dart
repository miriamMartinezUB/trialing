import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/data/database.dart';
import 'package:trialing/domain/event.dart';
import 'package:trialing/domain/medication.dart';
import 'package:trialing/domain/pill_taken_hour.dart';
import 'package:trialing/features/medication_plan/bloc/medication_plan_bloc.dart';
import 'package:trialing/features/medication_plan/views/card_medication_reminder.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/utils/time_of_day_extension.dart';
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
                                child: Column(
                                  children: [
                                    if (state.fastingEvents.isNotEmpty)
                                      _SectionHome(
                                        pillTakingHour: PillTakingHour.fasting(),
                                        events: state.fastingEvents,
                                        onTap: (MedicationScheduleEvent event) {
                                          bloc.add(MedicationPlanMarkAsDoneEvent(event: event));
                                        },
                                        done: (String id) {
                                          return state.markedAsDone.contains(id);
                                        },
                                      ),
                                    if (state.breakfastEvents.isNotEmpty)
                                      _SectionHome(
                                        pillTakingHour: PillTakingHour.breakfast(),
                                        events: state.breakfastEvents,
                                        onTap: (MedicationScheduleEvent event) {
                                          bloc.add(MedicationPlanMarkAsDoneEvent(event: event));
                                        },
                                        done: (String id) {
                                          return state.markedAsDone.contains(id);
                                        },
                                      ),
                                    if (state.lunchTimeEvents.isNotEmpty)
                                      _SectionHome(
                                        pillTakingHour: PillTakingHour.lunchTime(),
                                        events: state.lunchTimeEvents,
                                        onTap: (MedicationScheduleEvent event) {
                                          bloc.add(MedicationPlanMarkAsDoneEvent(event: event));
                                        },
                                        done: (String id) {
                                          return state.markedAsDone.contains(id);
                                        },
                                      ),
                                    if (state.snackEvents.isNotEmpty)
                                      _SectionHome(
                                        pillTakingHour: PillTakingHour.snack(),
                                        events: state.snackEvents,
                                        onTap: (MedicationScheduleEvent event) {
                                          bloc.add(MedicationPlanMarkAsDoneEvent(event: event));
                                        },
                                        done: (String id) {
                                          return state.markedAsDone.contains(id);
                                        },
                                      ),
                                    if (state.dinnerEvents.isNotEmpty)
                                      _SectionHome(
                                        pillTakingHour: PillTakingHour.dinner(),
                                        events: state.dinnerEvents,
                                        onTap: (MedicationScheduleEvent event) {
                                          bloc.add(MedicationPlanMarkAsDoneEvent(event: event));
                                        },
                                        done: (String id) {
                                          return state.markedAsDone.contains(id);
                                        },
                                      ),
                                    if (state.beforeBedTimeEvents.isNotEmpty)
                                      _SectionHome(
                                        pillTakingHour: PillTakingHour.beforeBedTime(),
                                        events: state.beforeBedTimeEvents,
                                        showDivider: false,
                                        onTap: (MedicationScheduleEvent event) {
                                          bloc.add(MedicationPlanMarkAsDoneEvent(event: event));
                                        },
                                        done: (String id) {
                                          return state.markedAsDone.contains(id);
                                        },
                                      ),
                                  ],
                                ),
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

class _SectionHome extends StatelessWidget {
  final PillTakingHour pillTakingHour;
  final List<MedicationScheduleEvent> events;
  final bool showDivider;
  final Function(MedicationScheduleEvent event) onTap;
  final bool Function(String id) done;

  const _SectionHome({
    Key? key,
    required this.pillTakingHour,
    required this.events,
    this.showDivider = true,
    required this.onTap,
    required this.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Database database = Database();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          '${translate(pillTakingHour.timeOfTheDay.name)} ${pillTakingHour.exactHour.toStr()}',
          type: TextTypes.bodyMedium,
        ),
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: events.length,
          itemBuilder: (context, index) {
            MedicationScheduleEvent event = events[index];
            Medication medication = database.getMedicationById(event.medicationId);
            return CardMedicationReminder(
              title: medication.name,
              description: medication.description,
              indications: medication.indications,
              done: done(event.id),
              onTap: () {
                onTap(event);
              },
            );
          },
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.paddingMedium),
            child: Divider(),
          ),
      ],
    );
  }
}
