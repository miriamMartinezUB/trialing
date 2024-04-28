import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String nameWithExtension;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const ImageView(
    this.nameWithExtension, {
    Key? key,
    this.height,
    this.width,
    this.boxFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$nameWithExtension',
      height: height,
      width: width,
      fit: boxFit,
    );
  }
}
