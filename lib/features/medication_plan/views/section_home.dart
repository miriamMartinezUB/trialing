import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/data/database.dart';
import 'package:trialing/domain/event.dart';
import 'package:trialing/domain/medication.dart';
import 'package:trialing/domain/pill_taken_hour.dart';
import 'package:trialing/features/medication_plan/views/card_medication_reminder.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/utils/time_of_day_extension.dart';
import 'package:trialing/views/texts.dart';

class SectionHome extends StatelessWidget {
  final PillTakingHour pillTakingHour;
  final List<MedicationScheduleEvent> events;
  final Function(MedicationScheduleEvent event) onTap;
  final bool Function(String id) done;

  const SectionHome({
    Key? key,
    required this.pillTakingHour,
    required this.events,
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
              dosage: event.dosage,
              indications: medication.indications,
              done: done(event.id),
              onTap: () {
                onTap(event);
              },
            );
          },
        ),
        const SizedBox(height: Dimens.paddingXLarge),
      ],
    );
  }
}
