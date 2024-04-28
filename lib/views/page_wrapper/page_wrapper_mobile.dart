import 'package:flutter/material.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/trialing_app_bar.dart';

class PageWrapper extends StatelessWidget {
  final Widget body;
  final bool isMainPage;
  final bool showAppBar;
  final String? appBarName;
  final Function? onPop;
  final Color? background;

  PageWrapper({
    Key? key,
    required this.body,
    this.isMainPage = false,
    this.showAppBar = false,
    this.appBarName,
    this.onPop,
    this.background,
  }) : super(key: key) {
    if (showAppBar && appBarName == null) {
      throw FlutterError('If showAppBar is true appBarName attribute is required');
    }
    if (showAppBar && !isMainPage) {
      throw FlutterError('showAppBar and !isMainPage is not compatible');
    }
  }

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    return PopScope(
      canPop: !isMainPage,
      onPopInvoked: (didPop) {
        onPop?.call();
      },
      child: Scaffold(
        backgroundColor: background ?? paletteColors.background,
        appBar: showAppBar
            ? TrialingAppBar(
                isMainPage: isMainPage,
                onPop: onPop,
                appBarName: appBarName!,
              )
            : null,
        body: SafeArea(
          child: body,
        ),
      ),
    );
  }
}
