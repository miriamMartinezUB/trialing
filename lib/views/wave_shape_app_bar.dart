import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/buttons/app_back_button.dart';
import 'package:trialing/views/image_view.dart';
import 'package:trialing/views/texts.dart';

class WaveShapeAppBar extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isMainPage;

  const WaveShapeAppBar({
    Key? key,
    required this.title,
    required this.imagePath,
    this.isMainPage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipPath(
          clipper: ProsteBezierCurve(
            position: ClipPosition.bottom,
            list: [
              BezierCurveSection(
                start: const Offset(0, 125),
                top: Offset(screenWidth / 4, 150),
                end: Offset(screenWidth / 2, 135),
              ),
              BezierCurveSection(
                start: Offset(screenWidth / 2, 125),
                top: Offset(screenWidth / 4 * 3, 100),
                end: Offset(screenWidth, 90),
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            height: 150,
            color: paletteColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Dimens.paddingXLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: Dimens.paddingXLarge),
                    if (!isMainPage) ...[
                      const AppBackButton(),
                      const SizedBox(width: Dimens.paddingMedium),
                    ],
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(right: Dimens.iconXLarge),
                        child: AppText(
                          title,
                          color: paletteColors.appBar,
                          type: TextTypes.titleBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingXLarge),
          child: ImageView(
            imagePath,
            height: Dimens.iconXLarge,
          ),
        ),
      ],
    );
  }
}
