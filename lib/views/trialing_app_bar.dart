import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/views/buttons/app_back_button.dart';
import 'package:trialing/views/texts.dart';

class TrialingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMainPage;
  final String appBarName;
  final Function? onPop;

  const TrialingAppBar({
    Key? key,
    required this.isMainPage,
    required this.appBarName,
    this.onPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    return AppBar(
      backgroundColor: paletteColors.primary,
      centerTitle: true,
      iconTheme: IconThemeData(color: paletteColors.appBar),
      leading: !isMainPage ? AppBackButton(onPop: onPop) : null,
      actions: isMainPage ? null : [const _HomeButton()],
      title: AppText(
        appBarName,
        type: TextTypes.title,
        align: TextAlign.center,
        color: paletteColors.appBar,
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _HomeButton extends StatelessWidget {
  const _HomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    final NavigatorBloc navigatorBloc = BlocProvider.of<NavigatorBloc>(context);

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
        child: Icon(Icons.home, color: paletteColors.primary),
      ),
      onTap: () => navigatorBloc.add(HomeNavigationEvent()),
    );
  }
}
