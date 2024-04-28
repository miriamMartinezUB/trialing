import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:trialing/common/index.dart';
import 'package:trialing/common/navigation/bloc/navigation_bloc.dart';
import 'package:trialing/common/navigation/bloc/navigation_event.dart';
import 'package:trialing/common/navigation/navigation_modal.dart';
import 'package:trialing/resoruces/dimens.dart';
import 'package:trialing/resoruces/palette_colors.dart';
import 'package:trialing/resoruces/routes.dart';
import 'package:trialing/views/texts.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;
    final NavigatorBloc bloc = BlocProvider.of<NavigatorBloc>(context);
    return SafeArea(
      child: Drawer(
          backgroundColor: paletteColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.paddingXLarge),
                  child: Column(
                    children: [
                      DrawerItem(
                        text: translate('home'),
                        iconData: Icons.home_outlined,
                        color: paletteColors.icons,
                        onTap: () => bloc.add(HomeNavigationEvent()),
                      ),
                      DrawerItem(
                        text: translate('history'),
                        iconData: Icons.history,
                        color: paletteColors.icons,
                        onTap: () => bloc.add(PushScreenNavigationEvent(model: NavigationModel(route: Routes.history))),
                      ),
                      DrawerItem(
                        text: translate('settings'),
                        iconData: Icons.settings,
                        color: paletteColors.icons,
                        onTap: () =>
                            bloc.add(PushScreenNavigationEvent(model: NavigationModel(route: Routes.settings))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function() onTap;
  final Color? color;

  const DrawerItem({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = locator<ThemeService>().paletteColors;

    return InkWell(
      onTap: onTap,
      splashColor: paletteColors.primary,
      child: Column(
        children: [
          ListTile(
            title: AppText(
              translate(text),
              type: TextTypes.body,
              color: color,
            ),
            leading: Icon(
              iconData,
              color: color,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
