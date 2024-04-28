import 'package:flutter/material.dart';
import 'package:trialing/common/index.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.black12,
        valueColor: AlwaysStoppedAnimation<Color>(
          locator<ThemeService>().paletteColors.primary,
        ),
      ),
    );
  }
}
