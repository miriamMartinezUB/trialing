import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/domain/event.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/utils/time_of_day_extension.dart';
import 'package:trialing/views/app_card.dart';
import 'package:trialing/views/texts.dart';

class CardEventView extends StatelessWidget {
  final MedicationLogEvent event;

  const CardEventView({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText(
                  translate(event.medicationId.toLowerCase()),
                  type: TextTypes.bodyBold,
                ),
              ),
              event.getTookAtTime()
                  ? Icon(
                      Icons.check_circle,
                      color: paletteColors.primary,
                    )
                  : Icon(
                      Icons.timer_off_outlined,
                      color: paletteColors.error,
                    ),
            ],
          ),
          const SizedBox(height: Dimens.paddingMedium),
          AppText(
            '${translate('taken_hour')}: ${event.pillTakingHour.exactHour.toStr()}',
            type: TextTypes.smallBody,
          ),
          const SizedBox(height: Dimens.paddingMedium),
          AppText(
            '${translate('real_taken_hour')}: ${event.logDate.toTimeOfDay().toStr()}',
            type: TextTypes.smallBody,
          ),
        ],
      ),
    );
  }
}
