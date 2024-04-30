import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/utils/medication_schedule_event_extension.dart';
import 'package:trialing/views/app_card.dart';
import 'package:trialing/views/show_my_dialog.dart';
import 'package:trialing/views/texts.dart';

class CardMedicationReminder extends StatelessWidget {
  final String title;
  final String description;
  final double dosage;
  final String? indications;
  final bool done;
  final Function() onTap;

  const CardMedicationReminder({
    Key? key,
    required this.title,
    required this.description,
    required this.dosage,
    required this.indications,
    required this.done,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigatorBloc navigatorBloc = BlocProvider.of<NavigatorBloc>(context);

    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          padding: const EdgeInsets.only(left: Dimens.paddingLarge),
          child: AppCard(
            onTap: done
                ? null
                : () {
                    ShowMyDialog(title: 'confirmation_title', actions: [
                      ContentAction(
                        textAction: 'not_yet',
                        onPress: () {
                          navigatorBloc.add(CloseNavigationEvent());
                        },
                      ),
                      ContentAction(
                        textAction: 'confirm',
                        onPress: () {
                          onTap.call();
                          navigatorBloc.add(CloseNavigationEvent());
                        },
                      ),
                    ]).show(context);
                  },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      translate(title),
                      type: TextTypes.smallBodyMedium,
                    ),
                    Row(
                      children: [
                        AppText(
                          dosage.getStr(),
                          type: TextTypes.smallBodyMedium,
                        ),
                        Icon(
                          Icons.medication,
                          color: paletteColors.primary,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: Dimens.paddingMedium),
                if (indications != null) ...[
                  AppText(
                    translate(indications!),
                    type: TextTypes.tinyBodyMedium,
                    color: paletteColors.active,
                  ),
                  const SizedBox(height: Dimens.paddingMedium),
                ],
                AppText(translate(description), type: TextTypes.smallBodyLight),
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Icon(
              Icons.circle,
              color: paletteColors.card,
              size: Dimens.iconMedium,
            ),
            Icon(
              done ? Icons.check_circle : Icons.circle_outlined,
              color: paletteColors.primary,
              size: Dimens.iconMedium,
            ),
          ],
        ),
      ],
    );
  }
}
