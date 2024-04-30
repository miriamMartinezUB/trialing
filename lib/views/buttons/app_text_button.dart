import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/texts.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final bool shouldTranslate;
  final Color? color;
  final GestureTapCallback? onTap;
  final IconData? icon;

  const AppTextButton({Key? key, required this.text, this.shouldTranslate = true, this.color, this.onTap, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;

    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          paletteColors.secondary.withOpacity(0.5),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      ),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: Dimens.paddingSmall)
          ],
          Flexible(
            child: AppText(
              shouldTranslate ? translate(text) : text,
              type: TextTypes.body,
              color: color,
              align: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
