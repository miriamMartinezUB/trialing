import 'package:flutter/material.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Function()? onTap;

  const AppCard({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: Dimens.paddingLarge),
        padding: const EdgeInsets.all(Dimens.paddingLarge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.radiusMedium),
          color: paletteColors.card,
          boxShadow: [
            BoxShadow(
              color: paletteColors.shadow,
              blurRadius: 2.5,
              spreadRadius: 0.5,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
