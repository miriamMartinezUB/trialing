import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/domain/simple_text.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/views/texts.dart';

class SimpleTextView extends StatelessWidget {
  final List<SimpleText> simpleTexts;
  final TextAlign textAlign;
  final TextTypes textTypeContent;
  final TextTypes textTypeTitle;

  const SimpleTextView(
    this.simpleTexts, {
    Key? key,
    this.textAlign = TextAlign.start,
    this.textTypeContent = TextTypes.body,
    this.textTypeTitle = TextTypes.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: Dimens.paddingLarge),
      itemCount: simpleTexts.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (simpleTexts[index].title != null)
              AppText(
                translate(simpleTexts[index].title!),
                align: textAlign,
                type: textTypeTitle,
              ),
            if (simpleTexts[index].text != null)
              AppText(
                translate(simpleTexts[index].text!),
                align: textAlign,
                type: textTypeContent,
              ),
            if (simpleTexts[index].bulletPoints != null && simpleTexts[index].bulletPoints!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.paddingLarge),
                child: BulletPoints(
                  (simpleTexts[index].bulletPoints!),
                  textType: textTypeContent,
                  textAlign: textAlign,
                ),
              ),
            if (index < simpleTexts.length - 1) const SizedBox(height: Dimens.paddingLarge),
          ],
        );
      },
    );
  }
}

class BulletPoints extends StatelessWidget {
  final List<BulletPoint> bulletPoints;
  final TextAlign textAlign;
  final TextTypes textType;

  const BulletPoints(
    this.bulletPoints, {
    Key? key,
    required this.textAlign,
    required this.textType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
      itemCount: bulletPoints.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : Dimens.paddingMedium),
              child: AppText(
                translate(bulletPoints[index].text),
                align: textAlign,
                type: textType,
              ),
            ),
            if (bulletPoints[index].children != null && bulletPoints[index].children!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.paddingLarge),
                child: ChildBulletPoints(
                  bulletPoints[index].children!,
                  textType: textType,
                  textAlign: textAlign,
                ),
              )
          ],
        );
      },
    );
  }
}

class ChildBulletPoints extends StatelessWidget {
  final List<String> children;
  final TextAlign textAlign;
  final TextTypes textType;

  const ChildBulletPoints(
    this.children, {
    Key? key,
    required this.textAlign,
    required this.textType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return AppText(
          translate(children[index]),
          align: textAlign,
          type: textType,
        );
      },
    );
  }
}
